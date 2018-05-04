suppressGraphics <- function(expr, envir = parent.frame()) {
  toNullDev({
    value <- expr
  }, envir = envir)
  value
}

