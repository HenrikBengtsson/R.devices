%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  toBase64.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{toBase64}
\alias{toBase64}


\title{Encodes the content of an file in Base64 format}

\description{
 Encodes the content of an file in Base64 format.
}

\usage{
toBase64(pathname, prefix=TRUE, ...)
}

\arguments{
  \item{pathname}{The file to be encoded.}
  \item{prefix}{If \code{\link[base:logical]{TRUE}}, the return Base64 string will be prepended
   with character sequence '\code{data:<mime type>;base64,}'.}
  \item{...}{Not used.}
}

\value{
  Returns a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson}

\seealso{
  Internally the \pkg{markdown} package is utilized.
}




\keyword{device}
\keyword{utilities}
\keyword{internal}
