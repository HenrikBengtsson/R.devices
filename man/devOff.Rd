%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  deviceUtils.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devOff}
\alias{devOff}


\title{Closes zero or more devices}

\description{
 Closes zero or more devices.
}

\usage{
devOff(which=dev.cur(), ...)
}

\arguments{
  \item{which}{An index (\code{\link[base]{numeric}}) \code{\link[base]{vector}} or a label (\code{\link[base]{character}}) \code{\link[base]{vector}}.}
  \item{...}{Not used.}
}

\value{
  Returns \code{\link[grDevices:dev]{dev.cur}()}.
}

\author{Henrik Bengtsson}

\seealso{
  \code{\link{devDone}}().
  Internally, \code{\link[grDevices:dev]{dev.off}()} is used.
}



\keyword{device}
\keyword{utilities}
