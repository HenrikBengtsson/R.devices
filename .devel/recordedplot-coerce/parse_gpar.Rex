library("R.devices")
source("parse_gpar.R")

path <- system.file("exdata", package="R.devices")
filename <- "capturePlot,arch=i386,ptrsize=4,endian=little.recordedplot.Rbin"
filename <- "capturePlot,arch=i686,ptrsize=8,endian=little.recordedplot.Rbin"
filename <- "capturePlot,arch=x86_64,ptrsize=8,endian=little.recordedplot.Rbin"
# g <- readRDS(pathname)

g <- capturePlot({ par(lheight=2.1); plot(1:10) })

g8_0 <- g
gpar8_0 <- as.GPar(g8_0)

g8_1 <- as.architecture(g8_0, ptrsize=8L)
stopifnot(identical(g8_1, g8_0))
writeBin(as.raw(gpar(g8_1)), con="gpar8_1.bin")
gpar8_1 <- as.GPar(g8_1)
stopifnot(all.equal(gpar8_1, gpar8_0))

g4_1 <- as.architecture(g8_1, ptrsize=4L)
writeBin(as.raw(gpar(g4_1)), con="gpar4_1.bin")
gpar4_1 <- as.GPar(g4_1)
stopifnot(all.equal(gpar4_1, gpar8_1))

g8_2 <- as.architecture(g4_1, ptrsize=8L)
writeBin(as.raw(gpar(g8_2)), con="gpar8_2.bin")
gpar8_2 <- as.GPar(g8_2)
stopifnot(all.equal(gpar8_2, gpar8_1))


library("R.devices")
path <- system.file("exdata", package="R.devices")
filename <- "capturePlot,arch=i386,ptrsize=4,endian=little.recordedplot.Rbin"
ga <- readRDS(file.path(path, filename))
qa <- as.GPar(ga)

#pa <- gpar(ga)

filename <- "capturePlot,arch=i686,ptrsize=4,endian=little.recordedplot.Rbin"
gb <- readRDS(file.path(path, filename))
qb <- as.GPar(gb)

#pb <- gpar(gb)

stopifnot(all.equal(qb, qa))
print(all.equal(gb, ga))
