%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  DevEvalProduct.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{DevEvalFileProduct}
\docType{class}
\alias{DevEvalFileProduct}


\title{The DevEvalFileProduct class}

\description{
 Package:  R.devices \cr
\bold{Class DevEvalFileProduct}\cr

\code{character}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.oo]{BasicObject}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.devices]{DevEvalProduct}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{DevEvalFileProduct}\cr

\bold{Directly known subclasses:}\cr
\cr

public class \bold{DevEvalFileProduct}\cr
extends \link[R.devices]{DevEvalProduct}\cr



 A DevEvalFileProduct is a \code{\link{DevEvalProduct}} refering to a image
 file created by \code{\link{devEval}}().
}

\usage{
DevEvalFileProduct(filename=NULL, path=NULL, ...)
}

\arguments{
  \item{filename, path}{The filename and the optional path of the image
   file product.}
  \item{...}{Additional arguments passed to \code{\link{DevEvalProduct}}.}
}

\section{Fields}{
 The following (virtual; calculate on-the-fly) fields are available:
 \itemize{
  \item \code{pathname}, e.g. 'figures/foo,a,b.png'
  \item \code{path}, e.g. 'figures/'
  \item \code{filename}, e.g. 'foo,a,b.png'
  \item \code{fullname}, e.g. 'foo,a,b'
  \item \code{name}, e.g. 'foo'
  \item \code{tags}, e.g. 'a,b'
  \item \code{dataURI}, e.g. 'data:image/png;base64,iVBORw0KGgoAAAA...'
 }
}

\author{Henrik Bengtsson}


\keyword{classes}
\keyword{internal}
