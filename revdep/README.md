# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.2 (2016-10-31) |
|system   |x86_64, linux-gnu            |
|ui       |X11                          |
|language |en                           |
|collate  |en_US.UTF-8                  |
|tz       |US/Pacific                   |
|date     |2016-11-07                   |

## Packages

|package     |*  |version |date       |source         |
|:-----------|:--|:-------|:----------|:--------------|
|base64enc   |   |0.1-4   |2016-11-07 |cran (@0.1-4)  |
|Cairo       |   |1.5-9   |2015-09-26 |cran (@1.5-9)  |
|digest      |   |0.6.10  |2016-08-02 |cran (@0.6.10) |
|R.devices   |   |2.14.0  |2016-03-09 |CRAN (R 3.3.1) |
|R.methodsS3 |   |1.7.1   |2016-02-16 |CRAN (R 3.3.1) |
|R.oo        |   |1.21.0  |2016-11-01 |cran (@1.21.0) |
|R.rsp       |   |0.30.0  |2016-05-15 |CRAN (R 3.3.1) |
|R.utils     |   |2.5.0   |2016-11-07 |cran (@2.5.0)  |

# Check results

8 packages

|package          |version | errors| warnings| notes|
|:----------------|:-------|------:|--------:|-----:|
|aroma.affymetrix |3.0.0   |      0|        0|     0|
|aroma.core       |3.0.0   |      0|        0|     1|
|babel            |0.3-0   |      0|        0|     0|
|inpdfr           |0.1.3   |      0|        0|     0|
|matrixStats      |0.51.0  |      0|        0|     1|
|MPAgenomics      |1.1.2   |      0|        0|     2|
|PSCBS            |0.61.0  |      0|        0|     0|
|R.rsp            |0.30.0  |      0|        0|     0|

## aroma.affymetrix (3.0.0)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/aroma.affymetrix/issues

0 errors | 0 warnings | 0 notes

## aroma.core (3.0.0)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/aroma.core/issues

0 errors | 0 warnings | 1 note 

```
checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘expectile’ ‘HaarSeg’ ‘mpcbs’
```

## babel (0.3-0)
Maintainer: Adam B. Olshen <adam.olshen@ucsf.edu>

0 errors | 0 warnings | 0 notes

## inpdfr (0.1.3)
Maintainer: Rebaudo Francois <francois.rebaudo@ird.fr>

0 errors | 0 warnings | 0 notes

## matrixStats (0.51.0)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/matrixStats/issues

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is  8.1Mb
  sub-directories of 1Mb or more:
    libs   7.4Mb
```

## MPAgenomics (1.1.2)
Maintainer: Samuel Blanck <samuel.blanck@inria.fr>

0 errors | 0 warnings | 2 notes

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘R.devices’ ‘R.filesets’ ‘R.methodsS3’ ‘R.oo’ ‘aroma.affymetrix’
  ‘aroma.cn’ ‘aroma.core’ ‘aroma.light’ ‘matrixStats’ ‘snowfall’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
Unexported object imported by a ':::' call: ‘cghseg:::segmeanCO’
  See the note in ?`:::` about the use of this operator.

checking R code for possible problems ... NOTE
.varregtimescount: no visible global function definition for ‘var’
CGHSEGaroma: no visible global function definition for ‘read.csv’
CGHSEGaroma : <anonymous>: no visible global function definition for
  ‘points’
CGHSEGaroma : <anonymous>: no visible global function definition for
  ‘lines’
CGHSEGaroma : <anonymous>: no visible global function definition for
  ‘write.table’
CGHcall: no visible global function definition for ‘mad’
... 43 lines ...
tumorboostPlot: no visible global function definition for ‘par’
tumorboostPlot: no visible global function definition for ‘axis’
tumorboostPlot: no visible global function definition for ‘points’
Undefined global functions or variables:
  axis head lines lm mad median optim par points read.csv sd var
  write.table
Consider adding
  importFrom("graphics", "axis", "lines", "par", "points")
  importFrom("stats", "lm", "mad", "median", "optim", "sd", "var")
  importFrom("utils", "head", "read.csv", "write.table")
to your NAMESPACE file.
```

## PSCBS (0.61.0)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/PSCBS/issues

0 errors | 0 warnings | 0 notes

## R.rsp (0.30.0)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/R.rsp/issues

0 errors | 0 warnings | 0 notes

