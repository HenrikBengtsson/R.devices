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
#   \item{type}{Specifies the type of device to be used by @see "devNew".}
#   \item{expr}{The @expression of graphing commands to be evaluated.}
#   \item{envir}{The @environment where \code{expr} should be evaluated.}
#   \item{name, tags, sep}{The fullname name of the image is specified
#     as the name with optional \code{sep}-separated tags appended.}
#   \item{ext}{The filename extension of the image file generated, if any.
#    By default, it is inferred from argument \code{type}.}
#   \item{...}{Additional arguments passed to @see "devNew".}
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
#   Returns a @see "DevEvalFileProduct" if the device generated an
#   image file, otherwise an @see "DevEvalProduct".
#   If argument \code{field} is given, then the field of the
#   @see "DevEvalProduct" is returned instead.
#   \emph{Note that the default return value may be changed in future releases.}
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
devEval <- function(type=getOption("device"), expr, envir=parent.frame(), name="Rplot", tags=NULL, sep=getOption("devEval/args/sep", ","), ..., ext=if (is.character(type)) type else substitute(type), filename=sprintf("%s.%s", paste(c(name, tags), collapse=sep), ext), path=getOption("devEval/args/path", "figures/"), field=getOption("devEval/args/field", NULL), onIncomplete=c("remove", "rename", "keep"), force=getOption("devEval/args/force", TRUE)) {
  # WORKAROUND: Until Arguments$...() can be called without
  # attaching R.utils. /HB 2013-07-03
  pkgName <- "R.utils";
  require(pkgName, character.only=TRUE) || throw("Package not loaded: R.utils");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'type':
  if (is.function(type)) {
  } else {
    type <- as.character(type);
    type <- .devTypeName(type);
  }

  # Argument 'filename' & 'path':
  pathname <- Arguments$getWritablePathname(filename, path=path);

  # Argument 'name' and 'tags':
  fullname <- paste(c(name, tags), collapse=sep);
  fullname <- unlist(strsplit(fullname, split=sep, fixed=TRUE));
  fullname <- sub("^[\t\n\f\r ]*", "", fullname); # trim tags
  fullname <- sub("[\t\n\f\r ]*$", "", fullname); #
  fullname <- fullname[nchar(fullname) > 0L];     # drop empty tags
  fullname <- paste(fullname, collapse=sep);

  # Argument 'field':
  if (!is.null(field)) {
    field <- Arguments$getCharacter(field);
  }

  # Argument 'onIncomplete':
  onIncomplete <- match.arg(onIncomplete);

  # Argument 'force':
  force <- Arguments$getLogical(force);


  # An interactive/non-file device?
  isInteractive <- devIsInteractive(type);

  # Result object
  if (isInteractive) {
    res <- DevEvalProduct(name=name, tags=tags, type=type);
  } else {
    res <- DevEvalFileProduct(pathname, type=type);
  }

  if (force || !isFile(pathname)) {
    done <- FALSE;

    if (isInteractive) {
      devIdx <- devNew(type, ...);
    } else {
      devIdx <- devNew(type, pathname, ...);
    }
    on.exit({
      # Make sure to close the device (the same that was opened)
      if (!is.null(devIdx)) devDone(devIdx);

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
          if (regexpr(pattern, pathname) != -1L) {
            fullname <- gsub(pattern, "\\1", pathname);
            ext <- gsub(pattern, "\\2", pathname);
            fmtstr <- sprintf("%s,INCOMPLETE_%%03d.%s", fullname, ext);
          } else {
            fmtstr <- sprintf("%s,INCOMPLETE_%%03d", pathname);
          }

          # Try to rename
          for (kk in seq_len(999L)) {
            pathnameN <- sprintf(fmtstr, kk);
            if (isFile(pathnameN)) next;
            resT <- file.rename(pathname, pathnameN);
            # Done?
            if (resT && isFile(pathnameN)) {
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

  # Close it here to make sure the image file is created.
  # This is needed if field="dataURI" (which triggers are read
  # of the image file).
  if (done) {
    devDone(devIdx);
    devIdx <- NULL;
  }

  # Subset?
  if (!is.null(field)) {
    res <- res[[field]];
  }

  res;
} # devEval()


############################################################################
# HISTORY:
# 2013-08-27
# o Now devEval() utilizes devIsInteractive().
# 2013-08-17
# o BUG FIX/ROBUSTNESS: Argument 'ext' of devEval() can now be inferred
#   from argument 'type' also when 'type' is passed via a string variable.
# 2013-07-29
# o Now devEval() returns a list of class 'DevEvalFile'.
# 2013-07-15
# o Added argument 'sep' to devEval() together with an option to set
#   its default value.
# 2013-04-04
# o ROBUSTNESS: Now devEval() does a better job of making sure to close
#   the same device as it opened.  Previously it would close the current
#   active device, which would not be the correct one if for instance
#   other devices had been open in the meanwhile/in parallel.
# 2013-02-23
# o Now argument 'field' for devEval() defaults to
#   getOption("devEval/args/field", NULL).
# 2012-08-21
# o DOCUMENTATION: Link to devNew() help was broken.
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
