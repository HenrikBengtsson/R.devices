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
  toBMP(name, ...)
  toPDF(name, ...)
  toPNG(name, ...)
  toSVG(name, ...)
  toTIFF(name, ...)
  toEMF(name, ..., ext="emf")
  toWMF(name, ..., ext="wmf")

  toFavicon(..., name="favicon", ext="png",
            field=getDevOption("favicon", "field", default="htmlscript"))

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
  \item{ext, field}{Passed to \code{\link{devEval}}().}
}

\value{
  Returns by default the \code{\link{DevEvalProduct}}.
  For \code{toFavicon()} the default return value is a \code{\link[base]{character}} string.
}

\details{
  Both \code{toEMF()} and \code{toWMF()} use the exact same graphics
  device and settings.  They only differ by filename exension.
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
