# Allows conflicts. For more information, see library() and
# conflicts() in [R] base.
.conflicts.OK <- TRUE;


## .First.lib <- function(libname, pkgname) {
.onAttach <- function(libname, pkgname) { 
  pkg <- Package(pkgname);
  pos <- getPosition(pkg);
  assign(pkgname, pkg, pos=pos);

  packageStartupMessage(getName(pkg), " v", getVersion(pkg), " (", 
    getDate(pkg), ") successfully loaded. See ?", pkgname, " for help.");
}

############################################################################
# HISTORY: 
# 2010-11-05
# o Created.
############################################################################
