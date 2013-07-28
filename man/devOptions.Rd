%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  devOptions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devOptions}
\alias{devOptions}


\title{Gets the default device options}

\description{
 Gets the default device options as given by predefined devices options adjusted for
 the default arguments of the device function.
}

\usage{
devOptions(type=c("bmp", "cairo_pdf", "cairo_ps", "eps", "jpeg", "jpeg2",
  "pdf", "pictex", "png", "png2", "postscript", "quartz", "svg", "tiff", "win.metafile",
  "windows", "x11", "xfig"), custom=TRUE, special=TRUE, drop=TRUE, options=list(), ...,
  reset=FALSE)
}

\arguments{
  \item{type}{A \code{\link[base]{character}} string or a device \code{\link[base]{function}} specifying
     the device to be queried.  May also be a \code{\link[base]{vector}}, for querying
     device options for multiple devices.}
  \item{custom}{If \code{\link[base:logical]{TRUE}}, also the default settings specific to this
     function is returned. For more details, see below.}
  \item{special}{A \code{\link[base]{logical}}.  For more details, see below.}
  \item{drop}{If \code{\link[base:logical]{TRUE}} and only one device type is queried, then
     a \code{\link[base]{list}} is returned, otherwise a \code{\link[base]{matrix}}.}
  \item{options}{Optional named \code{\link[base]{list}} of settings.}
  \item{...}{Optional named arguments for setting new defaults.
     For more details, see below.}
  \item{reset}{If \code{\link[base:logical]{TRUE}}, the device options are reset to R defaults.}
}

\value{
  If \code{drop=TRUE} and a single device is queries, a named \code{\link[base]{list}} is
  returned, otherwise a \code{\link[base]{matrix}} is returned.
  If a requested device is not implemented/supported on the current system,
  then "empty" results are returned.
  If options were set, that is, if named options were specified via
  \code{...}, then the list is returned invisibly, otherwise not.
}

\details{
 If argument \code{special} is \code{\link[base:logical]{TRUE}}, then the 'width' and 'height'
 options are adjusted according to the rules explained for
 argument 'paper' in \code{\link[grDevices]{pdf}}, \code{\link[grDevices]{postscript}},
 and \code{\link[grDevices]{xfig}}.
}

\section{Setting new defaults}{
 When setting device options, the \code{getOption("devOptions")[[type]]}
 option is modified.  This means that for such options to be effective,
 any device function needs to query also such options, which for instance
 is done by \code{\link{devNew}}().

 Also, for certain devices (eps, pdf, postscript, quartz, windows and x11),
 builtin R device options are set.
}

\examples{
# Tabulate some of the default settings for known devices
print(devOptions()[,c("width", "height", "bg", "fg", "pointsize")])
}

\author{Henrik Bengtsson}



\keyword{device}
\keyword{utilities}
