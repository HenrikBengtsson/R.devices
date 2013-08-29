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
  \item \code{pathname}: the (relative) pathname of the image file, e.g. 'figures/foo,a,b.png'.  This can be used to \emph{link to} image files in for instance HTML and Markdown documents.
  \item \code{path}, the (relative) path to the image file, e.g. 'figures/'
  \item \code{filename}: the filename ("basename") of the image file, e.g. 'foo,a,b.png'
  \item \code{fullname}: the fullname (the filename without the filename extension), e.g. 'foo,a,b'.  It is recommended to use this when including images in LaTeX documents that use the \code{\\usepackage{graphicx}} package.
  \item \code{name}: the part of the fullname before the first comma, e.g. 'foo'
  \item \code{tags}: the part of the fullname after the first comma, e.g. 'a,b'
  \item \code{dataURI}: the Base64-encoded Data URI representation of the image, e.g. 'data:image/png;base64,iVBORw0KGgoAAAA...'.  This can be used to \emph{include} ("inlining") image files in for instance self-contained HTML and Markdown documents.
 }
}

\seealso{
  In order to retrieve the Data URI, the \pkg{base64enc} package
  must be installed.
}

\author{Henrik Bengtsson}


\keyword{classes}
\keyword{internal}
