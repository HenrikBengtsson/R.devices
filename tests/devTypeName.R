message("*** devTypeName() ...")

library("R.devices")
printf <- R.utils::printf

.devTypeName <- R.devices:::.devTypeName

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# By name
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
types <- list(empty=character(0L), png="png", jpg="jpg", mixed=c("png", "png", "jpeg"))
for (name in names(types)) {
  type <- types[[name]]
  printf("%s: .devTypeName(%s): ", name, deparse(type))
  res <- .devTypeName(type)
  printf("'%s'\n", deparse(res))
  stopifnot(is.character(res))
  stopifnot(is.character(names(res)))
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# By function (returns the same function)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
types <- list(png=grDevices::png, jpg=grDevices::jpeg)
for (name in names(types)) {
  type <- types[[name]]
  printf("%s: .devTypeName(%s): ", name, deparse(args(type)))
  res <- .devTypeName(type)
  printf("'%s'\n", deparse(args(res)))
  stopifnot(is.function(res))
  stopifnot(identical(res, type))
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Special cases
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## Special case: Default device
type <- getOption("device")

## Special case: "*" matches itself, not every known type
known <- c("*", "png", "pdf")
res <- .devTypeName("*", pattern=TRUE, knownTypes=known)
stopifnot(identical(res, c("*"="*")))
res <- .devTypeName("p.*", pattern=TRUE, knownTypes=known)
stopifnot(identical(unname(res), c("png", "pdf")))

message("*** devTypeName() ... DONE")
