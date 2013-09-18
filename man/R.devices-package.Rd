%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  999.package.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{R.devices-package}
\alias{R.devices-package}
\alias{R.devices}
\docType{package}

\title{Package R.devices}


\description{
  This package provides functions for creating plots and image files in a unified way regardless of output format (EPS, PDF, PNG, SVG, TIFF, WMF, etc.).  Default device options as well as scales and aspect ratios are controlled in a uniform way across all device types.  Switching output format requires minimal changes in code.  This package is ideal for large-scale batch processing, because it will never leave open graphics devices or incomplete image files behind, even on errors or user interrupts.
}

\section{To get started}{
  \itemize{
   \item Vignette '\href{../doc/index.html}{R.devices overview}'
   \item \code{\link{toEPS}}(), \code{\link{toPDF}}(), \code{\link{toPNG}}(), ... - evaluate
         graphics code and atomically save plot to a figure file.
  }
}

\section{How to cite this package}{
  To cite this package, please use:
\preformatted{
@Manual{,
  title = {R.devices: Unified handling of graphics devices},
  author = {Henrik Bengtsson},
  year = {2013},
  note = {R package version 2.6.1},
}
}
}

\author{
 Henrik Bengtsson.
}

\section{License}{
 LGPL (>= 2.1).
}
\keyword{package}
