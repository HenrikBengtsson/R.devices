library("R.devices")
library("R.utils")
graphics.off()

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Various types of single and multiple device outputs
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
types <- list(
  character(0L),
  "png",
  "jpg",
  c("png", "png", "jpeg"),
  "png,jpg,pdf"
)

for (type in types) {
  cat("Device types: ", paste(sQuote(type), collapse=", "), "\n", sep="")
  devList0 <- devList()
  res <- devEval(type, name="multi", aspectRatio=2/3, {
    plot(1:10)
  })
  print(res)
  stopifnot(length(res) == length(unlist(strsplit(type, split=","))))
  stopifnot(all.equal(devList(), devList0))
}

# Sanity checks
print(devList())
stopifnot(length(devList()) == 0L)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# With 'initially' and 'finally' expression
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
devList0 <- devList()
devEval(c("png", "jpg"), name="count", {
  plot(1:10)
  count <- count + 1L
}, initially = {
  # Emulate an overhead
  cat("Initiate...")
  count <- 0L
  Sys.sleep(1)
  cat("done\n")
}, finally = {
  cat("Number of image files created: ", count, "\n", sep="")
})
stopifnot(all.equal(devList(), devList0))

# Sanity checks
print(devList())
stopifnot(length(devList()) == 0L)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Try several devices until first successful device is found
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
types <- list(
  "png|jpg|pdf",               # PNG, JPG and then PDF
  "dummy|png|jpg|pdf",         # "Non-existing", PNG, JPG and then PDF
  "quartz|x11|windows",        # Any interactive device (depending on OS)
  c("png|jpg", "x11|windows"), # PNG or JPG and then x11 or windows
  "png,jpg|x11|windows"        # == c("png", "jpg|x11|windows")
)

for (type in types) {
  printf("Any of %s\n", paste(sQuote(type), collapse=" + "))

  # Use try-catch in case not supported on some test systems
  tryCatch({
    res <- devEval(type, name="any", aspectRatio=2/3, {
      plot(100:1)
    })
    printf("Result: %s (%s)\n\n", sQuote(res), attr(res, "type"))
  }, error = function(ex) {
    printf("Failed: %s\n\n", sQuote(ex$message))
  })
} # for (type ...)
