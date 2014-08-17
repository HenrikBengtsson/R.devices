###########################################################################/**
# @RdocFunction devIsOpen
#
# @title "Checks if zero or more devices are open or not"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a named @logical @vector with @TRUE if a device is open,
#   otherwise @FALSE.
# }
#
# @examples "../incl/deviceUtils.Rex"
#
# @author
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devIsOpen <- function(which=dev.cur(), ...) {
  # Nothing to do?
  if (length(which) == 0L) {
    res <- logical(0L);
    names(res) <- character(0L);
    return(res);
  }

  devList <- .devList();
  devs <- devList[which];

  labels <- names(devs);
  isOpen <- sapply(devs, FUN=function(dev) !is.null(dev) && nzchar(dev));
  isOpen <- isOpen & !is.na(labels);
  isOpen;
} # devIsOpen()





###########################################################################/**
# @RdocFunction devList
#
# @title "Lists the indices of the open devices named by their labels"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{interactiveOnly}{If @TRUE, only open interactive/screen devices
#     are returned.}
#   \item{dropNull}{If @TRUE, the "null" device (device index 1) is
#     not returned.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a named @integer @vector.
# }
#
# @author
#
# \seealso{
#   \code{\link[grDevices:dev]{dev.list}()}.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devList <- function(interactiveOnly=FALSE, dropNull=TRUE, ...) {
  devList <- .devList();

  # Return only opened devices
  isOpen <- sapply(devList, FUN=function(dev) (dev != ""));
  names(isOpen) <- names(devList);
  idxs <- which(isOpen);

  # Exclude the "null" device?
  if (dropNull) {
    idxs <- idxs[-1L];
  }

  # Include only interactive devices?
  if (interactiveOnly) {
    types <- unlist(devList[idxs]);
    keep <- devIsInteractive(types);
    idxs <- idxs[keep];
  }

  idxs;
} # devList()



###########################################################################/**
# @RdocFunction devGetLabel
#
# @title "Gets the labels of zero or more devices"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character @vector.
#   If a device does not exist, an error is thrown.
# }
#
# @author
#
# \seealso{
#   @see "devSetLabel" and @see "devList".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devGetLabel <- function(which=dev.cur(), ...) {
  devList <- devList(dropNull=FALSE);
  if (is.numeric(which)) {
    devs <- devList[match(which, devList)];
  } else {
    devs <- devList[which];
  }
  labels <- names(devs);
  unknown <- which[is.na(labels)];
  if (length(unknown) > 0L) {
    known <- names(devList(dropNull=FALSE));
    if (length(known) == 0L) known <- "<none>";
    throw(sprintf("Cannot get device label. No such device: %s (known devices: %s)", paste(sQuote(unknown), collapse=", "), paste(sQuote(known), collapse=", ")));
  }
  labels;
} # devGetLabel()



###########################################################################/**
# @RdocFunction devSetLabel
#
# @title "Sets the label of a device"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{label}{A @character string.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @see "devGetLabel" and @see "devList".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devSetLabel <- function(which=dev.cur(), label, ...) {
  # Argument 'which':
  if (length(which) != 1L) {
    throw("Argument 'which' must be a scalar: ", paste(which, collapse=", "));
  }

  devList <- .devList();
  if (is.numeric(which)) {
    idx <- which;
  } else {
    idx <- .devIndexOf(which);
  }

  # Unknown devices?
  if (devList[[idx]] == "") {
    known <- names(devList(dropNull=FALSE));
    if (length(known) == 0L) known <- "<none>";
    throw(sprintf("Cannot set device label. No such device: %s (known devices: %s)", paste(sQuote(which), collapse=", "), paste(sQuote(known), collapse=", ")));
  }

  # Update the label
  if (is.null(label))
    label <- "";
  names(devList)[which] <- label;

  assign(".Devices", devList, envir=baseenv());
}





