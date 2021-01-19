# CRAN submission R.devices 2.17.0

on 2021-01-19

This submission addresses the problem where some systems might not have working bmp(), jpeg(), png(), svg(), or tiff() device functions.  This package will now pass 'R CMD check' on also such systems.

I've verified this submission have no negative impact on any of the 10 reverse package dependencies available on CRAN and Bioconductor.

Thank you


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version | GitHub Actions | Travis CI | AppVeyor CI | Rhub | Win-builder |
| --------- | -------------- | --------- | ----------- | ---- | ----------- |
| 3.3.x     | L              |           |             |      |             |
| 3.4.x     | L              |           |             |      |             |
| 3.5.x     | L              |           |             | L    |             |
| 3.6.x     | L              | L M       |             | L    |             |
| 4.0.x     | L M W          | L M       | W           |   S  | W           |
| devel     |       W        | L         | W (32 & 64) | L    | W           |

*Legend: OS: L = Linux, S = Solaris, M = macOS, W = Windows*
