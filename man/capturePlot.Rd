%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  capturePlot.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{capturePlot}
\alias{capturePlot}


\title{Captures a plot such that it can be redrawn later/elsewhere}

\description{
  Captures a plot such that it can be redrawn later/elsewhere.

  \emph{This feature is only supported in R (>= 3.3.0).}
}

\usage{
capturePlot(expr, envir=parent.frame(), type=nulldev, ...)
}

\arguments{
  \item{expr}{The \code{\link[base]{expression}} of graphing commands to be evaluated.}
  \item{envir}{The \code{\link[base]{environment}} where \code{expr} should be evaluated.}
  \item{type}{The type of graphics device used in the background.
   The choice should not matter since the result should be identical
   regardless.  All graphics is captured but any output is also voided
   by sending the output to a "null" file.}
 \item{...}{Additional arguments passed to the graphics device.}
}

\value{
  Returns a \code{recordedplot} object, which can be
  \code{\link[grDevices]{replayPlot}()}:ed.  If replayed in an
  interactive session, the plot is displayed in a new window.
  For conveniency, the object is also replayed when \code{print()}:ed.
}

\details{
  Note that plot dimensions/aspect ratios are not recorded.  This
  means that one does not have to worry about those when recording
  the plot.  Instead, they are specified when setting up the graphics
  device(s) in which the recorded plot is replayed (see example).
}

\section{Replaying / replotting on a different architecture}{
 In order to replay a \code{recordedplot} object, it has to be replayed
 on an architecture that is compatible with the one who created the
 object.
 If this is not the case, then \code{\link[grDevices]{replayPlot}()}
 will generate an \emph{Incompatible graphics state} error.
 The \code{\link{as.architecture}()} function of this package tries
 to coerce between different architectures, such that one can replay
 across architectures using \code{replayPlot(as.architectures(g))}.
 For convenience, the recored plot returned by \code{capturePlot()}
 is automatically coerced when \code{print()}:ed.
}

\examples{
if (getRversion() >= "3.3.0") {

g <- capturePlot({
  plot(1:10)
})

## Display
print(g)

## Display with a 2/3 height-to-width aspect ratio
toDefault(aspectRatio=2/3, { print(g) })

## Redraw to many output formats
devEval(c("png", "eps", "pdf"), aspectRatio=2/3, print(g))

} ## if (getRversion() >= "3.3.0")
}

\author{Henrik Bengtsson}

\seealso{
  Internally \code{\link[grDevices]{recordPlot}()} is used.
}

\references{
 [1] Paul Murrell et al.,
     \emph{Recording and Replaying the Graphics Engine Display List},
     December 2015.
     \url{https://www.stat.auckland.ac.nz/~paul/Reports/DisplayList/dl-record.html}\cr
}


\keyword{device}
