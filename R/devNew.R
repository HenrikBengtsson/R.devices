###########################################################################/**
# @RdocFunction devNew
#
# @title "Opens a new device"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{type}{A @character string specifying the type of device to be
#     opened. This string should match the name of an existing device
#     @function.}
#   \item{...}{Additional arguments passed to the device @function, e.g.
#     \code{width} and \code{height}.  If not given, the are inferred
#     from @see "devOptions".}
#   \item{scale}{A @numeric scalar factor specifying how much the
#     width and the height should be rescaled.}
#   \item{aspectRatio}{A @numeric ratio specifying the aspect ratio
#     of the image.  See below.}
#   \item{par}{An optional named @list of graphical settings applied,
#     that is, passed to @see "graphics::par", immediately after
#     opening the device.}
#   \item{label}{An optional @character string specifying the label of the
#     opened device.}
# }
#
# \value{
#   Returns the device index of the opened device.
# }
#
# \section{Width and heights}{
#   The default width and height of the generated image is specific to
#   the type of device used.  There is not straightforward programatical
#   way to infer these defaults; here we use @see "devOptions", which
#   in most cases returns the correct defaults.
# }
#
# \section{Aspect ratio}{
#   The aspect ratio of an image is the height relative to the width.
#   If argument \code{height} is not given (or @NULL), it is
#   calculated as \code{aspectRatio*width} as long as they are given.
#   Likewise, if argument \code{width} is not given (or @NULL), it is
#   calculated as \code{width/aspectRatio} as long as they are given.
#   If neither \code{width} nor \code{height} is given, then \code{width}
#   defaults to \code{devOptions(type)$width}.
#   If both \code{width} and \code{height} are given, then
#   \code{aspectRatio} is ignored.
# }
#
# @author
#
# \seealso{
#   @see "devDone" and @see "devOff".
#   For simplified generation of image files, see @see "devEval".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devNew <- function(type=getOption("device"), ..., scale=1, aspectRatio=1, par=NULL, label=NULL) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  cleanLength <- function(x, ...) {
    name <- substitute(x)
    if (is.null(x) || !is.numeric(x) || !is.finite(x)) {
      warning("Ignoring non-finite '", name, "' value: ", x)
      x <- NULL
    }
    x
  } # cleanLength()

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'type':
  if (length(type) != 1L) {
    throw("Argument 'type' must be a single object: ", length(type))
  }
  if (is.function(type)) {
  } else {
    type <- as.character(type)
    type <- .devTypeName(type)
  }

  # Argument 'scale':
  if (!is.null(scale)) {
    scale <- Arguments$getDouble(scale, range=c(0,Inf))
  }

  # Argument 'aspectRatio':
  if (!is.null(aspectRatio)) {
    aspectRatio <- Arguments$getDouble(aspectRatio, range=c(0,Inf))
  }

  # Argument 'par':
  if (!is.null(par)) {
    if (!is.list(par) || is.null(names(par))) {
      throw("Argument 'par' has to be a named list: ", mode(par))
    }
  }

  # Argument 'label':
  if (!is.null(label)) {
    if (any(label == names(devList())))
      throw("Cannot open device. Label is already used: ", label)
  }


  # Arguments to be passed to the device function
  args <- list(...)

  ## Secret argument from devEval(), which is intended to be used when
  ## multiple devices are used and not all accepts the same arguments.
  .allowUnknownArgs <- args$.allowUnknownArgs
  if (is.null(.allowUnknownArgs)) .allowUnknownArgs <- FALSE
  args$.allowUnknownArgs <- NULL

  # Drop 'width' and 'height', iff NULL (=treat as non-specified/missing)
  args$width <- args$width
  args$height <- args$height


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Update the 'height' by argument 'aspectRatio'?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(aspectRatio)) {
    width <- args$width
    height <- args$height

    # Were both 'width' and 'height' explicitly specified?
    if (!is.null(width) && !is.null(height)) {
      if (aspectRatio != 1) {
        warning("Argument 'aspectRatio' was ignored because both 'width' and 'height' were given: ", aspectRatio)
      }
    } else {
      # None of 'width' and 'height' was specified?
      if (is.null(width) && is.null(height)) {
        # (a) Infer 'width' from devOptions()...
        width <- devOptions(type)$width
        width <- cleanLength(width)
        if (!is.null(width)) {
          args$width <- width
          args$height <- aspectRatio * width
        } else {
	  typeT <- if (is.character(type)) dQuote(type) else "<function>"
          warning("Argument 'aspectRatio' was ignored because none of 'width' and 'height' were given and 'width' could not be inferred from devOptions(", typeT, "): ", aspectRatio)
        }
      } else if (!is.null(width)) {
        # Argument 'width' was specified but not 'height'
        args$height <- aspectRatio * width
      } else if (!is.null(height)) {
        # Argument 'height' was specified but not 'width'
        args$width <- height / aspectRatio
      }
    }
  } # if (!is.null(aspectRatio))


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Rescale 'width' & 'height' by argument 'scale'?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(scale) && scale != 1.0) {
    width <- args$width

    # Infer 'width' from the settings
    if (is.null(width)) {
      width <- devOptions(type)$width
      width <- cleanLength(width)
    }

    # Possible to rescale?
    if (is.null(width)) {
      warning("Argument 'scale' was ignored because it was not possible to infer 'width': ", scale)
    } else {
      # Infer 'height'...
      if (!is.null(aspectRatio)) {
        # ...from aspect ratio
        height <- aspectRatio * width
      } else {
        # ...from settings
        height <- args$height
        if (is.null(height)) {
          height <- devOptions(type)$height
          height <- cleanLength(height)
        }
        if (is.null(height)) {
          warning("Argument 'scale' was ignored because it was not possible to infer 'height': ", scale)
        }
      }
    }

    # So finally, possible to rescale?
    if (!is.null(width) && !is.null(height)) {
      args$width <- scale * width
      args$height <- scale * height
    }
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Exclude 'file' and 'filename' arguments?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  isInteractive <- devIsInteractive(type)
  if (isInteractive) {
    keep <- !is.element(names(args), c("file", "filename"))
    args <- args[keep]
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Open an existing device?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  which <- args[["which"]]
  if (is.null(which) || (nchar(which) == 0L) || !isInteractive) {
    # Default is to open a new one
    devIdx <- NA_integer_
  } else {
    # ...otherwise, is requested device already opened?
    devList <- devList(dropNull=FALSE)
    labels <- names(devList)

    # Default is to open a new one
    devIdx <- NA_integer_
    if (is.character(which)) {
      # An existing device by its label?
      devIdx <- match(which, table=labels)
      names(devIdx) <- labels[devIdx]
      if (is.null(label)) label <- which
    } else if (is.numeric(which)) {
      # An existing device by its index?
      if (which <= length(devList)) {
        devIdx <- which
        names(devIdx) <- labels[devIdx]
      }
    }
  }
  # Drop 'which' argument, if specified
  keep <- !is.element(names(args), "which")
  args <- args[keep]


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Open (new or existing) device
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # New or existing?
  if (is.na(devIdx)) {
    # (a) New, i.e. call the device function
    devList0 <- devList()

    typeT <- type
    if (.allowUnknownArgs) {
      # (b) Temporary append '...' to the device function to make it
      #     allow for more "unknown" arguments
      if (!is.function(type)) {
        typeT <- get(type, mode="function", inherits=TRUE)
      }
      typeT <- appendVarArgs(typeT)
    }

    if (getOption("R.devices::devNew/debug", FALSE)) {
      call <- list("devNew", typeT=typeT, args=args)
      R.utils::mstr(call)
    }

    do.call(typeT, args=args)

    # Make sure a new device was indeed opened.  This can happen
    # for graphics devices that does not throw an error, but only
    # a warning, e.g. quartz().
    opened <- setdiff(devList(), devList0)
    if (length(opened) == 0L) {
      throw("Failed to open graphics device: ", type)
    }

    # Retrieve the index of the recently opened device
    devIdx <- dev.cur()
  } else {
    # (b) Existing one, i.e. set focus.
    dev <- devSet(devIdx)

    # Assert that the existing device is of the requested type
    if (!.devEqualTypes(type, other=names(dev), args=args)) {
      if (is.function(type)) type <- "<a function>"
      throw(sprintf("Detected an existing devices with the requested label (which='%s'), but its device type is different from the requested type: '%s' != '%s'", names(devIdx), type, names(dev)))
    }
    # Make sure not to reset the device label below
    if (is.null(label)) label <- names(devIdx)
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Set the label of the recently opened device
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  devSetLabel(which=devIdx, label=label)

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Default and user-specific parameters
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  parT <- getDevOption(type=type, name="par", old="devNew/args/par")
  # Append
  parT <- c(parT, par)
  if (length(parT) > 0L) {
    par(parT)
  }

  invisible(devIdx)
} # devNew()
