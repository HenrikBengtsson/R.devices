# CRAN submission R.devices 2.13.2
on 2015-12-16

Note to CRAN:

It is not clear to my why package tests in `tests/devEval.R`
causes a _core dump_ on Solaris.  The core dump occurs when it tries
to open an X11 device.  The test checks for X11 support via
`capabilities()["X11"]`.  If not supported, then X11-related tests are
skipped.  This core dump appeared with previous versions of R.devices
as well (started since I added conditional X11 tests) meaning it has
been report as an ERROR on Solaris for several months now.  For full
`R CMD check` output on Solaris, please see
https://cran.r-project.org/web/checks/check_results_R.devices.html

In the meanwhile of trying to figure out the above, I would like to
submit version 2.13.2 that fixes a few bugs that affects all users.

Thanks in advance


## Notes not sent to CRAN
The package has been verified using `R CMD check --as-cran` on:

* Platform x86_64-unknown-linux-gnu (64-bit) [Travis CI]:
  - R version 3.1.3 (2015-03-09)
  - R version 3.2.2 (2015-08-14)
  - R Under development (unstable) (2015-12-14 r69773)
  
* Platform x86_64-pc-linux-gnu (64-bit):
  - R version 2.14.0 (2011-10-31)
  - R version 3.2.3 (2015-12-10)
  - R version 3.2.3 Patched (2015-12-14 r69775)
  - R Under development (unstable) (2015-12-15 r69777)

* Platform: x86_64-apple-darwin10.8.0 (64-bit):
  - R version 3.1.1 (2014-07-10)

* Platform x86_64-w64-mingw32/x64 (64-bit) [Appveyor CI]:
  - R Under development (unstable) (2015-12-14 r69775)

* Platform x86_64-w64-mingw32/x64 (64-bit):
  - R version 3.2.3 (2015-12-10)
  - R version 3.2.3 Patched (2015-12-10 r69760)
  - R Under development (unstable) (2015-12-12 r69765)

It has also verified using the <http://win-builder.r-project.org/> service.

Moreover, the updates cause no issues for any of the following 7
reverse dependencies on CRAN and Bioconductor: MPAgenomics 1.1.2,
PSCBS 0.60.0, R.rsp 0.20.0, aroma.affymetrix 2.14.0,
aroma.core 2.14.0, babel 0.2-6 and matrixStats 0.50.1.
