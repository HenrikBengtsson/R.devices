if (getRversion() >= "3.3.0") {

g <- capturePlot({
  plot(1:10)
})

## Display
print(g)

## Redraw to many output formats
devEval(c("png", "eps", "pdf"), print(g))

} ## if (getRversion() >= "3.3.0")