###########################################################################/**
# @RdocFunction devSet
#
# @title "Activates a device"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).
#     If neither, then a label corresponding to the checksum of
#     \code{which} as generated by @see "digest::digest" is used.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns what \code{\link[grDevices:dev]{dev.set}()} returns.
# }
#
# @author
#
# \seealso{
#   @see "devOff" and @see "devDone".
#   Internally, \code{\link[grDevices:dev]{dev.set}()} is used.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devSet <- function(which=dev.next(), ...) {
  args <- list(...);

  # Argument 'which':
  if (!is.numeric(which) || length(which) != 1L) {
    if (length(which) != 1L || !is.character(which)) {
      require("digest") || throw("Package not loaded: digest");
      # To please R CMD check
      digest <- NULL; rm(list="digest");
      which <- digest(which);
    }

    if (is.character(which)) {
      args$label <- which;
      which <- .devIndexOf(which, error=FALSE);
      # If not existing, open the next available one
      if (is.na(which))
        which <- .devNextAvailable();
    }
  }

  # Argument 'which':
  if (length(which) != 1L) {
    throw("Argument 'which' must be a scalar: ", paste(which, collapse=", "));
  }

  if (which < 2L || which > 63L) {
    throw("Cannot set device: Argument 'which' is out of range [2,63]: ", which);
  }

  if (devIsOpen(which)) {
    # Active already existing device
    return(dev.set(which));
  }

  # Identify set devices that needs to be opened inorder for
  # the next device to get the requested index
  if (which == 2L) {
    toBeOpened <- c();
  } else {
    toBeOpened <- setdiff(2:(which-1L), dev.list());
  }

  len <- length(toBeOpened);
  if (len > 0L) {
    tempfiles <- sapply(toBeOpened, FUN=function(...) tempfile());

    # Make sure to close all temporary devices when exiting function
    on.exit({
      for (kk in seq_along(toBeOpened)) {
        dev.set(toBeOpened[kk]);
        dev.off();
        if (file.exists(tempfiles[kk])) file.remove(tempfiles[kk]);
      }
    }, add=TRUE);

    # Create a dummy temporary postscript device (which is non-visible)
    for (kk in seq_along(toBeOpened)) {
      postscript(file=tempfiles[kk]);
    }
  }

  # Open the device
  res <- do.call("devNew", args=args);

  invisible(res);
} # devSet()




###########################################################################/**
# @RdocFunction devOff
#
# @title "Closes zero or more devices"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns \code{\link[grDevices:dev]{dev.cur}()}.
# }
#
# @author
#
# \seealso{
#   @see "devDone".
#   Internally, \code{\link[grDevices:dev]{dev.off}()} is used.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devOff <- function(which=dev.cur(), ...) {
  # Nothing to do?
  if (length(which) == 0L) return(dev.cur());

  # Only close each device once
  which <- unique(which);
  if (length(which) > 1L) {
    lapply(which, FUN=devOff);
    return(dev.cur());
  }

  # Nothing to do?
  if (!devIsOpen(which)) {
    return(dev.cur());
  }

  # Identify device
  which <- devSet(which);

  # Reset the label
  devSetLabel(which, label=NULL);

  # Close device
  dev.off(which);

  return(dev.cur());
} # devOff()




###########################################################################/**
# @RdocFunction devDone
#
# @title "Closes zero or more open devices except screen (interactive) devices"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns (invisibly) \code{\link[grDevices:dev]{dev.cur}()}.
# }
#
# @author
#
# \seealso{
#   @see "devOff".
#   @see "grDevices::dev.interactive".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devDone <- function(which=dev.cur(), ...) {
  # Nothing to do?
  if (length(which) == 0L) return(dev.cur());

  # Only close each device once
  which <- unique(which);
  if (length(which) > 1L) {
    lapply(which, FUN=devDone);
    return(dev.cur());
  }

  # Nothing to do?
  if (!devIsOpen(which)) {
    return(invisible(dev.cur()));
  }

  # Do nothing?
  if (is.numeric(which) && length(which) == 1L && which <= 1L) {
    return(invisible(dev.cur()));
  }

  which <- devSet(which);
  if (which != 1L) {
    type <- tolower(names(which));
    type <- gsub(":.*", "", type);

    isOnScreen <- (is.element(type, deviceIsInteractive()));
    if (!isOnScreen)
      devOff(which);
  }

  return(invisible(dev.cur()));
} # devDone()


