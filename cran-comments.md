# CRAN submission R.devices 2.13.1
on 2015-09-21

Changes related to R/CRAN per se:

* Explicit import of 'utils' and 'graphics' functions.

* Package tests using x11() caused R to _abort_ on CRAN
  r-patched-solaris-*.  Since it is not clear whether
  capabilities('x11') will properly reflect lack of
  X11 support, I instead use new capabilitiesX11() that
  check x11() in a separate R session, which most likely
  also aborts, but should not affect the main R session.
  If not supported, package tests skips X11 tests.

Thanks in advance


## Notes not sent to CRAN
R.devices have been verified using `R CMD check --as-cran` on:

* Platform x86_64-pc-linux-gnu (64-bit):
  - R version 2.15.3 (2013-03-01)
  - R version 3.0.3 (2014-03-06)
  - R version 3.1.3 (2015-03-09)
  - R version 3.2.2 (2015-08-14)
  - R version 3.2.2 Patched (2015-09-18 r69397)

* Platform: x86_64-apple-darwin13.4.0 (64-bit):
  - R version 3.2.2 Patched (2015-09-05 r69301)

* Platform x86_64-w64-mingw32/x64 (64-bit):
  - R version 3.1.3 (2015-03-09)
  - R version 3.2.2 Patched (2015-09-13 r69380)
  - R Under development (unstable) (2015-09-20 r69402)

It has also verified using the <http://win-builder.r-project.org/> service.

Moreover, the updates cause no issues for any of the following 7 reverse dependencies on CRAN and Bioconductor: aroma.affymetrix 2.13.2, aroma.core 2.13.1, babel 0.2-6, matrixStats 0.14.2, MPAgenomics 1.1.2, PSCBS 0.45.1 and R.rsp 0.20.0
