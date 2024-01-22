%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  favicon.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{favicon}
\alias{favicon}


\title{Favicon graphics device}

\description{
 Device driver for PNG favicons (Favorite icon) also known as
 shortcut icon, Web site icon, tab icon or bookmark icon.
 This driver is the same as the png driver where some arguments
 have different default values.
}

\usage{
favicon(filename="favicon.png", width=32L, height=width, bg="transparent",
  par=list(mar = c(0, 0, 0, 0)), ...)
}

\arguments{
  \item{filename}{Default file name (pattern).}
  \item{width, height}{The width and height of the figure.}
  \item{par}{A named \code{\link[base]{list}} of graphical parameters to use.}
  \item{...}{Other arguments accepted by \code{png()}.}
}

\value{
  A plot device is opened; nothing is returned.
}

\examples{\dontrun{
  favicon(width=32L)

  # is identical to

  suppressWarnings({
    png("favicon.png", width=32L, height=32L, bg="transparent",
                       par=list(mar=c(0,0,0,0)))
  })
}}

\keyword{device}

\seealso{
  Internally, \code{\link[grDevices]{png}} is used.
  %% Add HTML Favicon script
  %% toFavicon(plot(1, col="blue", bg="yellow",
  %%           pch=21, cex=4, lwd=4, axes=FALSE))
  \if{html}{\out{
   <script>
    var link = document.createElement('link');
    link.rel = 'icon';
    link.href = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAADFBMVEX9/v0AAP/9/v3//wBEQjoBAAAABHRSTlP//wD//gy7CwAAAGJJREFUOI3N0rESwCAIA9Ag///PXdoiBk0HhmbNO49DMETQCexNCSyFgdlGoO5DYOr9ThLgPosA7osIQP0sHuDOog8UI/ALa988wzdwXJRctf4s+d36YPTJ6aMd8ux3+QO4ABTtB85yDAh9AAAAAElFTkSuQmCC";
    document.getElementsByTagName('head')[0].appendChild(link);
   </script>
  }}
}

\author{Henrik Bengtsson}



\keyword{device}
\keyword{internal}
