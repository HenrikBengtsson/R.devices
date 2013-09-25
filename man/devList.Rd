%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  deviceUtils.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devList}
\alias{devList}


\title{Lists the indices of the open devices named by their labels}

\description{
 Lists the indices of the open devices named by their labels.
}

\usage{
devList(dropNull=TRUE, ...)
}

\arguments{
  \item{dropNull}{If \code{\link[base:logical]{TRUE}}, the "null" device (device index 1) is
    not returned.}
  \item{...}{Not used.}
}

\value{
  Returns a named \code{\link[base]{integer}} \code{\link[base]{vector}}.
}

\author{Henrik Bengtsson}

\seealso{
  \code{\link[grDevices:dev]{dev.list}()}.
}



\keyword{device}
\keyword{utilities}
