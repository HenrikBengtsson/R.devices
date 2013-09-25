%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  deviceUtils.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devDone}
\alias{devDone}


\title{Closes zero or more open devices except screen (interactive) devices}

\description{
 Closes zero or more open devices except screen (interactive) devices.
}

\usage{
devDone(which=dev.cur(), ...)
}

\arguments{
  \item{which}{An index (\code{\link[base]{numeric}}) \code{\link[base]{vector}} or a label (\code{\link[base]{character}}) \code{\link[base]{vector}}.}
  \item{...}{Not used.}
}

\value{
  Returns (invisibly) \code{\link[grDevices:dev]{dev.cur}()}.
}

\author{Henrik Bengtsson}

\seealso{
  \code{\link{devOff}}().
  \code{\link[grDevices]{dev.interactive}}.
}



\keyword{device}
\keyword{utilities}
