%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  deviceUtils.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devGetLabel}
\alias{devGetLabel}


\title{Gets the labels of zero or more devices}

\description{
 Gets the labels of zero or more devices.
}

\usage{
devGetLabel(which=dev.cur(), ...)
}

\arguments{
  \item{which}{An index (\code{\link[base]{numeric}}) \code{\link[base]{vector}} or a label (\code{\link[base]{character}}) \code{\link[base]{vector}}.}
  \item{...}{Not used.}
}

\value{
  Returns a \code{\link[base]{character}} \code{\link[base]{vector}}.
  If a device does not exist, an error is thrown.
}

\author{Henrik Bengtsson}

\seealso{
  \code{\link{devSetLabel}}() and \code{\link{devList}}().
}



\keyword{device}
\keyword{utilities}
