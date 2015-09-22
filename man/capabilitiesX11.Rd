%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  capabilitiesX11.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{capabilitiesX11}
\alias{capabilitiesX11}


\title{Check whether current R session supports X11 or not}

\description{
  Check whether current R session supports X11 or not.

  Contrary to \code{capabilities("X11")} which only checks for X11
  support on startup [1], this function checks whether X11 is supported
  when it is called.  This is done by querying a temporary R session.
}

\usage{
capabilitiesX11(reset=FALSE, ...)
}

\arguments{
 \item{reset}{If \code{\link[base:logical]{TRUE}}, any previously obtained results are ignored,
  otherwise not.}
 \item{...}{(optional) \code{\link[base]{character}} strings of command-line options
  to \code{Rscript}.}
}

\value{
  Returns \code{\link[base:logical]{TRUE}} if X11 is supported, otherwise \code{\link[base:logical]{FALSE}}.
}

\author{Henrik Bengtsson}

\seealso{
 \code{\link[base]{capabilities}}()
}

\references{
 [1] R-devel thread 'capabilities("X11"): Force refresh from within R?
     (... and minor documentation issue)' on 2015-05-06,
     \url{https://stat.ethz.ch/pipermail/r-devel/2015-May/071100.html}\cr
}



\keyword{device}
\keyword{internal}
