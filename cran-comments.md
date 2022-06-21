# CRAN submission R.devices 2.17.1

on 2022-06-21

I've verified this submission has no negative impact on any of the 12 reverse package dependencies available on CRAN.

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub    | mac/win-builder |
| ------------- | ------ | -------- | --------------- |
| 3.4.x         | L      |          |                 |
| 3.5.x         | L      |          |                 |
| 3.6.x         | L      |          |                 |
| 4.1.x         | L      |          |                 |
| 4.2.x         | L M W  | L M M1 W | M1 W            |
| devel         | L   W  | L        |    W            |

*Legend: OS: L = Linux, M = macOS, M1 = macOS M1, W = Windows*


R-hub checks:

```r
res <- rhub::check(platform = c(
  "debian-clang-devel", "debian-gcc-patched", "linux-x86_64-centos-epel",
  "macos-highsierra-release-cran", "macos-m1-bigsur-release",
  "windows-x86_64-release"))
print(res)
```

gives

```
```
