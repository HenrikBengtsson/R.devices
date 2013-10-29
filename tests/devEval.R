library("R.devices")
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
# Copy content of current device
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Open device
plot(1:10)

devList0 <- devList()
devEval("png,jpg,pdf", name="count", tags="copy")
stopifnot(all.equal(devList(), devList0))

# Sanity checks
print(devList())
stopifnot(length(devList()) == 1L)


# Same using a default name
devList0 <- devList()
devEval("png,jpg,pdf")
stopifnot(all.equal(devList(), devList0))
stopifnot(length(devList()) == 1L)

# Close device
devOff()

stopifnot(length(devList()) == 0L)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copy content of all devices
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Open several devices
idxs <- NULL

idxs <- c(idxs, devNew())
plot(1:10)

idxs <- c(idxs, devNew())
plot(cos)

which <- devList()
print(which)

# Save all
devEval("png,pdf", which=which)

# Close all opened devices
devOff(idxs)
