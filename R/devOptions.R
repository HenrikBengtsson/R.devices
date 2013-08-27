###########################################################################/**
# @RdocFunction devOptions
#
# @title "Gets the default device options"
#
# \description{
#  @get "title" as given by predefined devices options adjusted for
#  the default arguments of the device function.
# }
#
# @synopsis
#
# \arguments{
#   \item{type}{A @character string or a device @function specifying
#      the device to be queried.  May also be a @vector, for querying
#      device options for multiple devices.}
#   \item{custom}{If @TRUE, also the default settings specific to this
#      function is returned. For more details, see below.}
#   \item{special}{A @logical.  For more details, see below.}
#   \item{drop}{If @TRUE and only one device type is queried, then
#      a @list is returned, otherwise a @matrix.}
#   \item{options}{Optional named @list of settings.}
#   \item{...}{Optional named arguments for setting new defaults.
#      For more details, see below.}
#   \item{reset}{If @TRUE, the device options are reset to R defaults.}
# }
#
# \value{
#   If \code{drop=TRUE} and a single device is queries, a named @list is
#   returned, otherwise a @matrix is returned.
#   If a requested device is not implemented/supported on the current system,
#   then "empty" results are returned.
#   If options were set, that is, if named options were specified via
#   \code{...}, then the list is returned invisibly, otherwise not.
# }
#
# \details{
#  If argument \code{special} is @TRUE, then the 'width' and 'height'
#  options are adjusted according to the rules explained for
#  argument 'paper' in @see "grDevices::pdf", @see "grDevices::postscript",
#  and @see "grDevices::xfig".
# }
#
# \section{Setting new defaults}{
#  When setting device options, the \code{getOption("devOptions")[[type]]}
#  option is modified.  This means that for such options to be effective,
#  any device function needs to query also such options, which for instance
#  is done by @see "devNew".
#
#  Also, for certain devices (eps, pdf, postscript, quartz, windows and x11),
#  builtin R device options are set.
# }
#
# @examples "../incl/devOptions.Rex"
#
# @author
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devOptions <- function(type=c("bmp", "cairo_pdf", "cairo_ps", "eps", "jpeg", "jpeg2", "pdf", "pictex", "png", "png2", "postscript", "quartz", "svg", "tiff", "win.metafile", "windows", "x11", "xfig"), custom=TRUE, special=TRUE, drop=TRUE, options=list(), ..., reset=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local setups
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  devList <- list(
    bmp=c("grDevices::bmp"),
    cairo_pdf=c("grDevices::cairo_pdf"),
    cairo_ps=c("grDevices::cairo_ps"),
    eps=c("eps", "grDevices::postscript"),
    jpeg=c("grDevices::jpeg"),
    jpeg2=c("jpeg2", "grDevices::bitmap", "grDevices::postscript"),
    pdf=c("grDevices::pdf"),
    pictex=c("grDevices::pictex"),
    png=c("grDevices::png"),
    png2=c("png2", "grDevices::bitmap", "grDevices::postscript"),
    postscript=c("grDevices::postscript"),
    quartz=c("grDevices::quartz"),
    svg=c("grDevices::svg"),
    tiff=c("grDevices::tiff"),
    win.metafile=c("grDevices::win.metafile"),
    windows=c("grDevices::windows"),
    x11=c("grDevices::x11"),
    xfig=c("grDevices::xfig")
  );


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (.Platform$OS.type == "windows") {
    # To please R CMD check
    windows.options <- NULL; rm(list="windows.options");
    x11.options <- windows.options;
  }


  # A template for a dummy device options function.
  getNnnOptions <- function(type, ...) {
    optList <- list(
      eps="ps.options",
      jpeg2="ps.options",
      pdf="pdf.options",
      png2="ps.options",
      postscript="ps.options",
      quartz="quartz.options",
      windows="windows.options",
      x11="x11.options"
    );

    dummy <- function(...) { list(); }

    if (!is.element(type, names(optList))) {
      return(dummy);
    }

    key <- optList[[type]];

    # Sanity check
    stopifnot(length(key) == 1L);

    # Does the nnn.function() already exists?
    envir <- getNamespace("grDevices");
    if (exists(key, envir=envir, mode="function")) {
      fcn <- get(key, envir=envir, mode="function");
      return(fcn);
    } else if (exists(key, mode="function")) {
      fcn <- get(key, mode="function");
      return(fcn);
    }

    # If not, create either a real one or a dummy one...
    typeC <- capitalize(type);
    keyE <- sprintf(".%senv", typeC);
    if (exists(keyE, envir=envir, mode="environment")) {
      # A real one
      envir <- get(keyE, envir=envir, mode="environment");
      fcn <- function(..., reset=FALSE) {
        keyO <- sprintf(".%s.Options", typeC);
        opts <- get(keyO, envir=envir, mode="list");
        if (reset) {
          keyD <- sprintf("%s.default", keyO);
          opts <- get(keyD, envir=envir, mode="list");
          assign(keyD, value=opts, envir=envir);
        }
        opts;
      };
    } else {
      # A dummy
      fcn <- dummy;
    }

    fcn;
  } # getNnnOptions()


  # See argument 'paper' in help("pdf"), help("postscript"), and
  # help("xfig").
  getSpecialDimensions <- function(options=list(), sizes=names(paperSizes), ...) {
    paperSizes <- list(
      a4        = c( 8.27, 11.69),
      a4r       = c(11.69,  8.27),
      executive = c( 7.25, 10.5 ),
      legal     = c( 8.5 , 14   ),
      letter    = c( 8.5 , 11   ),
      USr       = c(11   , 8.5  )
    );

    paper <- tolower(options$paper);
    if (paper == "default") {
      paper <- getOption("papersize", "a4");
    }

    if (paper != "special") {
      paperSizes <- paperSizes[sizes];
      dim <- paperSizes[[paper]];

      # Replace "special" 0:s with NA:s, to indicate they are missing
      dim[dim == 0L] <- as.double(NA);
    } else {
      dim <- c(options$width, options$height);
    }

    dim;
  } # getSpecialDimensions()


  getDevOptions <- function(type, ...) {
    opts <- getOption("devOptions", list());
    opts <- opts[[type]];
    if (is.null(opts)) {
      opts <- list();
    }
    opts;
  } # getDevOptions()


  setDevOptions <- function(.type, ..., reset=FALSE) {
    devOpts <- getOption("devOptions", list());
##    str(list(.type=.type, devOpts=devOpts));
    oopts <- opts <- devOpts[[.type]];
    if (is.null(opts)) opts <- list();
    # Sanity check
    stopifnot(is.list(opts));
##    str(list(opts=opts));
    if (reset) {
      opts <- NULL;
    } else {
      args <- list(...);
      if (length(args) > 0L) {
        for (key in names(args)) {
          value <- args[[key]];
##          str(list(key=key, value=value))
          opts[[key]] <- value;
        }
      }
    }
    devOpts[[.type]] <- opts;
    options(devOptions=devOpts);
    invisible(oopts);
  } # setDevOptions()


  getDeviceFunctions <- function(type, default=function() {}, ...) {
    # Find all device functions.  If non-existent, return the default
    devs <- devList[[type]];

    parts <- strsplit(devs, split="::", fixed=TRUE);
    devs <- lapply(parts, FUN=function(s) {
      if (length(s) > 1L) {
        envir <- getNamespace(s[1L]);
        s <- s[-1L];
      } else {
        envir <- as.environment(-1L);
      }

      if (exists(s[1L], envir=envir, mode="function")) {
        get(s[1L], envir=envir, mode="function");
      } else {
        default;
      }
    });

    devs;
  } # getDeviceFunctions()


  findDeviceFunction <- function(fcn, ...) {
    types <- names(devList);

    for (type in types) {
      devs <- getDeviceFunctions(type, default=NULL);
      for (dev in devs) {
        if (identical(fcn, dev)) {
          return(type);
        }
      }
    } # for (type ...)

    "<function>";
  } # findDeviceFunction()


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'options':
  if (!is.list(options)) {
    throw("Argument 'options' must be a list: ", class(options)[1L]);
  }
  nopts <- length(options);
  if (nopts > 0L && is.null(names(options))) {
    throw("Argument 'options' must be a named list.");
  }

  # Additional arguments
  args <- list(...);
  nargs <- length(args);
  if (nargs > 0L && is.null(names(args))) {
    throw("Optional ('...') arguments must be named.");
  }

  for (key in names(args)) {
    options[[key]] <- args[[key]];
  }
  nopts <- length(options);
  # Not needed anymore
  args <- nargs <- NULL;

  # Argument 'type':
  if (missing(type) || length(type) == 0L) {
    knownTypes <- eval(formals(devOptions)$type);
    if (nopts > 0L) {
      throw("Cannot set device options. Argument 'type' is missing or NULL. Should be one of: ", paste(sprintf("'%s'", knownTypes), collapse=", "));
    }

    res <- devOptions(type=knownTypes, custom=custom, special=special, drop=drop, reset=reset);
    if (reset) {
      return(invisible(res));
    } else {
      return(res);
    }
  }

  if (length(type) > 1L) {
    if (nopts > 0L) {
      throw("Cannot set device options for more than one devices at the time: ", hpaste(sprintf("'%s'", type), collapse=", "));
    }

    # Support vector of 'type':s
    types <- type;
    res <- sapply(types, FUN=devOptions, drop=TRUE);
    fields <- lapply(res, FUN=function(opts) names(opts));
    fields <- unique(unlist(fields, use.names=FALSE));
    opts <- lapply(res, FUN=function(x) x[fields]);
    opts <- unlist(opts, use.names=FALSE, recursive=FALSE);
    dim(opts) <- c(length(fields), length(types));
    dimnames(opts) <- list(fields, types);
    opts <- t(opts);
    ##class(opts) <- c("DeviceOptions", class(opts));
    return(opts);
  }
  if (is.function(type)) {
    # Try to find name of device function
    type <- findDeviceFunction(fcn=type);
  }
  if (is.character(type)) {
    type <- .devTypeName(type);
    type <- match.arg(type);
  }

  if (!is.element(type, names(devList))) {
    throw("Cannot query/modify device options. Unknown device: ", type);
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Locate the nnn.options() function for this type of device
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  nnn.options <- getNnnOptions(type);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Locate the list of device functions used by this type of device
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # If non-existent, return a dummy
  devs <- getDeviceFunctions(type, default=function() {});


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Reset?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (reset) {
    res <- devOptions(type=type, special=special, drop=drop, reset=FALSE);
    setDevOptions(type, reset=TRUE);

    # Only for certain devices...
    nnn.options(reset=TRUE);

    return(invisible(res));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Assign user arguments, iff possible
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (nopts > 0L) {
    do.call("setDevOptions", args=c(list(.type=type), options));

    # Only for certain devices...
    do.call("nnn.options", args=options);
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get builtin device options, if available
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Only for certain devices...
  opts <- nnn.options();


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get (nested) device formals
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  defArgs <- lapply(rev(devs), FUN=formals);
  defArgs <- Reduce(append, defArgs);
  # Drop '...'
  defArgs <- defArgs[names(defArgs) != "..."];
  # Drop overridden values
  defArgs <- defArgs[!duplicated(names(defArgs), fromLast=TRUE)];


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Merge arguments that either are not in the predefined set of
  # device options, or ones that replaced the default value.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  optsT <- c(opts, defArgs);


  # Include custom options specific to devOptions()?
  if (custom) {
    devOpts <- getDevOptions(type);
    optsT <- c(optsT, devOpts);
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Build the concensus of all options
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # (a) Keep all non-duplicated options
  dups <- duplicated(names(optsT));
  idxsA <- which(!dups);
  optsA <- optsT[idxsA];

  # (b) Among duplicates, keep those with values
  idxsB <- which(dups);
  idxsB <- idxsB[!sapply(optsT[idxsB], FUN=is.symbol)];
  optsB <- optsT[idxsB];

  opts <- append(optsA, optsB);

  # Drop overridden values
  opts <- opts[!duplicated(names(opts), fromLast=TRUE)];


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Adjust for special cases?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (special) {
    if (is.element(type, c("eps", "postscript"))) {
      sizes <- c("a4", "executive", "legal", "letter");
      dim <- getSpecialDimensions(opts, sizes);
    } else if (type == "xfig") {
      sizes <- c("a4", "legal", "letter");
      dim <- getSpecialDimensions(opts, sizes);
    } else if (type == "pdf") {
      sizes <- c("a4", "a4r", "executive", "legal", "letter", "USr");
      dim <- getSpecialDimensions(opts, sizes);
    } else {
      dim <- NULL;
    }

    if (!is.null(dim)) {
      opts$width <- dim[1L];
      opts$height <- dim[2L];
    }
  }

  # Return a list?
  if (!drop) {
    names <- names(opts);
    dim(opts) <- c(1L, length(opts));
    dimnames(opts) <- list(type, names);
    ## Possibly, class(opts) <- c("DeviceOptions", class(opts))
  }

  # Return invisibly?
  if (nopts > 0L) {
    invisible(opts);
  } else {
    opts;
  }
} # devOptions()


############################################################################
# HISTORY:
# 2012-07-26
# o Added arguments 'options' and 'drop' to devOptions().
# 2012-07-24
# o Now devOptions() supports a vector of devices types.  If so, then
#   a matrix where each row specifies a device type.  The union of
#   all possible fields are returned as columns.  Non-existing fields
#   are returned as NULL.  If no device type is specified (or NULL), then
#   all are returned.
# o Now devOptions() also supports "win.metafile".
# 2012-04-30
# o Now devOptions() returns options invisibly if some options were set,
#   otherwise not, e.g. devOptions() versus devOptions("png", width=1024).
# 2012-02-26
# o GENERALIZATION: Now devOptions() accepts passing a device function
#   in addition a sting, e.g. devOptions(png) and devOptions("png").
# 2011-11-07
# o Added 'quarts' to the list of (possible) devices.
# o BUG FIX: devOptions() assumed that all devices exist on
#   all platforms, causing it to give an error on some.
# 2011-11-05
# o Created.
############################################################################
