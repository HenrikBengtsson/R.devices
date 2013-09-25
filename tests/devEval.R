library("R.devices")

types <- list(
  character(0L),
  "png",
  "jpg",
  c("png", "png", "jpeg"),
  "png,jpg,pdf"
)

for (type in types) {
  cat("Device types: ", paste(sQuote(type), collapse=", "), "\n", sep="")
  res <- devEval(type, aspectRatio=2/3, {
    plot(1:10)
  })
  print(res)
  stopifnot(length(res) == length(unlist(strsplit(type, split=","))))
}
