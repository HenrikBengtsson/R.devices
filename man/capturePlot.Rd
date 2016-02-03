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
capturePlot(expr, envir=parent.frame(), type=pdf, ...)
}

\arguments{
  \item{expr}{The \code{\link[base]{expression}} of graphing commands to be evaluated.}
  \item{envir}{The \code{\link[base]{environment}} where \code{expr} should be evaluated.}
  \item{type}{The type of graphics device used in the background.
   The choice should not matter since the result should be identical
   regardless.}
 \item{...}{Not used.}
}

\value{
  Returns a \code{recordedplot} object, which can be
  \code{\link[grDevices]{replayPlot}()}:ed.  If replayed in an
  interactive session, the plot is displayed in a new window.
  For conveniency, the object is also replayed when \code{print()}:ed.
}

\examples{
if (getRversion() >= "3.3.0") {

g <- capturePlot({
  plot(1:10)
})

## Display
print(g)

## Redraw to many output formats
devEval(c("png", "eps", "pdf"), print(g))

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
