options("devEval/args/field"="*")

res <- R.devices::toPNG("foo", tags=c("a", "b"), aspectRatio=0.7, {
  plot(1:10)
})
print(res)
str(res)

fields <- c("name", "fullname", "filename", "pathname")
if (R.utils::isPackageInstalled("base64enc")) {
  fields <- c(fields, "dataURI")
}

for (ff in fields) {
  cat(sprintf("%s: %s\n", ff, substring(res[[ff]], 1, 50)))
}
