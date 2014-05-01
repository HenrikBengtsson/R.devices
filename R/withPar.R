###########################################################################/**
# @RdocFunction withPar
#
# @title "Evaluate an R expression with graphical parameters set temporarily"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{expr}{The R expression to be evaluated.}
#   \item{...}{Named options to be used.}
#   \item{args}{(optional) Additional named options specified as a named @list.}
#   \item{envir}{The @environment in which the expression should be evaluated.}
# }
#
# \value{
#  Returns the results of the expression evaluated.
# }
#
# @author
#
# @examples "../incl/withPar.Rex"
#
# \seealso{
#   Internally, @see "base::eval" is used to evaluate the expression,
#   and @see "graphics::par" to set graphical parameters.
# }
#
# @keyword IO
# @keyword programming
#*/###########################################################################
withPar <- function(expr, ..., args=list(), envir=parent.frame()) {
  # Argument '.expr':
  expr <- substitute(expr)

  # Argument 'args':
  if (!is.list(args)) {
    throw("Argument 'args' is not a list: ", class(args)[1L])
  }

  # Argument 'envir':
  if (!is.environment(envir)) {
    throw("Argument 'envir' is not a list: ", class(envir)[1L])
  }

  # All arguments specified
  new <- c(list(...), args)

  # Set options temporarily
  if (length(new) > 0L) {
    prev <- par(new)
    on.exit(par(prev))
  }

  eval(expr, envir=envir)
} # withPar()


############################################################################
# HISTORY:
# 2014-05-01
# o Created.
############################################################################
