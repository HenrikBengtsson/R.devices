###########################################################################/**
# @RdocFunction capabilitiesX11
#
# @title "Check whether current R session supports X11 or not"
#
# \description{
#   @get "title".
#
#   Contrary to \code{capabilities("X11")} which only checks for X11
#   support on startup, this function checks whether X11 is supported
#   when it is called.  This is done by querying a temporary R session.
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{(optional) @character strings of command-line options
#   to \code{Rscript}.}
# }
#
# \value{
#   Returns @TRUE if X11 is supported, otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#  @seealso base::capabilities
# }
#
# @keyword device
# @keyword internal
#*/###########################################################################
capabilitiesX11 <- function(...) {
  bin <- file.path(R.home("bin"), "Rscript")
  cmd <- "cat(capabilities('X11'))"
  args <- c(..., "-e", dQuote(cmd))
  value <- system2(bin, args=args, stdout=TRUE)
  as.logical(value)
}
