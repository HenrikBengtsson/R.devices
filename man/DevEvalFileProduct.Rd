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

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.character} \tab  -\cr
 \tab \code{\link[R.devices:getDataURI.DevEvalFileProduct]{getDataURI}} \tab Gets a Base64-encoded data URI.\cr
 \tab \code{getExtension} \tab  -\cr
 \tab \code{getFilename} \tab  -\cr
 \tab \code{getFullname} \tab  -\cr
 \tab \code{getMime} \tab  -\cr
 \tab \code{\link[R.devices:getMimeType.DevEvalFileProduct]{getMimeType}} \tab Gets the MIME type.\cr
 \tab \code{getPath} \tab  -\cr
 \tab \code{\link[R.devices:getPathname.DevEvalFileProduct]{getPathname}} \tab Gets the pathname, filename and path.\cr
}


 \bold{Methods inherited from DevEvalProduct}:\cr
getFullname, getName, getTags, getType

 \bold{Methods inherited from BasicObject}:\cr
$, $<-, [[, [[<-, as.character, attach, detach, equals, extend, getFields, getInstantiationTime, hasField, hashCode, isReferable, objectSize, print

 \bold{Methods inherited from character}:\cr
all.equal, as.Date, as.POSIXlt, as.data.frame, as.raster, formula, getDLLRegisteredRoutines, isOpen, uses


}

\author{Henrik Bengtsson}


\keyword{classes}
\keyword{internal}
