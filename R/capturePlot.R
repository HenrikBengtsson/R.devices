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
# \details{
#   Note that plot dimensions/aspect ratios are not recorded.  This
#   means that one does not have to worry about those when recording
#   the plot.  Instead, they are specified when setting up the graphics
#   device(s) in which the recorded plot is replayed (see example).
# }
#
# \section{Replaying / replotting on a different architecture}{
#  In order to replay a \code{recordedplot} object, it has to be replayed
#  on an architecture that is compatible with the one who created the
#  object.
#  If this is not the case, then \code{\link[grDevices]{replayPlot}()}
#  will generate an \emph{Incompatible graphics state} error.
#  The \code{\link{as.architecture}()} function of this package tries
#  to coerce between different architectures, such that one can replay
#  across architectures using \code{replayPlot(as.architectures(g))}.
#  For convenience, the recored plot returned by \code{capturePlot()}
#  is automatically coerced when \code{print()}:ed.
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
  if (getRversion() < "3.3.0") {
    throw("Insufficient R version. R.devices::capturePlot() requires R (>= 3.3.0): ", getRversion())
  }

  expr <- substitute(expr)

  ## Plot to /dev/null file (or NUL on Windows)
  type(nullfile(), ...)
  on.exit(dev.off())

  dev.control("enable")
  eval(expr, envir=envir)
  g <- recordPlot()

  ## Record details of machine's architecture (helps troubleshooting)
  attr(g, "system") <- list(
    ostype=.Platform$OS.type,
    arch=R.version$arch,
    ptrsize=.Machine$sizeof.pointer,
    endian=.Platform$endian
  )

  class(g) <- c("RecordedPlot", class(g))
  
  g
}


#' Automatically replays a recorded plot
#'
#' This is identical to the \code{\link[grDevices:replayPlot]{print}()}
#' method available in \pkg{grDevices}, but if replaying the plot gives
#' an error it will also try to replay it after coercing the data structure
#' to match the architecture of the current machine.  This will make it
#' possible to, for instance, replay a plot generated on a 32-bit machine
#' on a 64-bit machine.
#' 
#' @param x A recorded plot of class \code{recordedplot}.
#'
#' @return Returns \code{x} invisibly.
#'
#' @seealso Internally, \code{\link{as.architecture}()} is used
#' to coerce to the current architecture.
#'
#' @export
#' @keywords internal
print.RecordedPlot <- function(x, ...) {
  ## First, try without coercion
  res <- tryCatch({
    replayPlot(x)
  }, error = identity)

  ## If that didn't work, then try to coerce
  if (inherits(res, "simpleError")) {
    x <- as.architecture(x)
    replayPlot(x)
  }
  
  invisible(x)
}
