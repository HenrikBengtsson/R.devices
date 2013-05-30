# Allows conflicts. For more information, see library() and
# conflicts() in [R] base.
.conflicts.OK <- TRUE;

.onLoad <- function(libname, pkgname) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Register vignette engines
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  try({
    vignetteEngine <- get("vignetteEngine", envir=asNamespace("tools"));

    # RSP engine
    vignetteEngine("rsp", package=pkgname, pattern="[.][^.]*[.]rsp$",
                    weave=R.rsp::rspWeave, tangle=R.rsp::rspTangle);
  }, silent=TRUE)
}



## .First.lib <- function(libname, pkgname) {
.onAttach <- function(libname, pkgname) {
  pkg <- Package(pkgname);
  pos <- getPosition(pkg);
  assign(pkgname, pkg, pos=pos);
  startupMessage(pkg);
}

############################################################################
# HISTORY:
# 2013-05-30
# o Now registering RSP vignette engines.
# 2010-11-05
# o Created.
############################################################################
