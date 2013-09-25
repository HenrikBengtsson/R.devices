library("R.devices")

.devTypeName <- R.devices:::.devTypeName

types <- list(character(0L), "png", "jpg", c("png", "png", "jpeg"))
for (type in types) {
  res <- .devTypeName(type)
  print(res)
  stopifnot(is.character(res));
  stopifnot(is.character(names(res)));
}
