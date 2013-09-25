library("R.devices")

.devTypeName <- R.devices:::.devTypeName

for (type in list(character(0L), "png", "jpg", c("png", "png", "jpeg"))) {
  res <- .devTypeName(type)
  print(res)
  stopifnot(is.character(res));
  stopifnot(is.character(names(res)));
}