###########################################################################/**
# @RdocFunction devIsInteractive
#
# @title "Checks whether a device type is interactive or not"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{types}{A @character @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a @logical @vector with @TRUE if the device type is interactive,
#   otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   Internally, @see "grDevices::deviceIsInteractive" is used.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devIsInteractive <- function(types, ...) {
  # Nothing to do?
  if (length(types) == 0L) {
    res <- logical(0L);
    names(res) <- character(0L);
    return(res);
  }

  if (length(types) > 1L) {
    res <- sapply(types, FUN=devIsInteractive);
    if (is.character(types)) names(res) <- types;
    return(res);
  }


  # Sanity check
  stopifnot(length(types) == 1L);

  # Investigate one type below
  type0 <- type <- types;

  # A known interactive device?
  knownInteractive <- grDevices::deviceIsInteractive();

  if (is.function(type)) {
    for (name in knownInteractive) {
      if (exists(name, mode="function")) {
        dev <- get(name, mode="function");
        if (identical(dev, type)) {
          res <- TRUE;
          names(res) <- name;
          return(res);
        }
      }
    }
    res <- FALSE;
    names(res) <- NA_character_;
  } else {
    type <- as.character(type);
    # Device type aliases?
    type <- .devTypeName(type);
    type <- tolower(type);
    # An known one?
    res <- is.element(type, tolower(knownInteractive));
    names(res) <- type0;
  }

  res;
} # devIsInteractive()



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# BEGIN: Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.devList <- function() {
  if (exists(".Devices")) {
    devList <- get(".Devices");
  } else {
    devList <- list("null device");
  }

  labels <- names(devList);
  if (is.null(labels)) {
    labels <- paste("Device", seq(along=devList), sep=" ");
    names(devList) <- labels;
    assign(".Devices", devList, envir=baseenv());
  } else {
    # Update the names
    labels <- names(devList);
    idxs <- which(nchar(labels) == 0L);
    if (length(idxs) > 0L) {
      labels[idxs] <- paste("Device", idxs, sep=" ");
    }
    names(devList) <- labels;
  }

  devList;
} # .devList()

.devIndexOf <- function(labels, error=TRUE) {
  # Nothing to do?
  if (length(labels) == 0L) {
    res <- integer(0L);
    names(res) <- character(0L);
    return(res);
  }

  devList <- devList(dropNull=FALSE);
  idxs <- match(labels, names(devList));
  names(idxs) <- labels;

  # Sanity check
  if (error) {
    if (any(is.na(idxs)))
      throw("No such device: ", paste(labels[is.na(idxs)], collapse=", "));
  }

  idxs;
} # .devIndexOf()


.devNextAvailable <- function() {
  # All open devices
  devList <- dev.list();

  if (length(devList) == 0L)
    return(2L);

  devPossible <- seq(from=2L, to=max(devList)+1L);
  devFree <- setdiff(devPossible, devList);

  devFree[1L];
} # .devNextAvailable()


.devTypeName <- function(types, ...) {
  # Nothing todo?
  if (!is.character(types)) {
    return(types);
  }

  types0 <- types;
#  types <- tolower(types);

  # Common aliases
  types[types == "jpg"] <- "jpeg";
  types[types == "ps"] <- "postscript";

  names(types) <- types0;

  types;
} # .devTypeName()


