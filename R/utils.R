nullfile <- function() {
  switch(.Platform$OS.type,
    windows = "NUL",
    "/dev/null"
  )
}

is_nullfile <- function(file) {
  normalizePath(file, mustWork = FALSE) == nullfile()
}
