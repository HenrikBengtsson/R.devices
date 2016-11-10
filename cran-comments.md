# CRAN submission R.devices 2.15.1
on 2016-11-09

This is a hotfix for R.devices 2.15.0 where one of the package
tests failed on Solaris SPARC because endianess coercion is not
supported by the package for those tests.

Thanks in advance



## Notes not sent to CRAN
The package has been verified using `R CMD check --as-cran` on:

* Platform x86_64-apple-darwin13.4.0 (64-bit) [Travis CI]:
#  - R 3.2.4 Revised (2016-03-16 r70336)
#  - R version 3.3.2 (2016-10-31)
  
* Platform x86_64-unknown-linux-gnu (64-bit) [Travis CI]:
  - R version 3.2.5 (2016-04-14)
  - R version 3.3.1 (2016-06-21)
  - R Under development (unstable) (2016-11-08 r71638)
  
* Platform x86_64-pc-linux-gnu (64-bit) [r-hub]:
  - R version 3.3.1 (2016-06-21)
  - R Under development (unstable) (2016-10-30 r71610)

* Platform i686-pc-linux-gnu (32-bit):
  - R version 3.3.2 (2016-10-31)

* Platform x86_64-pc-linux-gnu (64-bit):
  - R version 3.3.2 (2016-10-31)

* Platform i386-w64-mingw32 (32-bit) [Appveyor CI]:
  - R version 3.3.2 (2016-10-31)
  - R Under development (unstable) (2016-11-07 r71637)

* Platform x86_64-w64-mingw32/x64 (64-bit) [Appveyor CI]:
  - R version 3.3.2 (2016-10-31)
  - R Under development (unstable) (2016-11-07 r71637)

* Platform x86_64-w64-mingw32 (64-bit) [r-hub]:
  - R version 3.2.5 (2016-04-14) (*)

* Platform x86_64-w64-mingw32/x64 (64-bit) [win-builder]:
  - R version 3.3.2 (2016-10-31) (*)
  - R Under development (unstable) (2016-10-07 r71637) (*)


(*) Gives an URL check error, which most likely due to the remote webserver,
    cf.  https://stat.ethz.ch/pipermail/r-devel/2016-November/073353.html
