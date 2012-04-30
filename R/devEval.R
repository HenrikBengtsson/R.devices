###########################################################################/**
# @RdocFunction devEval
#
# @title "Opens a new device, evaluate (graphing) code, and closes device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{type}{Specifies the type of device to be used by
#     @see "R.utils::devNew".}
#   \item{expr}{The @expression of graphing commands to be evaluated.}
#   \item{envir}{The @environment where \code{expr} should be evaluated.}
#   \item{name, tags}{The fullname name of the image is specified
#     as the name with optional comma-separated tags appended.}
#   \item{ext}{The filename extension of the image file generated, if any.
#    By default, it is inferred from argument \code{type}.}
#   \item{...}{Additional arguments passed to @see "R.utils::devNew".}
#   \item{filename}{The filename of the image saved, if any.
#     See also below.}
#   \item{path}{The directory where then image should be saved, if any.}
#   \item{field}{An optional @character string specifying a specific
#     field of the named result @list to be returned.}
#   \item{onIncomplete}{A @character string specifying what to do with
#     an image file that was incompletely generated due to an interrupt
#     or an error.}
#   \item{force}{If @TRUE, and the image file already exists, then it is
#     overwritten, otherwise not.}
# }
#
# \value{
#   Returns a named @list with items specifying for instance
#   the pathname, the fullname etc of the generated image.
#   If argument \code{field} is given, then the value of the
#   corresponding element is returned.
#   \emph{Note that the return value may be changed in future releases.}
# }
#
# \section{Generated image file}{
#   If created, the generated image file is saved in the directory
#   specfied by argument \code{path} with a filename consisting of
#   the \code{name} followed by optional comma-separated \code{tags}
#   and a filename extension given by argument \code{ext}.
#
#   By default, the image file is only created if the \code{expr}
#   is evaluated completely.  If it is, for instance, interrupted
#   by the user or due to an error, then any incomplete/blank image
#   file that was created will be removed.  This behavior can be
#   turned of using argument \code{onIncomplete}.
# }
#
# @examples "../incl/devEval.Rex"
#
# @author
#
# \seealso{
#   To change default device parameters such as the width or the height,
#   @see "devOptions".
#   @see "devNew".
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devEval <- function(type=getOption("device"), expr, envir=parent.frame(), name="Rplot", tags=NULL, ..., ext=substitute(type), filename=sprintf("%s.%s", paste(c(name, tags), collapse=","), ext), path=getOption("devEval/args/path", "figures/"), field=NULL, onIncomplete=c("remove", "rename", "keep"), force=getOption("devEval/args/force", TRUE)) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'filename' & 'path':
  pathname <- Arguments$getWritablePathname(filename, path=path);

  # Argument 'name' and 'tags':
  fullname <- paste(c(name, tags), collapse=",");
  fullname <- unlist(strsplit(fullname, split=",", fixed=TRUE));
  fullname <- trim(fullname);
  fullname <- fullname[nchar(fullname) > 0];
  fullname <- paste(fullname, collapse=",");

  # Argument 'field':
  if (!is.null(field)) {
    field <- Arguments$getCharacter(field);
  }

  # Argument 'onIncomplete':
  onIncomplete <- match.arg(onIncomplete);

  # Argument 'force':
  force <- Arguments$getLogical(force);



  # Result object
  res <- list(
    type = type,
    name = name,
    tags = tags,
    fullname = fullname,
    filename = filename,
    path = path,
    pathname = pathname
  );

  if (force || !isFile(pathname)) {
    done <- FALSE;

    devNew(type, pathname, ...);
    on.exit({
      devDone();

      # Archive file?
      if (isPackageLoaded("R.archive")) {
        # To please R CMD check
        getArchiveOption <- archiveFile <- NULL;
        if (getArchiveOption("devEval", FALSE)) archiveFile(pathname);
      }

      if (!done && isFile(pathname)) {
        if (onIncomplete == "remove") {
          # Remove incomplete image file
          file.remove(pathname);
        } else if (onIncomplete == "rename") {
          # Rename incomplete image file to denote that
          # it is incomplete.
          pattern <- "^(.*)[.]([^.]*)$";
          if (regexpr(pattern, pathname) != -1) {
            fullname <- gsub(pattern, "\\1", pathname);
            ext <- gsub(pattern, "\\2", pathname);
            fmtstr <- sprintf("%s,INCOMPLETE_%%03d.%s", fullname, ext);
          } else {
            fmtstr <- sprintf("%s,INCOMPLETE_%%03d", pathname);
          }

          # Try to rename
          for (kk in 1:999) {
            pathnameN <- sprintf(fmtstr, kk);
            if (isFile(pathnameN)) next;
            res <- file.rename(pathname, pathnameN);
            # Done?
            if (res && isFile(pathnameN)) {
              pathname <- pathnameN;
              break;
            }
          } # for (kk ...)

          # Failed to rename?
          if (isFile(pathname)) {
            throw("Failed to rename incomplete image file: ", pathname);
          }
        } # if (onIncomplete == ...)
      } # if (!done && isFile(...))
    }, add=TRUE);
  
    eval(expr, envir=envir);
    done <- TRUE;
  }

  # Subset?
  if (!is.null(field)) {
    res <- res[[field]];
  }

  res;
} # devEval()


############################################################################
# HISTORY: 
# 2012-04-30
# o Extracted devEval() to devEval.R.
# 2012-04-05
# o Now devEval() returns the correct pathname if onIncomplete="rename"
#   and image file was incomplete.  Now it also gives an error, if it
#   for some reason fails to rename the file in such cases.
# 2012-04-04
# o Now it is possible to have devEval() rename incompletely generated
#   image files, by using argument onIncomplete="rename".
# 2012-02-28
# o Added argument 'onIncomplete' to devEval().  The default is now to
#   remove any half-generated image files so that no incomplete/blank
#   image files are left behind.
# 2011-10-31
# o Added argument 'field' to devEval().
# 2011-04-12
# o Now devEval("jpg", ...) is recognized as devEval("jpeg", ...).
# 2011-03-29
# o Now argument 'force' of devEval() defaults to 
#   getOption("devEval/args/force", TRUE).
# 2011-03-18
# o Now devEval() does a better job of "cleaning up" 'name' and 'tags'.
# o Now argument 'path' of devEval() defaults to 
#   getOption("devEval/args/path", "figures/").
# 2011-03-16
# o Now R.archive:ing is only done if the R.archive package is loaded.
# 2011-03-09
# o Added support for automatic file archiving in devEval().
# 2011-02-20
# o Changed argument 'force' of devEval() to default to TRUE.
# o Added argument 'par' to devNew() allowing for applying graphical
#   settings at same time as the device is opened, which is especially
#   useful when using devEval().
# 2011-02-14
# o Now devEval() returns a named list.
# 2011-02-13
# o Added devEval().
############################################################################
