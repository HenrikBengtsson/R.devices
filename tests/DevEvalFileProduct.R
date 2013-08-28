options("devEval/args/field"="*")

res <- R.devices::toPNG("foo", tags=c("a", "b"), aspectRatio=0.7, {
  plot(1:10)
})
print(res)
str(res)

for (ff in c("name", "fullname", "filename", "pathname", "dataURI")) {
  cat(sprintf("%s: %s\n", ff, substring(res[[ff]], 1, 50)))
}
