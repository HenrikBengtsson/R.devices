#########################################################################/**
# @RdocFunction eps
#
# @title "EPS graphics device"
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
#   \item{horizontal}{If @FALSE, an horizontal EPS file is created,
#         otherwise a portrait file is created.}
#   \item{paper}{A @character string specifying the paper type. Overrides
#         the default of \code{postscript()}.}
#   \item{onefile}{Not used.}
#   \item{...}{Other arguments accepted by \code{postscript()}.}
# }
#
# \value{
#   A plot device is opened; nothing is returned.
# }
#
# \examples{\dontrun{
#   eps("foo.eps", width=7, height=7)
#
#   # is identical to
#
#   postscript("foo.eps", width=7, height=7, onefile=TRUE, horizontal=FALSE)
#
#   # and
#
#   dev.print(eps, "foo.eps", ...)
#
#   # is identical to
#
#   dev.print(postscript, "foo.eps", onefile=TRUE, horizontal=FALSE, paper="special", ...)
# }}
#
# \keyword{device}
#
# \seealso{
#   This is just a convenient wrapper for @see "grDevices::postscript"
#   with the proper arguments set to generate an EPS file.
#
#   It is recommended to use @see "toEPS" instead.
# }
#
# @author
#
# @keyword device
# @keyword internal
#*/#########################################################################
eps <- function(file="Rplot%03d.eps", width=7, height=7, horizontal=FALSE, paper="special", onefile=FALSE, ...) {
  onefile <- FALSE
  postscript(file=file, width=width, height=height, horizontal=horizontal, paper=paper, onefile=onefile, ...)
}
