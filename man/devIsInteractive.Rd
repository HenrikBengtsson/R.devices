%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  deviceUtils.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devIsInteractive}
\alias{devIsInteractive}


\title{Checks whether a device type is interactive or not}

\description{
 Checks whether a device type is interactive or not.
}

\usage{
devIsInteractive(types, ...)
}

\arguments{
  \item{types}{A \code{\link[base]{character}} \code{\link[base]{vector}}.}
  \item{...}{Not used.}
}

\value{
  Returns a \code{\link[base]{logical}} \code{\link[base]{vector}} with \code{\link[base:logical]{TRUE}} if the device type is interactive,
  otherwise \code{\link[base:logical]{FALSE}}.
}

\author{Henrik Bengtsson}

\seealso{
  Internally, \code{\link[grDevices]{deviceIsInteractive}} is used.
}



\keyword{device}
\keyword{utilities}
