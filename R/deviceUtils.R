###########################################################################/**
# @RdocFunction devIsOpen
#
# @title "Checks if zero or more devices are open or not"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a named @logical @vector with @TRUE if a device is open,
#   otherwise @FALSE.
# }
#
# @examples "../incl/deviceUtils.Rex"
#
# @author
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devIsOpen <- function(which=dev.cur(), ...) {
  # Nothing to do?
  if (length(which) == 0L) {
    res <- logical(0L)
    names(res) <- character(0L)
    return(res)
  }

  devList <- .devList()
  devs <- devList[which]

  labels <- names(devs)
  isOpen <- sapply(devs, FUN=function(dev) !is.null(dev) && nzchar(dev))
  isOpen <- isOpen & !is.na(labels)
  isOpen
} # devIsOpen()





###########################################################################/**
# @RdocFunction devList
#
# @title "Lists the indices of the open devices named by their labels"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{interactiveOnly}{If @TRUE, only open interactive/screen devices
#     are returned.}
#   \item{dropNull}{If @TRUE, the "null" device (device index 1) is
#     not returned.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a named @integer @vector.
# }
#
# @author
#
# \seealso{
#   \code{\link[grDevices:dev]{dev.list}()}.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devList <- function(interactiveOnly=FALSE, dropNull=TRUE, ...) {
  devList <- .devList()

  # Return only opened devices
  isOpen <- sapply(devList, FUN=function(dev) (dev != ""))
  names(isOpen) <- names(devList)
  idxs <- which(isOpen)

  # Exclude the "null" device?
  if (dropNull) {
    idxs <- idxs[-1L]
  }

  # Include only interactive devices?
  if (interactiveOnly) {
    types <- unlist(devList[idxs])
    keep <- devIsInteractive(types)
    idxs <- idxs[keep]
  }

  idxs
} # devList()



###########################################################################/**
# @RdocFunction devGetLabel
#
# @title "Gets the labels of zero or more devices"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character @vector.
#   If a device does not exist, an error is thrown.
# }
#
# @author
#
# \seealso{
#   @see "devSetLabel" and @see "devList".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devGetLabel <- function(which=dev.cur(), ...) {
  devList <- devList(dropNull=FALSE)
  if (is.numeric(which)) {
    devs <- devList[match(which, devList)]
  } else {
    devs <- devList[which]
  }
  labels <- names(devs)
  unknown <- which[is.na(labels)]
  if (length(unknown) > 0L) {
    known <- names(devList(dropNull=FALSE))
    if (length(known) == 0L) known <- "<none>"
    throw(sprintf("Cannot get device label. No such device: %s (known devices: %s)", paste(sQuote(unknown), collapse=", "), paste(sQuote(known), collapse=", ")))
  }
  labels
} # devGetLabel()



###########################################################################/**
# @RdocFunction devSetLabel
#
# @title "Sets the label of a device"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{label}{A @character string.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @see "devGetLabel" and @see "devList".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devSetLabel <- function(which=dev.cur(), label, ...) {
  # Argument 'which':
  if (length(which) != 1L) {
    throw("Argument 'which' must be a scalar: ", paste(which, collapse=", "))
  }

  devList <- .devList()
  if (is.numeric(which)) {
    idx <- which
  } else {
    idx <- .devListIndexOf(which)
  }

  # Unknown devices?
  if (devList[[idx]] == "") {
    known <- names(devList(dropNull=FALSE))
    if (length(known) == 0L) known <- "<none>"
    throw(sprintf("Cannot set device label. No such device: %s (known devices: %s)", paste(sQuote(which), collapse=", "), paste(sQuote(known), collapse=", ")))
  }

  # Update the label
  if (is.null(label))
    label <- ""
  names(devList)[idx] <- label

  assign(".Devices", devList, envir=baseenv())
}





