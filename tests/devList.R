library("R.devices")

res <- devList()
print(res)
stopifnot(is.integer(res))
stopifnot(is.character(names(res)))

res <- devList(dropNull=FALSE)
print(res)
stopifnot(is.integer(res))
stopifnot(is.character(names(res)))

res <- devList(interactiveOnly=TRUE)
print(res)
stopifnot(is.integer(res))
stopifnot(is.character(names(res)))

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Labels
# - - - - - - - - - - - - - - - - - - - - - - - - -
devSetLabel(which=1L, label="foo")

label <- devGetLabel(which=1L)
print(label)

try(devGetLabel(which=10L))



