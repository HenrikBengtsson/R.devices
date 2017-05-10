nullfile <- function() {
  switch(.Platform$OS.type,
    windows = "NUL",
    "/dev/null" #nolint
  )
}

is_nullfile <- function(file) {
  file <- normalizePath(file, mustWork = FALSE)
  file <- tolower(file)

  if (.Platform$OS.type == "windows") {
    # Any filename of NUL, NUL.<any extension>, NUL:<any path>
    file <- gsub("[.:].*", "", basename(file))
    (file == "nul")
  } else {
    (file == "/dev/null") #nolint
  }
}