###########################################################################/**
# @RdocFunction devSet
#
# @title "Activates a device"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).
#     If neither, then a label corresponding to the checksum of
#     \code{which} as generated by @see "digest::digest" is used.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns what \code{\link[grDevices:dev]{dev.set}()} returns.
# }
#
# @author
#
# \seealso{
#   @see "devOff" and @see "devDone".
#   Internally, \code{\link[grDevices:dev]{dev.set}()} is used.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devSet <- function(which=dev.next(), ...) {
  args <- list(...)

  # Argument 'which':
  if (!is.numeric(which) || length(which) != 1L) {
    if (length(which) != 1L || !is.character(which)) {
      # To please R CMD check
      requireNamespace("digest") || throw("Package not loaded: digest")
      which <- digest::digest(which)
    }

    if (is.character(which)) {
      args$label <- which
      idx <- .devListIndexOf(which, error=FALSE)
      # If not existing, open the next available one
      if (is.na(idx)) {
        which <- .devNextAvailable()
      } else {
        devList <- devList(dropNull=FALSE)
        which <- devList[[idx]]
      }
    }
  }

  # Argument 'which':
  if (length(which) != 1L) {
    throw("Argument 'which' must be a scalar: ", paste(which, collapse=", "))
  }

  if (which < 2L || which > 63L) {
    throw("Cannot set device: Argument 'which' is out of range [2,63]: ", which)
  }

  if (devIsOpen(which)) {
    # Active already existing device
    return(dev.set(which))
  }

  # Identify set devices that needs to be opened inorder for
  # the next device to get the requested index
  if (which == 2L) {
    toBeOpened <- c()
  } else {
    toBeOpened <- setdiff(2:(which-1L), dev.list())
  }

  len <- length(toBeOpened)
  if (len > 0L) {
    tempfiles <- sapply(toBeOpened, FUN=function(...) tempfile())

    # Make sure to close all temporary devices when exiting function
    on.exit({
      for (kk in seq_along(toBeOpened)) {
        dev.set(toBeOpened[kk])
        dev.off()
        if (file.exists(tempfiles[kk])) file.remove(tempfiles[kk])
      }
    }, add=TRUE)

    # Create a dummy temporary postscript device (which is non-visible)
    for (kk in seq_along(toBeOpened)) {
      postscript(file=tempfiles[kk])
    }
  }

  # Open the device
  res <- do.call(devNew, args=args)

  invisible(res)
} # devSet()




###########################################################################/**
# @RdocFunction devOff
#
# @title "Closes zero or more devices"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns \code{\link[grDevices:dev]{dev.cur}()}.
# }
#
# @author
#
# \seealso{
#   @see "devDone".
#   Internally, \code{\link[grDevices:dev]{dev.off}()} is used.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devOff <- function(which=dev.cur(), ...) {
  # Nothing to do?
  if (length(which) == 0L) return(dev.cur())

  # Only close each device once
  which <- unique(which)
  if (length(which) > 1L) {
    lapply(which, FUN=devOff)
    return(dev.cur())
  }

  # Nothing to do?
  if (!devIsOpen(which)) {
    return(dev.cur())
  }

  # Identify device
  which <- devSet(which)

  # Reset the label
  devSetLabel(which, label=NULL)

  # Close device
  dev.off(which)

  return(dev.cur())
} # devOff()




###########################################################################/**
# @RdocFunction devDone
#
# @title "Closes zero or more open devices except screen (interactive) devices"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) @vector or a label (@character) @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns (invisibly) \code{\link[grDevices:dev]{dev.cur}()}.
# }
#
# @author
#
# \seealso{
#   @see "devOff".
#   @see "grDevices::dev.interactive".
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devDone <- function(which=dev.cur(), ...) {
  # Nothing to do?
  if (length(which) == 0L) return(dev.cur())

  # Only close each device once
  which <- unique(which)
  if (length(which) > 1L) {
    lapply(which, FUN=devDone)
    return(dev.cur())
  }

  # Nothing to do?
  if (!devIsOpen(which)) {
    return(invisible(dev.cur()))
  }

  # Do nothing?
  if (is.numeric(which) && length(which) == 1L && which <= 1L) {
    return(invisible(dev.cur()))
  }

  which <- devSet(which)
  if (which != 1L) {
    type <- tolower(names(which))
    type <- gsub(":.*", "", type)

    knownInteractive <- deviceIsInteractive()
    knownInteractive <- tolower(knownInteractive)
    isOnScreen <- (is.element(type, knownInteractive))
    if (!isOnScreen)
      devOff(which)
  }

  return(invisible(dev.cur()))
} # devDone()


