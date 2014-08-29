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
%% \alias{toCairoPNG}
\alias{toPNG}
\alias{toSVG}
\alias{toTIFF}
\alias{toWMF}
\alias{toFavicon}
\alias{asDataURI}

% Interactive/screen devices
\alias{toDefault}
\alias{toQuartz}
\alias{toWindows}
\alias{toX11}
\alias{toCairoWin}
\alias{toCairoX11}
%% \alias{toJavaGD}

\title{Methods for creating image files of a specific format}

\description{
 Methods for creating image files of a specific format.
}

\usage{
  toBMP(name, ..., field=getOption("devEval/args/field", "pathname"))
  toEMF(name, ..., ext="emf", field=getOption("devEval/args/field", "pathname"))
  toPDF(name, ..., field=getOption("devEval/args/field", "pathname"))
  toPNG(name, ..., field=getOption("devEval/args/field", "pathname"))
  toSVG(name, ..., field=getOption("devEval/args/field", "pathname"))
  toTIFF(name, ..., field=getOption("devEval/args/field", "pathname"))
  toWMF(name, ..., ext="wmf", field=getOption("devEval/args/field", "pathname"))
  %% toCairoPNG(name, ..., field=getOption("devEval/args/field", "pathname"))

  toFavicon(..., name="favicon", type="png", width=32L, height=width,
                 par=list(mar=c(0,0,0,0), bg="transparent"))

  % Interactive/screen devices
  toDefault(name, ...)
  toQuartz(name, ...)
  toX11(name, ...)
  toWindows(name, ...)

  % Interactive/screen devices from other packages
  toCairoWin(name, ...)
  toCairoX11(name, ...)
  %% toJavaGD(name, ...)
}

\arguments{
  \item{name}{A \code{\link[base]{character}} string specifying the name of the image file.}
  \item{...}{Additional arguments passed to \code{\link{devEval}}(), e.g.
     \code{tags} and \code{aspectRatio}.}
  \item{ext}{A \code{\link[base]{character}} string specifying the filename extension.}
  \item{field}{Passed to \code{\link{devEval}}().}
  \item{width, height, type, par}{Passed to \code{\link{devEval}}().}
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
