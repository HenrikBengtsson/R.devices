library("R.devices")

types <- list(c(), "png", "x11", c("png", "jpeg", "png", "x11"))
for (types in types) {
  print(types)
  res <- devIsInteractive(types)
  print(res)
  stopifnot(is.logical(res))
  stopifnot(is.character(names(res)))
  stopifnot(length(res) == length(types))
  stopifnot(all(names(res) == types))
}

