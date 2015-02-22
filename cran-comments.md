# CRAN submission R.devices 2.13.0
on 2015-02-21

Changes related to R/CRAN updates:

* Using Title Case.
* Registering S3 methods.
* Using requireNamespace() instead of require().

Follow up on 2015-02-21:
* Dropped 'This package...' from Description.


## Notes not sent to CRAN
R.devices 2.13.0 and its 7 reverse-dependent packages(*) have been verified using `R CMD build` and `R CMD check --as-cran` on

* R version 3.0.3 (2014-03-06) [Platform: x86_64-unknown-linux-gnu(64-bit)].
* R version 3.1.2 Patched (2015-02-19 r67842) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R Under development (unstable) (2015-02-20 r67856) [Platform: x86_64-unknown-linux-gnu (64-bit)].

It has also been verified by the <http://win-builder.r-project.org/> service.

(*) The submitted updates cause no issues for any of the following 7 reverse dependencies on CRAN and Bioconductor: MPAgenomics 1.1.2, PSCBS 0.43.0, R.rsp 0.20.0, aroma.affymetrix 2.13.0, aroma.core 2.13.0, babel 0.2-6 and matrixStats 0.14.0.
