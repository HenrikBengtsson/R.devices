# Without attaching package
opts0 <- R.devices::devOptions()
print(opts0)

opts0eps <- R.devices::devOptions("eps")
str(opts0eps)

opts <- R.devices::devOptions("png")
print(opts)

# With attaching package
library("R.devices")
opts1 <- R.devices::devOptions()
print(opts1)

opts1eps <- R.devices::devOptions("eps")
str(opts1eps)

stopifnot(identical(opts1eps, opts0eps))
stopifnot(identical(opts1, opts0))


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

opts1 <- R.devices::devOptions()
print(opts1)