###########################################################################/**
# @RdocFunction devIsInteractive
#
# @title "Checks whether a device type is interactive or not"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{types}{A @character @vector.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a @logical @vector with @TRUE if the device type is interactive,
#   otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   Internally, @see "grDevices::deviceIsInteractive" is used.
# }
#
# @keyword device
# @keyword utilities
#*/###########################################################################
devIsInteractive <- function(types, ...) {
  # Known interactive devices
  knownInteractive <- grDevices::deviceIsInteractive()
  knownInteractive <- c(knownInteractive, "CairoWin", "CairoX11")
##  knownInteractive <- c(knownInteractive, "Cairo")

  # Return all known?
  if (missing(types)) return(knownInteractive)

  # Nothing to do?
  if (length(types) == 0L) {
    res <- logical(0L)
    names(res) <- character(0L)
    return(res)
  }

  if (length(types) > 1L) {
    res <- sapply(types, FUN=devIsInteractive)
    if (is.character(types)) names(res) <- types
    return(res)
  }


  # Sanity check
  stop_if_not(length(types) == 1L)

  # Investigate one type below
  type0 <- type <- types

  if (is.function(type)) {
    for (name in knownInteractive) {
      if (exists(name, mode="function")) {
        dev <- get(name, mode="function")
        if (identical(dev, type)) {
          res <- TRUE
          names(res) <- name
          return(res)
        }
      }
    }
    res <- FALSE
    names(res) <- NA_character_
  } else {
    type <- as.character(type)
    # Device type aliases?
    type <- .devTypeName(type)
    type <- tolower(type)

    # An known one?
    res <- is.element(type, tolower(knownInteractive))
    names(res) <- type0
  }

  res
} # devIsInteractive()