.devEqualTypes <- (function() {
   # Recorded known results
   known <- list();

   function(type, other, args=list()) {
     # (a) Same types?
     if (identical(unname(type), unname(other))) return(TRUE);

     # (b) A known equality?
     if (is.character(type) && is.character(other)) {
       res <- known[[type]][other];
       if (is.logical(res)) return(res);
     }

     # (c) Comparing to a device function?
     if (is.function(type) && is.character(other)) {
       if (!exists(other, mode="function")) return(FALSE);
       otherT <- get(other, mode="function");
       if (identical(unname(type), unname(otherT))) return(TRUE);
     } else if (is.function(other) && is.character(type)) {
       if (!exists(type, mode="function")) return(FALSE);
       typeT <- get(type, mode="function");
       if (identical(unname(typeT), unname(other))) return(TRUE);
     }

     # (d) Check if temporarily opening the requested type actually
     # creates a device matching the existing one.
     do.call(type, args=args);
     on.exit(dev.off(), add=TRUE);
     typeT <- names(dev.cur());

     if (is.function(other)) {
       do.call(other, args=args);
       on.exit(dev.off(), add=TRUE);
       other <- names(dev.cur());
     }

     res <- (typeT == other);

     # Record result to avoid opening next?
     if (is.character(type) && is.character(other)) {
       known[[type]][other] <<- res;
     }

     res;
  }
})() # .devEqualTypes()


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# END: Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

############################################################################
# HISTORY:
# 2014-04-27
# o Added .devEqualTypes().
# 2013-10-29
# o ROBUSTESS/BUG FIX: devSet(which) where 'which' is a very large number
#   could leave lots of stray temporary devices open when error "too many
#   open devices" occurred.  Now all temporary devices are guaranteed to
#   be closed also when there is an error.
# 2013-10-28
# o BUG FIX: dev(Get|Set)Label(which) would not handle the case when
#   the device specified by an numeric 'which' and there is a
#   gap in the device list.
# o Added argument 'interactiveOnly' to devList().
# o ROBUSTNESS: Now devSet() is guaranteed to close all temporary
#   devices it opens.
# 2013-10-15
# o BUG FIX: devSet(key), where 'key' is a non-integer object (which is
#   coerced to a device label via digest()), stopped working due to a too
#   conservative test.
# 2013-09-24
# o CONSISTENCY: Now devList() returns an empty integer vector
#   (instead of NULL) if no open devices exists.
# o Now devOff() and devDone() checks if device is opened before trying
#   to close it.  This avoids opening and closing of non-opened devices.
# o ROBUSTNESS: The device functions that are not vectorize do now
#   throw an informative error if passed a vector.
# o GENERALIZATION: Vectorized devIsOpen(), devGetLabel(), and
#   devIsInteractive().
# o Vectorized internal .devIndexOf().
# o Added argument 'dropNull' to devList().
# 2013-08-27
# o Added devIsInteractive().
# o Added .devTypeName().
# 2012-11-18
# o Replaced all stop() with throw().
# 2012-04-30
# o Moved devNew() to devNew.R.
# o Moved devEval() to devEval.R.
# 2011-11-05
# o Now the default 'width' is inferred from devOptions() is 'height'
#   is not given and aspectRatio != 1.
# 2011-03-16
# o Now R.archive:ing is only done if the R.archive package is loaded.
# o DOCUMENTATION: The title of devDone() was incorrect.
# 2008-10-26
# o Now argument 'which' to devSet() can be any object.  If not a single
#   numeric or a single character string, then a checksum character string
#   is generated using digest::digest(which).
# 2008-10-16
# o Now devDone(which=1) does nothing.  Before it gave an error.
# 2008-08-01
# o Added devList() and removed devLabels().
# o Added internal .devNextAvailable().
# o Added argument 'error=TRUE' to internal .devIndexOf().
# 2008-07-31
# o Now devSet(idx) opens a new device with index 'idx' if not already
#   opened.
# 2008-07-29
# o Using term 'label' instead of 'name' everywhere, e.g. devLabels().
#   This was changed because the help pages on 'dev.list' etc. already
#   use the term 'name' for a different purpose, e.g. 'windows'.
# 2008-07-18
# o Created.
############################################################################
