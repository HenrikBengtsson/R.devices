%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  deviceUtils.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{devIsOpen}
\alias{devIsOpen}


\title{Checks if zero or more devices are open or not}

\description{
 Checks if zero or more devices are open or not.
}

\usage{
devIsOpen(which=dev.cur(), ...)
}

\arguments{
  \item{which}{An index (\code{\link[base]{numeric}}) \code{\link[base]{vector}} or a label (\code{\link[base]{character}}) \code{\link[base]{vector}}.}
  \item{...}{Not used.}
}

\value{
  Returns a named \code{\link[base]{logical}} \code{\link[base]{vector}} with \code{\link[base:logical]{TRUE}} if a device is open,
  otherwise \code{\link[base:logical]{FALSE}}.
}

\examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Use devices for conditional processing of code. 
# Close devices to rerun code.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cat("Currently opened device:\n")
print(devList())

# Alt A: Use device index counter (starting with the 16:th)
fig <- 15
if (!devIsOpen(fig <- fig + 1)) {
  devSet(fig)
  cat("Figure", fig, "\n")
  plot(1:10)
}
cat("Currently opened device:\n")
print(devList())

if (!devIsOpen(fig <- fig + 1)) {
  devSet(fig)
  cat("Figure", fig, "\n")
  plot(1:10)
}
cat("Currently opened device:\n")
print(devList())

# Alt B: Use device labels
if (!devIsOpen(label <- "part 1")) {
  devSet(label)
  cat("Part 1\n")
  plot(1:10)
}
cat("Currently opened device:\n")
print(devList())


if (!devIsOpen(label <- "part 2")) {
  devSet(label)
  cat("Part 2\n")
  plot(1:10)
}
cat("Currently opened device:\n")
print(devList())
}

\author{Henrik Bengtsson}



\keyword{device}
\keyword{utilities}
