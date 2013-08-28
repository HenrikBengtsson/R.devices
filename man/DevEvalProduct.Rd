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

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.devices:as.character.DevEvalProduct]{as.character}} \tab Gets a character representation of the product.\cr
 \tab \code{\link[R.devices:getFullname.DevEvalProduct]{getFullname}} \tab Gets the full name, name and tags.\cr
 \tab \code{getName} \tab  -\cr
 \tab \code{getTags} \tab  -\cr
 \tab \code{\link[R.devices:getType.DevEvalProduct]{getType}} \tab Gets the type.\cr
}


 \bold{Methods inherited from BasicObject}:\cr
$, $<-, [[, [[<-, as.character, attach, detach, equals, extend, getFields, getInstantiationTime, hasField, hashCode, isReferable, objectSize, print

 \bold{Methods inherited from character}:\cr
all.equal, as.Date, as.POSIXlt, as.data.frame, as.raster, formula, getDLLRegisteredRoutines, isOpen, uses


}

\author{Henrik Bengtsson}


\keyword{classes}
\keyword{internal}
