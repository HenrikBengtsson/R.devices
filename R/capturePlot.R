###########################################################################/**
# @RdocFunction capturePlot
#
# @title "Captures a plot such that it can be redrawn later/elsewhere"
#
# \description{
#   @get "title".
#
#   \emph{This feature is only supported in R (>= 3.3.0).}
# }
#
# @synopsis
#
# \arguments{
#   \item{expr}{The @expression of graphing commands to be evaluated.}
#   \item{envir}{The @environment where \code{expr} should be evaluated.}
#   \item{type}{The type of graphics device used in the background.
#    The choice should not matter since the result should be identical
#    regardless.}
#  \item{...}{Additional arguments passed to the graphics device.}
# }
#
# \value{
#   Returns a \code{recordedplot} object, which can be
#   \code{\link[grDevices]{replayPlot}()}:ed.  If replayed in an
#   interactive session, the plot is displayed in a new window.
#   For conveniency, the object is also replayed when \code{print()}:ed.
# }
#
# @examples "../incl/capturePlot.Rex"
#
# @author
#
# \seealso{
#   Internally \code{\link[grDevices]{recordPlot}()} is used.
# }
#
# \references{
#  [1] Paul Murrell et al.,
#      \emph{Recording and Replaying the Graphics Engine Display List},
#      December 2015.
#      \url{https://www.stat.auckland.ac.nz/~paul/Reports/DisplayList/dl-record.html}\cr
# }
#
# @keyword device
#*/###########################################################################
capturePlot <- function(expr, envir=parent.frame(), type=pdf, ...) {
  stopifnot(getRversion() >= "3.3.0")
  expr <- substitute(expr)

  pathname <- tempfile()
  type(pathname, ...)
  on.exit({
   dev.off()
   file.remove(pathname)
  })
  dev.control("enable")

  eval(expr, envir=envir)
  recordPlot()
}