devAll <- local({
  # Memoize results, because this function is called many many
  # times either directly or indirectly by various functions.
  .devAll <- NULL

  isFALSE <- function(x) is.logical(x) && length(x) == 1L && !is.na(x) && !x

  base_capabilities <- local({
    res <- base::capabilities()
    function(force=FALSE) {
      if (force) res <<- base::capabilities()
      res
    }
  })

  supports <- function(type, pkg="grDevices") {
    capabilities <- function() character(0L)
    if (isPackageInstalled(pkg)) {
      if (pkg == "Cairo") {
        ns <- getNamespace("Cairo")
        Cairo.capabilities <- get("Cairo.capabilities", envir=ns, mode="function")
        capabilities <- function() {
          res <- Cairo.capabilities()
          names <- sprintf("Cairo%s", toupper(names(res)))
          names <- gsub("WIN", "Win", names, fixed=TRUE)
          names(res) <- names
          res
        }
      } else if (pkg == "grDevices") {
        capabilities <- base_capabilities
      }
    }
    x <- capabilities()
    !isFALSE(x[type])
  } # supports()


  function(force=FALSE, ...) {
    res <- .devAll
    if (force || is.null(res)) {
      if (force) base_capabilities(force=TRUE)

      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # Setup all possible devices
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      res <- list()

      ## grDevices
      res <- c(res, list(
        bmp          = "grDevices::bmp",
        jpeg         = "grDevices::jpeg",
        pdf          = "grDevices::pdf",
        pictex       = "grDevices::pictex",
        png          = "grDevices::png",
        postscript   = "grDevices::postscript",
        quartz       = "grDevices::quartz",
        svg          = c("grDevices::svg", "needs::cairo"),
        cairo_pdf    = c("grDevices::cairo_pdf", "needs::cairo"),
        cairo_ps     = c("grDevices::cairo_ps", "needs::cairo"),
        tiff         = "grDevices::tiff",
        win.metafile = "grDevices::win.metafile",
        xfig         = "grDevices::xfig"
      ))
      res <- c(res, list(
        windows    = "grDevices::windows",
        x11        = "grDevices::x11",
        X11        = "grDevices::X11"
      ))

      # R.devices
      res <- c(res, list(
        nulldev = c("R.devices::nulldev",
                    "grDevices::png", "grDevices::postscript"),
        eps     = c("R.devices::eps",
                    "grDevices::postscript"),
        favicon = c("R.devices::favicon",
                    "grDevices::png"),
        jpeg2   = c("R.devices::jpeg2",
                    "grDevices::bitmap", "grDevices::postscript"),
        png2    = c("R.devices::png2",
                    "grDevices::bitmap", "grDevices::postscript")
      ))

      ## Cairo package
      res <- c(res, list(
        CairoPDF  = c("Cairo::CairoPDF",
                      "grDevices::pdf"),
        CairoPS   = c("Cairo::CairoPS",
                      "grDevices::postscript"),
        CairoPNG  = c("Cairo::CairoPNG",
                      "grDevices::png"),
        CairoJPEG = c("Cairo::CairoJPEG",
                      "grDevices::jpeg"),
        CairoTIFF = c("Cairo::CairoTIFF",
                      "grDevices::tiff"),
        CairoSVG  = c("Cairo::CairoSVG",
                      "grDevices::svg")
      ))
      res <- c(res, list(
        CairoWin  = c("Cairo::CairoWin",
                      "grDevices::windows"),
        CairoX11  = c("Cairo::CairoX11",
                      "grDevices::x11")
      ))

      ## RStudio devices
      res <- c(res, list(
        RStudioGD  = c("tools:rstudio::RStudioGD",
                       "grDevices::png")
      ))
      
      ## JavaGD
      ## JavaGD=c("JavaGD::JavaGD")


      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # Drop devices this system is not capable of
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      for (type in names(res)) {
        # Assume it is supported, unless...
        supported <- TRUE

        for (fcn in res[[type]]) {
          pattern <- "^(.+)::(.+)$"
          pkg <- gsub(pattern, "\\1", fcn)
          name <- gsub(pattern, "\\2", fcn)

          if (pkg == "needs") {
            if (!supports(name)) {
              supported <- FALSE
              break
            }
            next
          } else if (pkg == "tools:rstudio") {
            supported <- FALSE
            pos <- match(pkg, search())
            if (!is.na(pos)) {
              env <- pos.to.env(pos)
              supported <- exists("RStudioGD", envir=env, mode="function")
            }
            break
          }

          if (!isPackageInstalled(pkg)) {
            supported <- FALSE
            break
          }

          ns <- getNamespace(pkg)
          if (!exists(name, envir=ns, mode="function")) {
            supported <- FALSE
            break
          }

          if (!supports(type, pkg=pkg)) {
            supported <- FALSE
            break
          }
        } # for (fcn ...)

        # Drop any 'needs::*'
        res[[type]] <- grep("^needs::", res[[type]], value=TRUE, invert=TRUE)

        # Not supported?
        if (!supported) res[[type]] <- NULL
      } # for (type ...)


      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # Drop devices based on 'R_R_DEVICES_TYPES_DROP'
      # This is can be used to emulate 'R CMD check' on other OSes
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      drop <- Sys.getenv("R_R_DEVICES_TYPES_DROP", "")
      drop <- unlist(strsplit(drop, split = ",", fixed = TRUE))
      res <- res[setdiff(names(res), drop)]

      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # Order by name
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      o <- order(names(res))
      res <- res[o]

      # Memoize
      .devAll <<- res
    } # if (force ...)

    res
  }
}) # devAll()



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# BEGIN: Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.devList <- function() {
  if (exists(".Devices")) {
    devList <- get(".Devices")
  } else {
    devList <- list("null device")
  }

  labels <- names(devList)
  if (is.null(labels)) {
    labels <- paste("Device", seq_along(devList), sep=" ")
    names(devList) <- labels
    assign(".Devices", devList, envir=baseenv())
  } else {
    # Update the names
    labels <- names(devList)
    idxs <- which(nchar(labels) == 0L)
    if (length(idxs) > 0L) {
      labels[idxs] <- paste("Device", idxs, sep=" ")
    }
    names(devList) <- labels
  }

  devList
} # .devList()

