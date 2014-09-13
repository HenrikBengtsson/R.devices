# Without attaching package
opts <- R.devices::devOptions("png")
print(opts)

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

# Setting a custom option
devOptions("png", foo=list(a=1, b=pi))
str(devOptions("png")$foo)

# Setting option to NULL, i.e. drop it
devOptions("png", foo=NULL)
str(devOptions("png")$foo)
str(devOptions("png"))

# Get individual device options
print(getDevOption("png", "width"))
