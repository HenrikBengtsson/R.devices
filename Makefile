include .make/Makefile

## Avoid overwriting manually created NAMESPACE
rox:
	$(R_SCRIPT) -e "roxygen2::roxygenize(roclets='rd')"

spelling:
	$(R_SCRIPT) -e "spelling::spell_check_package()"
	$(R_SCRIPT) -e "spelling::spell_check_files(c('NEWS', dir('vignettes', pattern='[.]rsp$$', full.names=TRUE)), ignore=readLines('inst/WORDLIST', warn=FALSE))"