## Gets the devList() index of a device by label
.devListIndexOf <- function(labels, error=TRUE) {
  # Nothing to do?
  if (length(labels) == 0L) {
    res <- integer(0L)
    names(res) <- character(0L)
    return(res)
  }

  devList <- devList(dropNull=FALSE)
  idxs <- match(labels, names(devList))
  names(idxs) <- labels

  # Sanity check
  if (error) {
    if (any(is.na(idxs)))
      throw("No such device: ", paste(labels[is.na(idxs)], collapse=", "))
  }

  idxs
} # .devListIndexOf()


.devNextAvailable <- function() {
  # All open devices
  devList <- dev.list()

  if (length(devList) == 0L)
    return(2L)

  devPossible <- seq(from=2L, to=max(devList)+1L)
  devFree <- setdiff(devPossible, devList)

  devFree[1L]
} # .devNextAvailable()


.devTypeName <- function(types, pattern=FALSE, knownTypes=names(devAll()), mustWork=TRUE, ...) {
  # Nothing todo?
  if (!is.character(types)) {
    return(types)
  }

  names <- names(types)
  if (is.null(names)) {
    names(types) <- types
  }

  # Device type aliases
  aliases <- c(
    ## Aliases first
    "{ps}"           = "{postscript}",
    "{jpg}"          = "{jpeg}",
    "{win.metafile}" = "{wmf}",
    ## Actual aliases 
    "{bmp}"          = "bmp",
    "{eps}"          = "eps",
    "{emf}"          = "emf",
    "{CairoWin}"     = "CairoWin",
    "{CairoX11}"     = "CairoX11",
    "{favicon}"      = "favicon",
    "{jpeg}"         = "jpeg|CairoJPEG",
    "{nulldev}"      = "nulldev",
    "{quartz}"       = "quartz",
    "{pdf}"          = "pdf|cairo_pdf|CairoPDF",
    "{pictex}"       = "pictex",
    "{png}"          = "png|cairo_png|CairoPNG|png2",
    "{postscript}"   = "postscript|cairo_ps|CairoPS",
    "{RStudioGD}"    = "RStudioGD",
    "{svg}"          = "svg|CairoSVG",
    "{tiff}"         = "tiff|CairoTIFF",
    "{windows}"      = "windows",
    "{wmf}"          = "wmf",
    "{x11}"          = "x11|X11|CairoX11",
    "{xfig}"         = "xfig"
  )
  for (name in names(aliases)) {
    alias <- aliases[[name]]
    option <- sprintf("R.devices.alias.%s", gsub("[{}]", "", name))
    alias <- getOption(option, alias)
    types <- gsub(name, alias, types, fixed = TRUE)
  }

  # Select a working device type out of alternatives, e.g. "png|png2"
  idxs <- grep("|", types, fixed = TRUE)
  for (idx in idxs) {
    type <- types[[idx]]
    alts <- unlist(strsplit(type, split = "|", fixed = TRUE))
    alts <- alts[alts %in% knownTypes]
    if (length(alts) == 0L && mustWork) {
      stop("None of the alternative device types are supported: ", sQuote(type))
    }
    if (length(alts) > 1L) alts <- alts[1]
    types[[idx]] <- alts
  }

  # Match to known set of device types by regular expression?
  if (pattern) {
    types <- as.list(types)
    for (kk in seq_along(types)) {
      typeKK <- types[[kk]]
      pattern <- sprintf("^%s$", typeKK)
      idxs <- grep(pattern, knownTypes)
      if (length(idxs) > 0L) {
        typesKK <- knownTypes[idxs]
        names(typesKK) <- rep(typeKK, times=length(typesKK))
        types[[kk]] <- typesKK
      } else {
        names(typeKK) <- typeKK
        names(types[[kk]]) <- typeKK
      }
    } # for (kk ...)
    names <- unlist(lapply(types, FUN = base::names), use.names = FALSE)
    types <- unlist(types, use.names = FALSE)
    names(types) <- names
  }

  # Common aliases
  names <- names(types)
  types[types == "jpg"] <- "jpeg"
  types[types == "ps"] <- "postscript"
  names(types) <- names

  types
} # .devTypeName()

