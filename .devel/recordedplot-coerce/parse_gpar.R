#' Parse a GPar structure from its raw byte format
#'
#' @param con A binary connection.
#' @param ptrsize Address pointer size - either 4L or 8L.
#'
#' @return A named list.
#'
#' @details
#' This is just an internal function used to parse the GPar byte sequence
#' that is part of an recordedplot object into a names list structure.
#'
#' @importFrom R.utils hpaste
#' @importFrom grDevices rgb
#' @keyword internal
parse_GPar <- local({
  hpaste <- R.utils::hpaste
  
  readBin2 <- function(con, what, size, n=1L, ...) {
    pos <- seek(con) + 1L  ## Index with offset 1 (not 0 as the file itself)
    pad <- switch(what, integer=pos %% 4, double=pos %% 8, pos %% 4)
    whatT <- switch(what, char="raw", color="raw", pad="raw", what)
    value <- readBin(con=con, what=whatT, size=size, n=n, ...)
    calls <- sys.calls()
    names <- sapply(calls, FUN=function(call) as.character(call[[1]]))
    names <- grep("parse_", names, value=TRUE)
    call <- names[2]
    pos2 <- seek(con)  ## Index with offset 1 (not 0 as the file itself)
    if (what == "char") {
      value <- rawToChar(value, multiple=FALSE)
    }
    valueT <- if (is.character(value)) sQuote(value) else value
    cat(sprintf("%s @ [%d,%d] (%d) => %s: {%s}\n", call, pos, pos2, pad, what, hpaste(valueT)))
    if (what == "double") {
  #    stopifnot(pad == 0)
    }
    if (what == "pad") {
      to_pad <- 8 - pos %% 8
  #    if(n != to_pad) stop(sprintf("pos=%d, to_pad=%d, n=%d", pos, to_pad, n))
    }
  #  attr(value, "pos") <- c(pos, pos2)
    value
  } ## readBin2()
  
  parse_unsigned_short <- function(con, n=1L) readBin2(con, what="integer", size=2L, signed=FALSE, n=n)
  parse_unsigned_int <- function(con, n=1L) {
    ## WORKAROUND: readBin(.., size=4L, signed=FALSE) is not supported
    value <- readBin2(con, what="integer", size=4L, signed=TRUE, n=n)
    if (value < 0) value <- value + as.integer(2^24)
    attr(value, "note") <- "should be: unsigned int"
    value
  }
  
  parse_byte <- function(con, n=1L) readBin2(con, what="integer", size=1L, signed=FALSE, n=n)
  
  parse_pad <- function(con, n=1L) {
    pos <- seek(con)
    value <- readBin2(con, what="pad", size=1L, n=n)
    stopifnot(all(value == 0))
    attr(value, "pos") <- pos
    value
  }
  
  parse_int <- function(con, n=1L) readBin2(con, what="integer", size=4L, signed=TRUE, n=n)
  
  parse_double <- function(con, size=8L, n=1L) readBin2(con, what="double", size=size, signed=TRUE, n=n)
  
  parse_unsigned_char <- function(con, n=1L) readBin2(con, what="character", size=1L, signed=FALSE, n=n)
  
  parse_char <- function(con, n=1L) readBin2(con, what="char", size=1L, n=n)
  
  nenum <- 0L
  parse_enum <- function(con) {
    nenum <<- nenum + 1L
    parse_int(con)
  }
  
  parse_Rboolean <- function(con) {
    value <- parse_enum(con)
    value <- as.logical(value)
    value
  }
  
  parse_rcolor <- function(con) {
    value <- readBin2(con, what="color", size=1L, n=4L)
    do.call(rgb, args=c(as.list(as.integer(value)), maxColorValue=255L))
  }
  
  parse_R_GE_lineend <- function(con) parse_enum(con)-1L
  
  parse_R_GE_linejoin <- function(con) parse_enum(con)-1L
  
  parse_GUnit <- function(con) parse_enum(con)
  
  parse_GTrans <- function(con) {
    list(
      ax = parse_double(con),
      ay = parse_double(con),
      bx = parse_double(con),
      by = parse_double(con)
    )
  }

  MAX_LAYOUT_ROWS <- 200L
  MAX_LAYOUT_COLS <- 200L
  MAX_LAYOUT_CELLS <- 10007L
  
  function(con, ptrsize=4L) {
    parse_pad64 <- function(con) raw(0L)
    if (ptrsize == 8L) {
      parse_pad64 <- function(con) parse_pad(con, n=4L)
    }
  
    list(  
      state = parse_int(con),             ## pos  0-3   0L
      valid = parse_Rboolean(con),        ## pos  4-7   0L
      adj = parse_double(con),            ## pos  8-15  0.1
      ann = parse_Rboolean(con),          ## pos 16-19  0L
      bg = parse_rcolor(con),             ## pos 20-23  {aa,bb,cc,ff}
      bty = parse_char(con),              ## pos 24     'n'
      PAD = parse_pad(con, n=3),          ## pos 25-27
      PAD64 = parse_pad64(con),
      cex_ = parse_double(con),           ## pos 32-39  1.0
      lheight = parse_double(con),        ## pos 40-47  2.1
      col = parse_rcolor(con),            ## pos 48-51  {11,22,33,44}
      PAD64 = parse_pad64(con),
      crt = parse_double(con),            ## pos 56-63  0.8
      din = parse_double(con, n=2),       ## pos 64-79  (0,0)
      err = parse_int(con),               ## pos 80-83  0L
      fg = parse_rcolor(con),             ## pos 84-87  {cc,dd,ee,ff}
      family = parse_char(con, n=201),    ## pos 88-288 'serif'
      PAD = parse_pad(con, n=3),
      font = parse_int(con),              ## pos 292-295 1L
      gamma = parse_double(con),          ## pos 296-303 1.0
      lab = parse_int(con, n=3),          ## pos 304-315 (3L,3L,5L)
      las = parse_int(con),               ## pos 316     2L 
      lty = parse_byte(con, n=4),         ## pos 320-323
      PAD64 = parse_pad64(con),
      lwd = parse_double(con),            ## pos 328-335      3.14
      lend = parse_R_GE_lineend(con),     ## pos 336          1L
      ljoin = parse_R_GE_linejoin(con),   ## pos 340          0L
      lmitre = parse_double(con),         ## pos 344-351      2.3
      mgp = parse_double(con, n=3),       ## pos 352,360,368 (2.5,1.5,0.5)
      mkh = parse_double(con),            ## pos 376-383      0.001
      pch = parse_int(con),               ## pos 384-387      2L
      PAD64 = parse_pad64(con),
      ps = parse_double(con),             ## pos 392          5.0
      smo = parse_int(con),               ## pos 400          2L ???
      PAD64 = parse_pad64(con),           ## pos 404          0L ???
      srt = parse_double(con),            ## pos 408          78.9
      tck = parse_double(con),            ## pos 416          0.6
      tcl = parse_double(con),            ## pos 424          0.7
      xaxp = parse_double(con, n=3),      ## pos 432,440,448  (0.1,0.2,4.0)
      xaxs = parse_char(con),             ## pos 456          'i'
      xaxt = parse_char(con),             ## pos 457          'n'
      PAD = parse_pad(con, n=2),
      xlog = parse_Rboolean(con),         ## pos 451-454      1L
      xpd = parse_int(con),               ## pos 455-458      1L
      oldxpd = parse_int(con),
      yaxp = parse_double(con, n=3),        
      yaxs = parse_char(con),                
      yaxt = parse_char(con),                
      PAD = parse_pad(con, n=2),
      ylog = parse_Rboolean(con),        
      cexbase = parse_double(con),        
      cexmain = parse_double(con),        
      cexlab = parse_double(con),        
      cexsub = parse_double(con),        
      cexaxis = parse_double(con),        
      fontmain = parse_int(con),        
      fontlab = parse_int(con),        
      fontsub = parse_int(con),        
      fontaxis = parse_int(con),        
      colmain = parse_rcolor(con),        
      collab = parse_rcolor(con),        
      colsub = parse_rcolor(con),        
      colaxis = parse_rcolor(con),        
      layout = parse_Rboolean(con),       ## pos 576  1
      numrows = parse_int(con),           ## pos 580  3
      numcols = parse_int(con),           ## pos 584  2
      currentFigure = parse_int(con),     ## pos 588  7
      lastFigure = parse_int(con),        ## pos 592  6
      PAD64 = parse_pad64(con),
      heights = parse_double(con, n=MAX_LAYOUT_ROWS),
      widths = parse_double(con, n=MAX_LAYOUT_COLS),
      cmHeights = parse_int(con, n=MAX_LAYOUT_ROWS),
      cmWidths = parse_int(con, n=MAX_LAYOUT_COLS),
      order = parse_unsigned_short(con, n=MAX_LAYOUT_CELLS),
      rspct = parse_int(con),                
      respect = parse_unsigned_char(con, n=MAX_LAYOUT_CELLS),
      mfind = parse_int(con),                
      PAD = parse_pad(con, n=3),
      fig = parse_double(con, n=4),       ## pos 35432
      fin = parse_double(con, n=2),       ## pos 35464, 35472 (3.5, 2.333)
      fUnits = parse_GUnit(con),          ## pos 35480        6L
      PAD64 = parse_pad64(con),
      plt = parse_double(con, n=4),       ## pos 35488, 35496, 35504, 35512
      pin = parse_double(con, n=2),       ## pos 35520, 35528 (1.77893, 1.77893
      pUnits = parse_GUnit(con),                
      defaultFigure = parse_Rboolean(con),        
      defaultPlot = parse_Rboolean(con),        
      PAD64 = parse_pad64(con),
      mar = parse_double(con, n=4),       ## pos 35552, 35560, 35568, 35576
      mai = parse_double(con, n=4),       ## pos 35584, 35592, 35600, 35608
      mUnits = parse_GUnit(con),          ## pos 35616
      PAD64 = parse_pad64(con),
      mex = parse_double(con),            ## pos 35624  1.34
      oma = parse_double(con, n=4),        
      omi = parse_double(con, n=4),        
      omd = parse_double(con, n=4),        
      oUnits = parse_GUnit(con),        
      pty = parse_char(con),                
      PAD = parse_pad(con, n=3),
      usr = parse_double(con, n=4),        
      logusr = parse_double(con, n=4),
      new = parse_Rboolean(con),        
      devmode = parse_int(con),        
      xNDCPerChar = parse_double(con),        
      yNDCPerChar = parse_double(con),        
      xNDCPerLine = parse_double(con),        
      yNDCPerLine = parse_double(con),        
      xNDCPerInch = parse_double(con),        
      yNDCPerInch = parse_double(con),        
      fig2dev = parse_GTrans(con),        
      inner2dev = parse_GTrans(con),        
      ndc2dev = parse_GTrans(con),        
      win2fig = parse_GTrans(con),        
      scale = parse_double(con)
    )
  } ## parse_GPar()
}) ## local()


as.GPar <- function(x, ...) {
  gpar <- R.devices:::gpar
  stopifnot(inherits(x, "recordedplot"))
  arch <- architecture(x)
  gpar_raw <- gpar(x)
  con <- rawConnection(gpar_raw, open="rb")
  on.exit(close(con))
  gpar <- parse_GPar(con, ptrsize=arch$ptrsize)
  gpar <- gpar[names(gpar) != "PAD"]
  gpar <- gpar[names(gpar) != "PAD64"]
  gpar
} ## as.GPar()


readGPar <- function(pathname) {
  n <- file.size(pathname)
  raw <- base::readBin2(pathname, what="raw", n=n)
  ptrsize <- if (n == 35992L) 8L else if (n == 35956L) 4L else stop(n)
  con <- rawConnection(raw, open="rb")
  on.exit(close(con))
  parse_GPar(con, ptrsize=ptrsize)
} ## readGPar()


writeGPar <- function(g, pathname=sprintf("gpar,%s.bin", attr(g, "R.version")$arch)) {
  gpar <- R.devices:::gpar
  writeBin(as.raw(gpar(g)), con=pathname)
  pathname
} ## writeGPar()
