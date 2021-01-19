###########################################################################/**
# @RdocDocumentation toNNN
# @alias toBMP
# @alias toEMF
# @alias toEPS
# @alias toPDF
# %% @alias toCairoPNG
# @alias toPNG
# @alias toSVG
# @alias toTIFF
# @alias toWMF 
# @alias toFavicon
# @alias toNullDev
# @alias asDataURI
#
# % Interactive/screen devices
# @alias toDefault
# @alias toQuartz
# @alias toWindows
# @alias toX11
# @alias toCairoWin
# @alias toCairoX11
# %% @alias toJavaGD
#@alias toRStudioGD
#
# @title "Methods for creating image files of a specific format"
#
# \description{
#  @get "title".
# }
#
# \usage{
#   toBMP(name, ...)
#   toPDF(name, ...)
#   toPNG(name, ...)
#   toSVG(name, ...)
#   toTIFF(name, ...)
#   toEMF(name, ..., ext="emf")
#   toWMF(name, ..., ext="wmf")
#
#   toFavicon(..., name="favicon", ext="png",
#             field=getDevOption("favicon", "field", default="htmlscript"))
#
#   % Interactive/screen devices
#   toDefault(name, ...)
#   toQuartz(name, ...)
#   toX11(name, ...)
#   toWindows(name, ...)
#
#   % Interactive/screen devices from other packages
#   toCairoWin(name, ...)
#   toCairoX11(name, ...)
#   %% toJavaGD(name, ...)
#
#   % Interactive/screen device for RStudio
#   toRStudioGD(name, ..., .allowUnknownArgs = TRUE)
# }
#
# \arguments{
#   \item{name}{A @character string specifying the name of the image file.}
#   \item{..., .allowUnknownArgs}{Additional arguments passed to @see "devEval", e.g.
#      \code{tags} and \code{aspectRatio}.}
#   \item{ext, field}{Passed to @see "devEval".}
# }
#
# \value{
#   Returns by default the @see "DevEvalProduct".
#   For \code{toFavicon()} the default return value is a @character string.
# }
#
# \section{Windows Metafile Format}{
#   Both \code{toEMF()} and \code{toWMF()} use the exact same graphics
#   device (\code{win.metafile()}) and settings.  They only differ by
#   filename extension.  The \code{win.metafile()} device function exists
#   on Windows only; see the \pkg{grDevices} package for more details.
# }
#
# @author
#
# \seealso{
#   These functions are wrappers for @see "devEval".
#   See @see "devOptions" to change the default dimensions for
#   a specific device type.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
toBMP <- function(name, ...) {
  devEval(type="{bmp}", name=name, ...);
}

toEMF <- function(name, ..., ext="emf") {
  devEval(type="{win.metafile}", name=name, ..., ext=ext);
}

toWMF <- function(name, ..., ext="wmf") {
  devEval(type="{win.metafile}", name=name, ..., ext=ext);
}

toEPS <- function(name, ...) {
  devEval(type="{eps}", name=name, ...);
}

toPDF <- function(name, ...) {
  devEval(type="{pdf}", name=name, ...);
}

toPNG <- function(name, ...) {
  devEval(type="{png}", name=name, ...);
}

toSVG <- function(name, ...) {
  devEval(type="{svg}", name=name, ...);
}

toTIFF <- function(name, ...) {
  devEval(type="{tiff}", name=name, ...);
}

toFavicon <- function(..., name="favicon", ext="png", field=getDevOption("favicon", "field", default="htmlscript")) {
  # Output as "<script>...</script>"?
  if (identical(field, "htmlscript")) {
    uri <- devEval(type="{favicon}", name=name, ext=ext, field="dataURI", ...);
    script <- c(
      "<script>",
      " var link = document.createElement('link');",
      " link.rel = 'icon';",
      sprintf(' link.href = "%s"', uri),
      " document.getElementsByTagName('head')[0].appendChild(link);",
      "</script>",
      ""
    )
    paste(script, collapse="\n")
  } else {
    devEval(type="favicon", name=name, ext=ext, field=field, ...);
  }
} # toFavicon()

toNullDev <- function(name, ...) {
  devEval(type = "{nulldev}", name = name, ...)
}

asDataURI <- function(..., mime=NULL) {
  img <- DevEvalFileProduct(...);
  if (is.null(mime)) {
    mime <- getMimeType(img);
  }
  getDataURI(img, mime=mime);
}


toDefault <- function(name, ...) {
  devEval(type=getOption("device"), name=name, ...);
}

toQuartz <- function(name, ...) {
  devEval(type="{quartz}", name=name, ...);
}

toWindows <- function(name, ...) {
  devEval(type="{windows}", name=name, ...);
}

toX11 <- function(name, ...) {
  devEval(type="{x11}", name=name, ...);
}

toCairoWin <- function(name, ...) {
  devEval(type="{CairoWin}", name=name, ...);
}

toCairoX11 <- function(name, ...) {
  devEval(type="{CairoX11}", name=name, ...);
}

toRStudioGD <- function(name, ..., .allowUnknownArgs = TRUE) {
  ## WORKAROUND: Calling dev.new() in RStudio will open a RStudioGD device
  ## unless it is already opened, which in case it will open new graphics
  ## devices as when done outside of RStudio. In other words, there can only
  ## be one RStudioGD device open at any time.
  ## Because of the above, call to toRStudioGD() should set current device to
  ## the RStudioGD one if already open, otherwise create a new one. To open
  ## an existing device, all we need to do is set 'name' to its label.
  ## PS. We cannot just close it and have it reopened, because then we'll
  ##     loose the plot history in RStudio itself.

  ## (a) RStudioGD is not opened
  idx <- which("RStudioGD" == names(dev.list())) + 1L
  if (length(idx) == 0) {
    return(devEval(type = "{RStudioGD}", name = name, ...,
                   .allowUnknownArgs = .allowUnknownArgs))
  }

  ## (b) RStudioGD _is_ opened
  
  ## Existing label of the RStudioGD device
  label <- devGetLabel(idx)

  ## Was the expression passed implicitly via 'name' instead?  If so, then we
  ## need to make sure to call devEval() with 'name' set to the label of the
  ## current RStudioGD device.
  expr <- substitute(name)
  class <- eval(expression(class(expr)))
  is_expression <- is.element(class, c("call", "{", "("))
  if (isTRUE(is_expression)) {
    args <- list(type = "RStudioGD", name = label, expr = expr, ...,
                 .allowUnknownArgs = .allowUnknownArgs)
    return(do.call(devEval, args = args, envir = parent.frame()))
  }

  ## Otherwise, just call it as is
  res <- devEval(type = "RStudioGD", name = label, ...,
                 .allowUnknownArgs = .allowUnknownArgs)

  ## Should the label of the RStudioGD device be updated  
  if (name != label) devSetLabel(idx, label = name)
  
  res
}

## toJavaGD <- function(name, ...) {
##   devEval(type="{JavaGD}", name=name, ...);
## }
