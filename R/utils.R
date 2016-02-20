nullfile <- function() {
  if (.Platform$OS.type == "windows") return("NUL")
  "/dev/null"
}
