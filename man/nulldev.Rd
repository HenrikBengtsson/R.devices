%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  nulldev.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{nulldev}
\alias{nulldev}


\title{A \"null\" graphics device voiding all output}

\description{
 A \"null\" graphics device voiding all output.
}

\usage{
nulldev(file=nullfile(), ...)
}

\arguments{
  \item{file}{The output file (ignored; forced to its default).}
  \item{...}{All other arguments are also ignored.}
}

\value{
  A plot device is opened; nothing is returned.
}

\details{
  The null graphics device opens a regular \link[grDevices]{pdf} device
  and directs its output to the null file, which is \code{/dev/null} unless
  on Windows where it is \code{NUL}.
}

\examples{\dontrun{
  nulldev()
  plot(1:3)
  dev.off()
}}

\keyword{device}

\author{Henrik Bengtsson}



\keyword{device}
\keyword{internal}
