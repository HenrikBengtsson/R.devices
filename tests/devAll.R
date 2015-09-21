message("*** devAll() ...")

library("R.devices")

devAll <- R.devices:::devAll

print(devAll())

message("*** devAll() ... DONE")
