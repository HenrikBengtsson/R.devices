#' Get the architecture of an object or coerce it into another
#'
#' @param x The object to be coerced.
#' @param ... (optional) Additional arguments passed to the underlying method.
#'
#' @return
#' \code{architecture()} returns a named list with
#'     character element \code{ostype} and \code{arch},
#'     integer element \code{ptrsize}, and character element \code{endian}.
#'     These elements take a missing values if they could not be inferred.
#'
#' @aliases as.architecture
#' @export
architecture <- function(x, ...) {
  UseMethod("architecture")
}

#' @param ostype A character string, e.g. \code{"unix"} and \code{"windows"}.
#' @param arch A character string, e.g. \code{"i386"}, \code{"i686"} and \code{"x86_64"}.
#' @param ptrsize The target pointer size - either \code{4L} or \code{8L}.
#' @param endian The target endianess - either \code{"little"} or \code{"big"}.
#'
#' @return
#' \code{as.architecture()} returns a coerced version of \code{x}.
#'     If no coercion was needed, then \code{x} itself is returned.
#'
#' @rdname architecture
#' @export
as.architecture <- function(x, ostype=.Platform$OS.type, arch=R.version$arch, ptrsize=.Machine$sizeof.pointer, endian=.Platform$endian, ...) {
  UseMethod("as.architecture")
}


#' @export
setMethodS3("architecture", "RecordedPlot", function(x, ...) {
  system <- attr(x, "system")
  if (is.null(system)) return(NextMethod())

  ostype <- system$ostype
  if (is.null(ostype)) ostype <- NA_character_

  arch <- system$arch
  if (is.null(arch)) arch <- NA_character_
  
  ptrsize <- system$ptrsize
  if (is.null(ptrsize)) {
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
  }
  
  endian <- system$endian
  if (is.null(ptrsize)) endian <- NA_character_

  list(ostype=ostype, arch=arch, ptrsize=ptrsize, endian=endian)
}) ## architecture() for RecordedPlot


#' @export
setMethodS3("architecture", "recordedplot", function(x, ...) {
  ## OS type is unknown by default
  ostype <- NA_character_
  
  ## Architecture label is unknown by default
  arch <- NA_character_

  ## Guess pointer size for size of 'gpar' element
  ## NOTE: This is not always a correct guess, but
  ##       it's better than nothing. /HB 2016-09-18
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

  ## Endian is unknown by default
  endian <- NA_character_

  list(ostype=ostype, arch=arch, ptrsize=ptrsize, endian=endian)
}) ## architecture() for recordedplot



#' @export
setMethodS3("as.architecture", "recordedplot", function(x, ostype=.Platform$OS.type, arch=R.version$arch, ptrsize=.Machine$sizeof.pointer, endian=.Platform$endian, ...) {
  stop_if_not(is.character(arch), length(arch) == 1)
  stop_if_not(ptrsize %in% c(4L, 8L))
  stop_if_not(is.character(endian), length(endian) == 1, (is.na(endian) || endian %in% c("little", "big")))

  ## Default pointer size is 8 bytes (64-bit)
  x_arch <- architecture(x)

  ## Nothing to do?
  if (!is.na(arch) && !is.na(x_arch$arch) && arch == x_arch$arch && ptrsize == x_arch$ptrsize) return(x)

  ## SPECIAL: Source and target architectures are known
  ## to be compatible even though their ptrsizes differ
  if (all(c(arch, x_arch$arch) %in% c("i386", "x86_64"))) {
    # i386 (e.g. 32-bit Windows) <-> x86_64 (64-bit Linux)
    return(x)
  }

  ## Endianess?
  if (is.na(endian) || is.na(x_arch$endian) || endian != x_arch$endian) {
    stop(sprintf("NON-IMPLEMENTED FEATURE: Don't know how to coerce from %s to %s endianess", sQuote(x_arch$endian), sQuote(endian)))
  }

  ## Pointer size, i.e. 32-bit or 64-bit address space?
  known_sizes <- c("32 bit"=35956L, "64 bit"=35992L)
  if (is.na(x_arch$ptrsize)) {
     stop(sprintf("Failed to infer architecture.  The size of the %s structure is not among the known ones (%s): %d bytes", sQuote("gpar"), paste(sprintf("%s: %s bytes", names(known_sizes), known_sizes), collapse=", "), length(gpar(x))))
  }

  ## Nothing to do?
  if (ptrsize == x_arch$ptrsize && endian == x_arch$endian) return(x)

  ## Coerce 'gpar' structure
  pad64pos <- c(cex=29, crt=53, lwd=325, ps=389, srt=405,
                heights=597, plt=35485, mar=35549, mex=35621)
  gpar <- gpar(x)
  pkgName <- attr(gpar, "pkgName")

  if (x_arch$ptrsize == 8L && ptrsize == 4L) {
    ## 64-bit -> 32-bit
    drop <- rep(pad64pos, each=4L) + 0:3
    gpar <- gpar[-drop]
  } else if (x_arch$ptrsize == 4L && ptrsize == 8L) {
    ## 32-bit -> 64-bit
    for (pos in pad64pos) gpar <- append(gpar, raw(4L), after=pos-1L)
  }

  attr(gpar, "pkgName") <- pkgName

  ## Keep the result only if padded to a known length
  if (length(gpar) %in% known_sizes) gpar(x) <- gpar

  x
}) ## as.architecture() for recordedplot


## Internal gpar() and gpar<-() functions for recordedplot
gpar <- function(x) {
  stop_if_not(inherits(x, "recordedplot"))
  idx <- which(sapply(x, FUN=function(x) identical(attr(x, "pkgName"), "graphics")))
  stop_if_not(length(idx) > 0)
  raw <- x[[idx]]
  stop_if_not(is.raw(raw))
  raw
} ## gpar()


`gpar<-` <- function(x, value) {
  stop_if_not(is.raw(value))
  stop_if_not(inherits(x, "recordedplot"))
  idx <- which(sapply(x, FUN=function(x) identical(attr(x, "pkgName"), "graphics")))
  stop_if_not(length(idx) > 0)
  x[[idx]] <- value
  invisible(x)
} ## gpar<-()

#' @export
setMethodS3("as.architecture", "RecordedPlot", function(x, ...) {
  y <- NextMethod()
  system <- attr(x, "system")
  if (is.null(system)) return(y)

  ## Update 'system' attribute
  attr(y, "system") <- NULL
  arch <- architecture(y)
  if (is.na(arch$ostype)) arch$ostype <- system$ostype
  if (is.na(arch$ptrsize)) arch$ptrsize <- system$ptrsize
  if (is.na(arch$endian)) arch$endian <- system$endian
  attr(y, "system") <- arch
  
  y
})
