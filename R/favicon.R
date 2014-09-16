#########################################################################/**
# @RdocFunction favicon
#
# @title "FAVICON graphics device"
#
# \description{
#  Device driver for Encapsulated Postscript. This driver is the same as
#  the postscript driver where some arguments have different default values.
# }
#
# @synopsis
#
# \arguments{
#   \item{file}{Default file name (pattern).}
#   \item{width, height}{The width and height of the figure.}
#   \item{par}{A named @list of graphical parameters to use.}
#   \item{...}{Other arguments accepted by \code{png()}.}
# }
#
# \value{
#   A plot device is opened; nothing is returned.
# }
#
# \examples{\dontrun{
#   favicon(width=32L)
#
#   # is identical to
#
#   suppressWarnings({
#     png("favicon.png", width=32L, height=32L, bg="transparent",
#                        par=list(mar=c(0,0,0,0)))
#   })
# }}
#
# \keyword{device}
#
# \seealso{
#   Internally, @see "grDevices::png" is used.
# }
#
# @author
#
# @keyword device
# @keyword internal
#*/#########################################################################
favicon <- function(filename="favicon.png", width=32L, height=width, bg="transparent", par=list(mar=c(0,0,0,0)), ...) {
  # Argument 'width' and 'height':
  if (height != width) {
    throw("The width and the height must be the same for a favicon: ",
          width, " != ", height)
  }

  # Argument 'par':
  if (!is.null(par)) {
    if (!is.list(par) || is.null(names(par))) {
      throw("Argument 'par' has to be a named list: ", mode(par))
    }
  }

  # Create PNG file
  # png() will generate a warning that "width=.. , height=.., are unlikely
  # values in pixels" if width < 20.
  suppressWarnings({
    png(filename=filename, width=width, height=height, bg=bg, ...)
  })

  # Set graphical parameters
  par(par)
} # favicon()


############################################################################
# HISTORY:
# 2014-09-15
# o Created.
############################################################################

