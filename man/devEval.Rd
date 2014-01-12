%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  devEval.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devEval}
\alias{devEval}

\alias{devDump}

\title{Opens a new graphics device, evaluate (graphing) code, and closes device}

\description{
 Opens a new graphics device, evaluate (graphing) code, and closes device.
}

\usage{
devEval(type=getOption("device"), expr, initially=NULL, finally=NULL,
  envir=parent.frame(), name=NULL, tags=NULL, sep=getOption("devEval/args/sep", ","),
  ..., ext=NULL, filename=NULL, path=getOption("devEval/args/path", "figures/"),
  field=getOption("devEval/args/field", NULL), onIncomplete=c("remove", "rename",
  "keep"), force=getOption("devEval/args/force", TRUE), which=dev.cur())
}

\arguments{
  \item{type}{Specifies the type of graphics device to be used.
   The device is created and opened using \code{\link{devNew}}().
   Multiple types may be specified.}
  \item{expr}{The \code{\link[base]{expression}} of graphing commands to be evaluated.}
  \item{initially, finally}{Optional \code{\link[base]{expression}}:s to be evaluated
   before and after \code{expr}. If \code{type} specifies multiple
   devices, these optional \code{\link[base]{expression}}:s are only evaluated ones.}
  \item{envir}{The \code{\link[base]{environment}} where \code{expr} should be evaluated.}
  \item{name, tags, sep}{The fullname name of the image is specified
    as the name with optional \code{sep}-separated tags appended.}
  \item{ext}{The filename extension of the image file generated, if any.
   By default, it is inferred from argument \code{type}.}
  \item{...}{Additional arguments passed to \code{\link{devNew}}().}
  \item{filename}{The filename of the image saved, if any.
   By default, it is composed of arguments \code{name}, \code{tags},
   \code{sep}, and \code{ext}.  See also below.}
  \item{path}{The directory where then image should be saved, if any.}
  \item{field}{An optional \code{\link[base]{character}} string specifying a specific
    field of the named result \code{\link[base]{list}} to be returned.}
  \item{onIncomplete}{A \code{\link[base]{character}} string specifying what to do with
    an image file that was incompletely generated due to an interrupt
    or an error.}
  \item{force}{If \code{\link[base:logical]{TRUE}}, and the image file already exists, then it is
    overwritten, otherwise not.}
  \item{which}{A \code{\link[base]{vector}} of devices to be copied.  Only applied if
    argument \code{expr} is missing.}
}

\value{
  Returns a \code{\link{DevEvalFileProduct}} if the device generated an
  image file, otherwise an \code{\link{DevEvalProduct}}.
  If argument \code{field} is given, then the field of the
  \code{\link{DevEvalProduct}} is returned instead.
  \emph{Note that the default return value may be changed in future releases.}
}

\section{Generated image file}{
  If created, the generated image file is saved in the directory
  specfied by argument \code{path} with a filename consisting of
  the \code{name} followed by optional comma-separated \code{tags}
  and a filename extension given by argument \code{ext}.

  By default, the image file is only created if the \code{expr}
  is evaluated completely.  If it is, for instance, interrupted
  by the user or due to an error, then any incomplete/blank image
  file that was created will be removed.  This behavior can be
  turned of using argument \code{onIncomplete}.
}

\examples{
res <- devEval("png", name="MyPlot", tags=c("10", "rnd"), aspectRatio=0.7, {
  plot(1:10)
})
print(res$pathname)
# [1] "figures/MyPlot,10,rnd.png"

str(res$dataURI)
# chr "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAeAA..."

res <- devEval("pdf", name="MyPlot", tags=c("10", "rnd"), aspectRatio=0.7, {
  plot(1:10)
})
print(res$pathname)
# [1] "figures/MyPlot,10,rnd.pdf"


res <- devEval("eps", name="MyPlot", tags=c("10", "rnd"), aspectRatio=0.7, {
  plot(1:10)
})
print(res$pathname)
# [1] "figures/MyPlot,10,rnd.eps"
}

\author{Henrik Bengtsson}

\seealso{
  To change default device parameters such as the width or the height,
  \code{\link{devOptions}}().
  \code{\link{devNew}}().
}



\keyword{device}
\keyword{utilities}