.devTypeExt <- function(types, ...) {
  if (is.function(types)) {
    types <- .devTypeNameFromFunction(types)
  }
  types <- as.character(types)
  exts <- types

  ## Cairo package
  pattern <- "^Cairo(JPEG|PDF|PNG|PS|SVG|TIFF)$"
  idxs <- grep(pattern, exts)
  exts[idxs] <- tolower(gsub(pattern, "\\1", exts[idxs]))

  ## cairo_* devices
  pattern <- "^cairo_(pdf|ps)$"
  exts <- gsub(pattern, "\\1", exts)

  ## Recognize types of any case. Always return in lower case.
  exts <- tolower(exts)

  # Common type-to-extension conversions
  exts[exts == "win.metafile"] <- "wmf"
  exts[exts == "png2"] <- "png"
  exts[exts == "jpeg"] <- "jpg"
  exts[exts == "jpeg2"] <- "jpg"
  exts[exts == "postscript"] <- "ps"

  exts
} # .devTypeExt()


.devTypeNameFromFunction <- function(fcn, knownTypes = devAll(), ...) {
  stop_if_not(length(fcn) == 1, is.function(fcn))
  knownFcns <- lapply(knownTypes, FUN = function(x) {
    eval(parse(text = x[1]), enclos = baseenv())
  })
  name <- NULL
  for (name in names(knownFcns)) {
    if (identical(fcn, knownFcns[[name]])) return(name)
  }
  NA_character_
} # .devTypeNameFromFunction()


.devEqualTypes <- (function() {
   # Recorded known results
   known <- list()

   function(type, other, args=list()) {
     # (a) Same types?
     if (identical(unname(type), unname(other))) return(TRUE)

     # (b) A known equality?
     if (is.character(type) && is.character(other)) {
       res <- known[[type]][other]
       if (is.logical(res)) return(res)
     }

     # (c) Comparing to a device function?
     if (is.function(type) && is.character(other)) {
       if (!exists(other, mode="function")) return(FALSE)
       otherT <- get(other, mode="function")
       if (identical(unname(type), unname(otherT))) return(TRUE)
     } else if (is.function(other) && is.character(type)) {
       if (!exists(type, mode="function")) return(FALSE)
       typeT <- get(type, mode="function")
       if (identical(unname(typeT), unname(other))) return(TRUE)
     }

     # (d) Check if temporarily opening the requested type actually
     # creates a device matching the existing one.
     typeT <- tryCatch({
       local({
         do.call(type, args=args)
         on.exit(dev.off(), add=TRUE)
       })
       names(dev.cur())
     }, error=FALSE)
     if (identical(typeT, FALSE)) return(FALSE)

     if (is.function(other)) {
       other <- tryCatch({
         local({
           do.call(other, args=args)
           on.exit(dev.off(), add=TRUE)
           names(dev.cur())
         })
       }, error=FALSE)
       if (identical(other, FALSE)) return(FALSE)
     }

     res <- (typeT == other)

     # Record result to avoid opening next?
     if (is.character(type) && is.character(other)) {
       known[[type]][other] <<- res
     }

     res
  }
})() # .devEqualTypes()


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# END: Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
