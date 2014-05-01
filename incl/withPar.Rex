withPar({
  layout(1:4)

  withPar({
    plot(1:10)
    plot(10:1)
  }, pch=4)

  withPar({
    plot(1:10)
    plot(10:1)
  }, pch=0, bg="yellow")
}, mar=c(2,2,1,1))
