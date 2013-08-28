res <- R.devices:::DevEvalProduct("foo", tags=c("a", "b"))
for (ff in c("fullname", "name", "tags")) {
  cat(sprintf("%s: %s\n", ff, substring(res[[ff]], 1, 50)))
}
