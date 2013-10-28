library("R.devices")

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
  res <- devEval(type, name="multi", aspectRatio=2/3, {
    plot(1:10)
  })
  print(res)
  stopifnot(length(res) == length(unlist(strsplit(type, split=","))))
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# With 'initially' and 'finally' expression
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copy content of current device
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Open device
plot(1:10)

devEval("png,jpg,pdf", name="count", tags="copy")

# Same using a default name
devEval("png,jpg,pdf")

# Close device
devOff()


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copy content of all devices
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Open several devices
idxs <- NULL

idxs <- c(idxs, devNew())
plot(1:10)

idxs <- c(idxs, devNew())
plot(cos)

# Save all
devEval("png,pdf", which=devList())

# Close all opened devices
devOff(idxs)
