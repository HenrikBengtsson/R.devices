library("R.devices")

message("*** capturePlot() ...")

cat("Default graphics device:\n")
str(getOption("device"))

message("*** capturePlot() - as.architecture() ...")

path <- system.file("exdata", package="R.devices")
pattern <- "^capturePlot,.*[.]rds$"
pathnames <- dir(path=path, pattern=pattern, full.names=TRUE)

for (kk in seq_along(pathnames)) {
  pathname <- pathnames[kk]
  message(sprintf("- File #%d ('%s') ...", kk, pathname))
  
  g <- readRDS(pathname)
  arch <- architecture(g)
  str(arch)

  ## Current as.architecture() cannot coerce endianess
  if (arch$endian == .Platform$endian) {
    g8_1 <- as.architecture(g, ptrsize=8L)
    arch8_1 <- architecture(g8_1)
    str(arch8_1)
  
    g8_1b <- as.architecture(g8_1, ptrsize=8L)
    stopifnot(identical(g8_1b, g8_1))
  
    g4_1 <- as.architecture(g8_1, ptrsize=4L)
    arch4_1 <- architecture(g4_1)
    str(arch4_1)
  
    g8_2 <- as.architecture(g4_1, ptrsize=8L)
    arch8_2 <- architecture(g8_2)
    str(arch8_2)
    stopifnot(identical(g8_2, g8_1))
  
    g_2 <- as.architecture(g)
    arch_2 <- architecture(g_2)
    str(arch_2)
  
    if (getRversion() >= "3.3.0") {
      try(replayPlot(g_2))
    }
  } ## if (arch$endian == .Platform$endian)
} ## for (kk ...)

message("*** capturePlot() - as.architecture() ... DONE")

message("*** capturePlot() - capture and replay ...")

if (getRversion() >= "3.3.0") {
  message("- capture")
  g <- capturePlot({
    plot(1:10)
  })

  message("- system information")
  system <- attr(g, "system")
  print(system)

  message("- saving")
  ## Record for troubleshooting
  tags <- sprintf("%s=%s", names(system), system)
  pathname <- sprintf("capturePlot,%s.rds", paste(tags, collapse=","))
  saveRDS(g, file=pathname)

  message("- architecture")
  print(architecture(g))

  message("- replay")
  ## Replay
  replayPlot(g)

  message("- display")
  ## Display
  print(g)

  message("- toDefault()")
  ## Display with a 2/3 aspect ratio
  toDefault(aspectRatio=2/3, print(g))

  message("- devEval()")
  ## Redraw to many output formats
  devEval(c("png", "eps", "pdf"), aspectRatio=2/3, print(g))

} ## if (getRversion() >= "3.3.0")

message("*** capturePlot() - capture and replay ... DONE")

message("*** capturePlot() ... DONE")
