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
 \alias{toEPS}
 \alias{toPDF}
 \alias{toPNG}
 \alias{toSVG}
 \alias{toTIFF}

 \title{Methods for creating image files of a specific format}

 \description{
  Methods for creating image files of a specific format.
 }

 \usage{
   toBMP(name, ..., field="fullname")
   toEPS(name, ..., field="fullname")
   toPDF(name, ..., field="fullname")
   toPNG(name, ..., field="fullname")
   toSVG(name, ..., field="fullname")
   toTIFF(name, ..., field="fullname")
 }

 \arguments{
   \item{name}{A \code{\link[base]{character}} string specifying the name of the image file.}
   \item{...}{Additional arguments passed to \code{\link{devEval}}(), e.g.
      \code{tags} and \code{aspectRatio}.}
   \item{field}{Passed to \code{\link{devEval}}().}
 }

 \value{
   Returns by default the so called \emph{fullname} of the generated
   image file.  The fullname of an file is the filename without the
   extension.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   These functions are wrappers for \code{\link{devEval}}().
   See \code{\link{devOptions}}() to change the default dimensions for
   a specific device type.
 }



\keyword{documentation}
\keyword{device}
\keyword{utilities}
