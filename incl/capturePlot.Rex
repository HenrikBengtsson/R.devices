if (getRversion() >= "3.3.0") {
oopts <- R.devices::devOptions("*", path=file.path(tempdir(), "figures"))

g <- capturePlot({
  plot(1:10)
})

## Display
print(g)

## Display with a 2/3 height-to-width aspect ratio
toDefault(aspectRatio=2/3, { print(g) })

## Redraw to many output formats
devEval(c("{png}", "eps", "{pdf}"), aspectRatio=2/3, print(g))

R.devices::devOptions("*", path=oopts$path)
} ## if (getRversion() >= "3.3.0")
