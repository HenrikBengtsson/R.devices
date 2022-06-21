# analysisPipelines

<details>

* Version: 1.0.2
* GitHub: https://github.com/Mu-Sigma/analysis-pipelines
* Source code: https://github.com/cran/analysisPipelines
* Date/Publication: 2020-06-12 08:00:02 UTC
* Number of recursive dependencies: 125

Run `revdep_details(, "analysisPipelines")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages which this enhances but not available for checking:
      'SparkR', 'reticulate'
    ```

*   checking LazyData ... NOTE
    ```
      'LazyData' is specified without a 'data' directory
    ```

# aroma.affymetrix

<details>

* Version: 3.2.0
* GitHub: https://github.com/HenrikBengtsson/aroma.affymetrix
* Source code: https://github.com/cran/aroma.affymetrix
* Date/Publication: 2019-06-23 06:00:14 UTC
* Number of recursive dependencies: 73

Run `revdep_details(, "aroma.affymetrix")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'affy', 'affyPLM', 'gcrma', 'oligo', 'oligoClasses', 'pdInfoBuilder'
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.8Mb
      sub-directories of 1Mb or more:
        R             2.3Mb
        help          1.1Mb
        testScripts   1.3Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘affy’, ‘gcrma’, ‘affyPLM’, ‘oligo’, ‘oligoClasses’
    ```

# aroma.core

<details>

* Version: 3.2.2
* GitHub: https://github.com/HenrikBengtsson/aroma.core
* Source code: https://github.com/cran/aroma.core
* Date/Publication: 2021-01-05 05:10:12 UTC
* Number of recursive dependencies: 48

Run `revdep_details(, "aroma.core")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'sfit', 'expectile', 'HaarSeg', 'mpcbs'
    ```

# dataquieR

<details>

* Version: 1.0.9
* GitHub: NA
* Source code: https://github.com/cran/dataquieR
* Date/Publication: 2021-09-03 12:10:09 UTC
* Number of recursive dependencies: 136

Run `revdep_details(, "dataquieR")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: 'emmeans', 'parallelMap'
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# eoffice

<details>

* Version: 0.2.1
* GitHub: NA
* Source code: https://github.com/cran/eoffice
* Date/Publication: 2020-11-18 21:40:02 UTC
* Number of recursive dependencies: 89

Run `revdep_details(, "eoffice")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: 'rvg', 'flextable'
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# inpdfr

<details>

* Version: 0.1.11
* GitHub: https://github.com/frareb/inpdfr
* Source code: https://github.com/cran/inpdfr
* Date/Publication: 2020-01-16 12:00:02 UTC
* Number of recursive dependencies: 119

Run `revdep_details(, "inpdfr")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: 'tm', 'entropart', 'metacom'
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# MPAgenomics

<details>

* Version: 1.2.3
* GitHub: NA
* Source code: https://github.com/cran/MPAgenomics
* Date/Publication: 2021-03-30 15:50:07 UTC
* Number of recursive dependencies: 52

Run `revdep_details(, "MPAgenomics")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘CGHcall’
    ```

# PointedSDMs

<details>

* Version: 1.0.6
* GitHub: https://github.com/PhilipMostert/PointedSDMs
* Source code: https://github.com/cran/PointedSDMs
* Date/Publication: 2022-06-15 08:20:12 UTC
* Number of recursive dependencies: 131

Run `revdep_details(, "PointedSDMs")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘blockCV’
    
    Packages suggested but not available for checking:
      'sf', 'INLA', 'ggmap', 'kableExtra'
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# R.rsp

<details>

* Version: 0.44.0
* GitHub: https://github.com/HenrikBengtsson/R.rsp
* Source code: https://github.com/cran/R.rsp
* Date/Publication: 2020-07-09 16:20:02 UTC
* Number of recursive dependencies: 18

Run `revdep_details(, "R.rsp")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘R.rsp-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: RRspPackage$capabilitiesOf
    > ### Title: Checks which tools are supported
    > ### Aliases: RRspPackage$capabilitiesOf capabilitiesOf.RRspPackage
    > ###   RRspPackage.capabilitiesOf capabilitiesOf,RRspPackage-method
    > ###   RRspPackage.isCapableOf isCapableOf.RRspPackage
    > ###   isCapableOf,RRspPackage-method
    > ### Keywords: internal methods
    > 
    > ### ** Examples
    > 
    >   # Display which tools are supported by the package
    >   print(capabilitiesOf(R.rsp))
    Error in findAsciiDoc.default(mustExist = FALSE) : 
      Failed to parse version of %s based on captured output: ‘asciidoc’“asciidoc 9.0.0rc1”
    Calls: print ... capabilitiesOf.RRspPackage -> findAsciiDoc -> findAsciiDoc.default
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘000.session_information.R’
      Running ‘LoremIpsum.R’
      Running ‘RspConstruct.R’
      Running ‘RspProduct.R’
      Running ‘RspString.R’
      Running ‘capabilities.R’
     ERROR
    Running the tests in ‘tests/capabilities.R’ failed.
    Complete output:
      > library("R.rsp")
      R.rsp v0.44.0 (2020-07-09 16:20:02 UTC) successfully loaded. See ?R.rsp for help.
      > 
      > cat("Tools supported by the package:\n")
      Tools supported by the package:
      > print(capabilitiesOf(R.rsp))
      Error in findAsciiDoc.default(mustExist = FALSE) : 
        Failed to parse version of %s based on captured output: 'asciidoc'"asciidoc 9.0.0rc1"
      Calls: print ... capabilitiesOf.RRspPackage -> findAsciiDoc -> findAsciiDoc.default
      Execution halted
    ```

