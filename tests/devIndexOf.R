library("R.devices")

.devIndexOf <- R.devices:::.devIndexOf

for (label in list(character(0L), "Device 1", c("Device 1", "Device 1"), c("Device 1", "FooBar"))) {
  res <- .devIndexOf(label, error=FALSE)
  print(res)
  stopifnot(is.integer(res));
  stopifnot(is.character(names(res)));
}
