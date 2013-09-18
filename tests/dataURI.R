if (R.utils::isPackageInstalled("base64enc")) {
  options("devEval/args/field"="dataURI")

  uri <- R.devices::toPNG("foo", tags=c("a", "b"), aspectRatio=0.7, {
    plot(1:10)
  })
  str(uri)
}

