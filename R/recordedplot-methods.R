#' Get the architecture of an object or coerce it into another
#'
#' @param x The object to be coerced.
#' @param ... (optional) Additional arguments passed to the underlying method.
#'
#' @return
#' \code{architecture()} returns a named list with
#'     integer element \code{ptrsize} and character element \code{endian}.
#'     These elements take a missing values if they could not be inferred.
#'
#' @aliases as.architecture
#' @export
architecture <- function(x, ...) {
  UseMethod("architecture")
}

#' @param ptrsize The target pointer size - either \code{4L} or \code{8L}.
#' @param endian The target endianess - either \code{"little"} or \code{"big"}.
#'
#' @return
#' \code{as.architecture()} returns a coerced version of \code{x}.
#'     If no coercion was needed, then \code{x} itself is returned.
#'
#' @rdname architecture
#' @export
as.architecture <- function(x, ptrsize=.Machine$sizeof.pointer, endian=.Platform$endian, ...) {
  UseMethod("as.architecture")
}


#' @export
architecture.recordedplot <- function(x, ...) {
  ## Default pointer size is 8 bytes (64-bit)
  gpar_raw <- gpar(x)
  n <- length(gpar_raw)
  known_sizes <- c("32 bit"=35956L, "64 bit"=35992L)
  if (n == known_sizes["32 bit"]) {
    ptrsize <- 4L
  } else if (n == known_sizes["64 bit"]) {
    ptrsize <- 8L
  } else {
    ptrsize <- NA_integer_
  }

  ## Assume source endian is 'little' 
  endian <- "little"

  list(ptrsize=ptrsize, endian=endian)
} ## architecture() for recordedplot



#' @export
as.architecture.recordedplot <- function(x, ptrsize=.Machine$sizeof.pointer, endian=.Platform$endian, ...) {
  stopifnot(ptrsize %in% c(4L, 8L))
  endian <- match.arg(endian, choices=c("little", "big"))

  ## Default pointer size is 8 bytes (64-bit)
  arch <- architecture(x)
  if (is.na(arch$ptrsize)) {
     known_sizes <- c("32 bit"=35956L, "64 bit"=35992L)
     stop(sprintf("Failed to infer architecture.  The size of the %s structure is not among the known ones (%s): %d bytes", sQuote("gpar"), paste(sprintf("%s: %s bytes", names(known_sizes), known_sizes), collapse=", "), length(gpar(x))))
  }

  ## Nothing to do?
  if (ptrsize == arch$ptrsize && endian == arch$endian) return(x)

  if (endian != arch$endian) {
    stop(sprintf("NON-IMPLEMENTED FEATURE: Don't know how to coerce from %s to %s endianess", sQuote(arch$endian), sQuote(endian)))
  }

  ## Coerce 'gpar' structure
  pad64pos <- c(cex=28, crt=52, lwd=324, ps=388, srt=404,
                heights=596, plt=35484, mar=35548, mex=35620)
  gpar <- gpar(x)
  pkgName <- attr(gpar, "pkgName")
  
  if (arch$ptrsize == 8L && ptrsize == 4L) {
    ## 64-bit -> 32-bit
    drop <- rep(pad64pos, each=4L) + 0:3
    gpar <- gpar[-drop]
  } else if (arch$ptrsize == 4L && ptrsize == 8L) {
    ## 32-bit -> 64-bit
    for (pos in pad64pos) gpar <- append(gpar, raw(4L), after=pos)
  }

  attr(gpar, "pkgName") <- pkgName
  gpar(x) <- gpar

  arch2 <- architecture(x)
  stopifnot(arch2$ptrsize == ptrsize, arch2$endian == endian)
  
  x
} ## as.architecture() for recordedplot


## Internal gpar() and gpar<-() functions for recordedplot
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
