%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  toNNN.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{toNNN}
\alias{toNNN}

\alias{toBMP}
\alias{toEMF}
\alias{toEPS}
\alias{toPDF}
\alias{toPNG}
\alias{toSVG}
\alias{toTIFF}
\alias{toWMF}

\title{Methods for creating image files of a specific format}

\description{
 Methods for creating image files of a specific format.
}

\usage{
  toBMP(name, ..., field=getOption("devEval/args/field", "fullname"))
  toEMF(name, ..., ext="emf", field=getOption("devEval/args/field", "fullname"))
  toPDF(name, ..., field=getOption("devEval/args/field", "fullname"))
  toPNG(name, ..., field=getOption("devEval/args/field", "fullname"))
  toSVG(name, ..., field=getOption("devEval/args/field", "fullname"))
  toTIFF(name, ..., field=getOption("devEval/args/field", "fullname"))
  toWMF(name, ..., ext="wmf", field=getOption("devEval/args/field", "fullname"))
}

\arguments{
  \item{name}{A \code{\link[base]{character}} string specifying the name of the image file.}
  \item{...}{Additional arguments passed to \code{\link{devEval}}(), e.g.
     \code{tags} and \code{aspectRatio}.}
  \item{ext}{A \code{\link[base]{character}} string specifying the filename extension.}
  \item{field}{Passed to \code{\link{devEval}}().}
}

\value{
  Returns by default the so called \emph{fullname} of the generated
  image file.  The fullname of an file is the filename without the
  extension.
}

\author{Henrik Bengtsson}

\seealso{
  These functions are wrappers for \code{\link{devEval}}().
  See \code{\link{devOptions}}() to change the default dimensions for
  a specific device type.
}



\keyword{documentation}
\keyword{device}
\keyword{utilities}
