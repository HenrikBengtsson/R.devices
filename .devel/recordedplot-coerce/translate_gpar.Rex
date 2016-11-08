library("future")
library("R.devices")
source("parse_GPar.R")

makePlot <- function() {
  pars <- list(bg="#AABBCCFF", fg="#CCDDEEFF", family="serif", col="#11223344", ann=FALSE, adj=0.1, bty="n", cex=2.6, cex.lab=1.12, cex.main=1.13, crt=0.8, lheight=2.1, lab=c(3,3,5), las=2, lty=4L, lwd=3.14, ljoin=0L, lend=1L, lmitre=2.3, mgp=c(2.5, 1.5, 0.5), pch=2L, ps=5.0, pty="s", smo=2.71, srt=78.9, tck=0.6, tcl=0.7, xaxp=c(0.1,0.2,4L), xaxs='i', xaxt='n', font=2L, xlog=TRUE, xpd=TRUE, yaxp=c(0.3,0.4,2L), ylog=TRUE, col.axis="#33445566", mar=c(1.1,2.1,1.1,0.1), mex=1.34)
  
  g <- R.devices::capturePlot({
    layout(matrix(6:1, nrow=3, ncol=2, byrow=FALSE))
    par(pars)
    plot(1:10)
    lines(1:10, 1:10)
    pars$fig <- par("fig")
    pars$fin <- par("fin")
    pars$plt <- par("plt")
    pars$pin <- par("pin")
    pars$mex <- par("mex")
  })

  attr(g, "pars") <- pars
  attr(g, ".Platform") <- .Platform
  attr(g, ".Machine") <- .Machine
  attr(g, "R.version") <- R.version
  attr(g, "Sys.info") <- Sys.info()
  g
} ## makePlot()

gpar <- function(x) {
  stopifnot(inherits(x, "recordedplot"))
  idx <- which(sapply(x, FUN=function(x) identical(attr(x, "pkgName"), "graphics")))
  stopifnot(length(idx) > 0)
  raw <- x[[idx]]
  stopifnot(is.raw(raw))
  raw
} ## gpar()

`gpar<-` <- function(x, value) {
  stopifnot(is.raw(value))
  stopifnot(inherits(x, "recordedplot"))
  idx <- which(sapply(x, FUN=function(x) identical(attr(x, "pkgName"), "graphics")))
  stopifnot(length(idx) > 0)
  x[[idx]] <- value
  invisible(x)
} ## gpar<-()

writeGPar <- function(g, pathname=sprintf("gpar,%s.bin", attr(g, "R.version")$arch)) {
  writeBin(as.raw(gpar(g)), con=pathname)
  pathname
} ## writeGPar()

garch <- function(g) {
  raw <- gpar(g)
  n <- length(raw)
  if (n == 35992L) return(64L)
  if (n == 35956L) return(32L)
  warning(sprintf("Unknown length(gpar) = %d. Will assume 64 bit.", n))
}

readGPar <- function(pathname) {
  n <- file.size(pathname)
  raw <- base::readBin(pathname, what="raw", n=n)
  x64 <- if (n == 35992L) TRUE else if (n == 35956L) FALSE else stop(n)
  con <- rawConnection(raw, open="rb")
  on.exit(close(con))
  parse_GPar(con, x64=x64)
} ## readGPar()

g64 <- makePlot()
pathname <- writeGPar(g64)

g32 %<-% makePlot()
pathname <- writeGPar(g32)


makePlot <- function() {
  R.devices::capturePlot({
    print(ggplot2::qplot(mpg, wt, data = mtcars))
  })
}

g64 <- makePlot()
g32 %<-% makePlot()

g64b <- as.architechture(g32, ptrsize=8L)
eq <- all.equal(g64b, g64, check.attributes=FALSE)
print(eq)

g32b <- as.architechture(g64b, ptrsize=4L)
g64c <- as.architechture(g32b, ptrsize=8L)
eq <- all.equal(g64c, g64b, check.attributes=FALSE)
print(eq)

pars <- attr(g64, "pars")
stopifnot(all.equal(attr(g32, "pars"), pars))

pathnames <- dir(pattern="gpar,.*[.]bin$")
gparList <- lapply(pathnames, FUN=readGPar)
gparList <- lapply(gparList, FUN=function(x) x[names(x) != "PAD"])
pad64pos <- lapply(gparList, FUN=function(x) {
  pad64 <- which(names(x) == "PAD64")
  pos <- unlist(lapply(x[pad64], FUN=attr, "pos"))
  if (length(pos) == 0) return(integer(0L))
  names(pos) <- names(x)[pad64+1L]
  pos
})
gparList <- lapply(gparList, FUN=function(x) x[names(x) != "PAD64"])
eq <- all.equal(gparList[[1]], gparList[[2]])
print(eq)
print(pad64pos)


stop("XX")
gpars <- readGPar(pathname)
str(gpars, list.len=Inf)

pads <- sapply(gpars[names(gpars) == "PAD"], FUN=length)
print(pads)
sum(pads)

truth <- pars
names <- names(truth)
names[names == "cex"] <- "cexbase"
names[names == "cexlab"] <- "cex.lab"
names[names == "cexmain"] <- "cex.main"
names(truth) <- names
keys <- names(pars)
keys <- setdiff(keys, c("lty", "ps", "smo", "tck", "fig"))
for (key in keys) {
  if (is.numeric(gpars[[key]])) {
    eq <- all(abs(gpars[[key]] - pars[[key]]) < 1e-6)
  } else {
    eq <- all(gpars[[key]] == pars[[key]])
  }
  if (!eq) {
    str(list(key=key, truth=pars[[key]], parsed=gpars[[key]]))
    stop("PARSE ERROR: Invalid field value: key")
  }
}
