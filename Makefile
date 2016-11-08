include .make/Makefile

## Avoid overwriting manually created NAMESPACE
rox:
	$(R_SCRIPT) -e "roxygen2::roxygenize(roclets='rd')"
