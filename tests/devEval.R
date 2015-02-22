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
  "eps|postscript|pdf",        # EPS, Postscript or PDF
  "jpeg2|jpeg",                # JPEG via bitmap() or via jpeg()
  "png,jpg|x11|windows"        # == c("png", "jpg|x11|windows")
)

devList0 <- devList()

for (type in types) {
  printf("Any of %s\n", paste(sQuote(type), collapse=" + "))

  # Use try-catch in case not supported on some test systems
  tryCatch({
    res <- devEval(type, name="any", aspectRatio=2/3, scale=1.2, {
      plot(100:1)
    })
    printf("Result: %s (%s)\n\n", sQuote(res), attr(res, "type"))

    devOff()
  }, error = function(ex) {
    printf("Failed: %s\n\n", sQuote(ex$message))
  })
} # for (type ...)

# Sanity check
stopifnot(all.equal(devList(), devList0))


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Plot a parsed expression
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
expr <- substitute(plot(1:10))
tryCatch({
  res <- devEval("png|jpg", name="any", width=480L, height=480L, {
    plot(100:1)
  })
  printf("Result: %s (%s)\n\n", sQuote(res), attr(res, "type"))

  devOff()
}, error = function(ex) {
  printf("Failed: %s\n\n", sQuote(ex$message))
})


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Special cases
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# toX11({ plot(1:10) }) actually results in a call to
# devEval(type="x11", name={ plot(1:10) }); note argument 'name'
# and not 'expr'.  The following tests that devEval() recognizes
# and handles this internally.

## FIXME: The current solution evaluates 'name' internally
## and therefore opens a interactive graphics device.
if (interactive()) {
   res <- toDefault({ plot(1:10) })
   print(res)

   ## FIX ME:
   graphics.off()
}



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Device type specified as a device functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
types <- list(
  png=grDevices::png,
  jpg=grDevices::jpeg
)

for (name in names(types)) {
  cat("Device types: ", paste(sQuote(name), collapse=", "), "\n", sep="")
  type <- types[[name]]
  str(args(type))
  devList0 <- devList()
  res <- devEval(type, ext=name, name="multi", aspectRatio=2/3, {
    plot(1:10)
  })
  print(res)
  stopifnot(length(res) == length(type))
  stopifnot(all.equal(devList(), devList0))
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Special case: Default device
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cat("Device types: 'default'\n")
type <- getOption("device")
str(type)
devList0 <- devList()
res <- devEval(type, ext="default", name="multi", aspectRatio=2/3, {
  plot(1:10)
})
print(res)
wasInteractiveOpened <- (length(setdiff(devList(), devList0)) > 0L)
if (wasInteractiveOpened) devOff()



# Sanity checks
print(devList())
stopifnot(length(devList()) == 0L)
