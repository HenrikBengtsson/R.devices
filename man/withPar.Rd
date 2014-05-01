%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  withPar.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{withPar}
\alias{withPar}


\title{Evaluate an R expression with graphical parameters set temporarily}

\description{
 Evaluate an R expression with graphical parameters set temporarily.
}

\usage{
withPar(expr, ..., args=list(), envir=parent.frame())
}

\arguments{
  \item{expr}{The R expression to be evaluated.}
  \item{...}{Named options to be used.}
  \item{args}{(optional) Additional named options specified as a named \code{\link[base]{list}}.}
  \item{envir}{The \code{\link[base]{environment}} in which the expression should be evaluated.}
}

\value{
 Returns the results of the expression evaluated.
}

\author{Henrik Bengtsson}

\examples{
withPar({
  layout(1:4)

  withPar({
    plot(1:10)
    plot(10:1)
  }, pch=4)

  withPar({
    plot(1:10)
    plot(10:1)
  }, pch=0, bg="yellow")
}, mar=c(2,2,1,1))
}

\seealso{
  Internally, \code{\link[base]{eval}}() is used to evaluate the expression,
  and \code{\link[graphics]{par}} to set graphical parameters.
}



\keyword{IO}
\keyword{programming}
