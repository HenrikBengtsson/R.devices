# CRAN submission R.devices 2.17.1

on 2022-06-21

I've verified this submission has no negative impact on any of the 12 reverse package dependencies available on CRAN.

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub | mac/win-builder |
| ------------- | ------ | ----- | --------------- |
| 3.5.x         | L      |       |                 |
| 4.1.x         | L      |       |                 |
| 4.2.x         | L      |       |                 |
| 4.3.x         | L M W  | . . . | M1 W            |
| devel         | L   W  | .     |    W            |

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
── R.devices 2.17.1: OK

  Build ID:   R.devices_2.17.1.tar.gz-dc868d984f094c3dbe4530e093f557db
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  5m 12.1s ago
  Build time: 5m 10s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── R.devices 2.17.1: OK

  Build ID:   R.devices_2.17.1.tar.gz-9aa1dae224b647bbbd9d483408dfdc91
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  5m 12.1s ago
  Build time: 4m 37.8s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── R.devices 2.17.1: NOTE

  Build ID:   R.devices_2.17.1.tar.gz-a73b58130ca243919cb7c4455c88e359
  Platform:   CentOS 8, stock R from EPEL
  Submitted:  5m 12.2s ago
  Build time: 4m 10.6s

❯ checking package dependencies ... NOTE
  Package suggested but not available for checking: ‘Cairo’

0 errors ✔ | 0 warnings ✔ | 1 note ✖

── R.devices 2.17.1: OK

  Build ID:   R.devices_2.17.1.tar.gz-719d56058e79427facee24a9f6f1e0cd
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  5m 12.2s ago
  Build time: 1m 39.5s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── R.devices 2.17.1: OK

  Build ID:   R.devices_2.17.1.tar.gz-965506b7e14e464281df9ed7d853e993
  Platform:   Apple Silicon (M1), macOS 11.6 Big Sur, R-release
  Submitted:  5m 12.2s ago
  Build time: 57.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── R.devices 2.17.1: OK

  Build ID:   R.devices_2.17.1.tar.gz-03a8cf8c98d447d6ae62c7536ef72881
  Platform:   Windows Server 2008 R2 SP1, R-release, 32/64 bit
  Submitted:  5m 12.2s ago
  Build time: 3m 27.6s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
