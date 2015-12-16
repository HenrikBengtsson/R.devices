message("*** devNew() ...")

library("R.devices")


message("*** devNew(which=which) ...")

idx <- devNew()
plot(1:10)
idx2 <- devNew(which=idx)
plot(1:10)
devOff(idx2)
if (idx2 != idx) devOff(idx)

message("*** devNew(which=which) ... DONE")


message("*** devNew(aspectRatio) ...")
## Height is inferred
devNew(width=10, aspectRatio=1.5)
plot(1:10)
devOff()

## Width is inferred
devNew(height=10, aspectRatio=1.5)
plot(1:10)
devOff()
message("*** devNew(aspectRatio) ... DONE")


message("*** devNew(scale) ...")

devNew(width=10, scale=1.5)
plot(1:10)
devOff()

devNew(height=10, scale=1.5)
plot(1:10)
devOff()

## Force 'width' from device options
devNew(aspectRatio=NULL, scale=1.5)
plot(1:10)
devOff()

message("*** devNew(scale) ... DONE")


message("*** devNew() - warnings ...")

ok <- tryCatch({
  devNew(width=10, height=10, aspectRatio=1.5)
  FALSE
}, warning = function(warn) {
  print(warn)
  TRUE
})
stopifnot(ok)

res <- try(devNew(par=list(1)))
stopifnot(inherits(res, "try-error"))

message("*** devNew() - warnings ... DONE")


message("*** devNew() - errors ...")

res <- try(devNew(par=c(pch=1)))
stopifnot(inherits(res, "try-error"))

res <- try(devNew(par=list(1)))
stopifnot(inherits(res, "try-error"))

devNew(label="foo")
plot(1:10)
res <- try(devNew(label="foo"))
stopifnot(inherits(res, "try-error"))
devOff()

message("*** devNew() - errors ... DONE")

message("*** devNew() ... DONE")
