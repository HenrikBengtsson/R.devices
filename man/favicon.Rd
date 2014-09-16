%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  favicon.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{favicon}
\alias{favicon}


\title{FAVICON graphics device}

\description{
 Device driver for Encapsulated Postscript. This driver is the same as
 the postscript driver where some arguments have different default values.
}

\usage{
favicon(filename="favicon.png", width=32L, height=width, bg="transparent",
  par=list(mar = c(0, 0, 0, 0)), ...)
}

\arguments{
  \item{file}{Default file name (pattern).}
  \item{width, height}{The width and height of the figure.}
  \item{par}{A named \code{\link[base]{list}} of graphical parameters to use.}
  \item{...}{Other arguments accepted by \code{png()}.}
}

\value{
  A plot device is opened; nothing is returned.
}

\examples{\dontrun{
  favicon(width=32L)

  # is identical to

  suppressWarnings({
    png("favicon.png", width=32L, height=32L, bg="transparent",
                       par=list(mar=c(0,0,0,0)))
  })
}}

\keyword{device}

\seealso{
  Internally, \code{\link[grDevices]{png}} is used.
}

\author{Henrik Bengtsson}



\keyword{device}
\keyword{internal}
