# CRAN submission R.devices 2.15.0
on 2016-11-07

I've verified that this submission causes *no* issues for
any of the 8 reverse (non-recursive) package dependencies
available on CRAN and Bioconductor.

On Windows there is the following false-positive error:

Found the following (possibly) invalid URLs:
  URL: https://www.stat.auckland.ac.nz/~paul/Reports/DisplayList/dl-record.html
    From: man/capturePlot.Rd
    Status: Error
    Message: libcurl error code 35
    error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert
	handshake failure

Thanks in advance



## Notes not sent to CRAN
The package has been verified using `R CMD check --as-cran` on:

* Platform x86_64-apple-darwin13.4.0 (64-bit) [Travis CI]:
  - R 3.2.4 Revised (2016-03-16 r70336)
  - R version 3.3.2 (2016-10-31)
  
* Platform x86_64-unknown-linux-gnu (64-bit) [Travis CI]:
  - R version 3.2.5 (2016-04-14)
  - R version 3.3.1 (2016-06-21)
  - R Under development (unstable) (2016-11-07 r71636)
  
* Platform x86_64-pc-linux-gnu (64-bit) [r-hub]:
  - R Under development (unstable) (2016-10-30 r71610)

* Platform i686-pc-linux-gnu (32-bit):
  - R version 3.3.2 (2016-10-31)

* Platform x86_64-pc-linux-gnu (64-bit):
  - R version 2.15.3 (2013-03-01)
  - R version 3.1.3 (2015-03-09)
  - R version 3.3.2 (2016-10-31)
  - R version 3.3.2 Patched (2016-11-04 r71626)

* Platform i386-w64-mingw32 (32-bit) [Appveyor CI]:
  - R version 3.3.2 (2016-10-31)
  - R Under development (unstable) (2016-11-06 r71633)

* Platform x86_64-w64-mingw32/x64 (64-bit) [Appveyor CI]:
  - R version 3.3.2 (2016-10-31)
  - R Under development (unstable) (2016-11-06 r71633)

* Platform x86_64-w64-mingw32 (64-bit) [rhub]:
  - R version 3.2.5 (2016-04-14) (*)

* Platform x86_64-w64-mingw32/x64 (64-bit) [win-builder]:
  - R version 3.3.2 (2016-10-31) (*)
  - R Under development (unstable) (2016-09-13 r71239) (*)


(*) Gives an URL check error, which most likely due to the remote webserver,
    cf.  https://stat.ethz.ch/pipermail/r-devel/2016-November/073353.html
