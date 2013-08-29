%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  DevEvalProduct.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{DevEvalProduct}
\docType{class}
\alias{DevEvalProduct}


\title{The DevEvalProduct class}

\description{
 Package:  R.devices \cr
\bold{Class DevEvalProduct}\cr

\code{character}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.oo]{BasicObject}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{DevEvalProduct}\cr

\bold{Directly known subclasses:}\cr
\link[R.devices]{DevEvalFileProduct}\cr

public class \bold{DevEvalProduct}\cr
extends \link[R.oo]{BasicObject}\cr



 A DevEvalProduct represents a handle to the "product" returned by
 \code{\link{devEval}}().
}

\usage{
DevEvalProduct(name=NULL, tags=NULL, type=NULL, ...)
}

\arguments{
  \item{name, tags}{The name and optional tags of the product.}
  \item{type}{The device type.}
  \item{...}{Not used.}
}

\section{Fields}{
 The following (virtual; calculate on-the-fly) fields are available:
 \itemize{
  \item \code{fullname}: the fullname of an image, e.g. 'foo,a,b'
  \item \code{name}: the part of the fullname before the first comma, e.g. 'foo'
  \item \code{tags}: the part of the fullname after the first comma, e.g. 'a,b'
 }
}

\author{Henrik Bengtsson}


\keyword{classes}
\keyword{internal}
