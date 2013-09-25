library("R.devices")

res <- devList()
print(res)
stopifnot(is.integer(res));
stopifnot(is.character(names(res)));

res <- devList(dropNull=FALSE)
print(res)
stopifnot(is.integer(res));
stopifnot(is.character(names(res)));
