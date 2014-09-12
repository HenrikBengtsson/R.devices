library("R.devices")

# Options for the PNG device
opts <- devOptions("png")
print(opts)

# Options for the postscript device
opts <- devOptions("postscript")
print(opts)

# Same using alias
opts2 <- devOptions("ps")
print(opts2)
stopifnot(identical(opts2, opts))

# Options for all known devices
opts <- devOptions()
print(opts)
