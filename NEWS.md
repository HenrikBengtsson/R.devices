# Version 2.17.3 [2025-12-16]

## Documentation

 * Update URL in vignette to use HTTPS.


# Version 2.17.2 [2024-01-28]

## Documentation

 * Fix minor help-page mistake.

 * LaTeX vignettes failed with `Undefined control
   sequence. \pdfsuppressptexinfo` with old LaTeX versions.


# Version 2.17.1 [2022-06-21]

## Cleanup

 * Package no longer imports `R.utils::inherits()`, which is
   deprecated and will eventually be removed.

 * Vignette now uses `\pdfsuppressptexinfo=-1` to avoid PTEX metadata
   being recorded.
   

# Version 2.17.0 [2021-01-19]

## Significant Changes

 * All `toNNN()` functions now use the corresponding device type alias
   `"{nnn}"` rather than the specific device `nnn`, e.g. `toPNG()`
   will attempt to produce a PNG file using the set of device types
   that alias `"{png}"` specifies, whereas in the past `toPNG()` used
   only `"png"`.

## New Features

 * Added support for specifying alternative device types,
   e.g. `"png|cairo_png"` will use the `"png"` type if available,
   otherwise the `"cairo_png"` type.  If neither are available, an
   informative error message is produced.
   
 * Added support for device alias types, e.g. `"{png}"` expands to
   `"png|cairo_png|CairoPNG|png2"`.

## Bug Fixes

 * `as.architecture()` did not always return the expected `arch`.
 

# Version 2.16.1 [2019-10-22]

## CRAN Policies

 * Package examples no longer outputs to figures/ folder in current
   working directory.  Instead, it's outputting to a temporary folder.
 
## Bug Fixes

 * `as.architecture()` for recordedplot would produce "Error in
   !is.na(arch) && !is.na(arch$arch) : 'length(x) = 4 > 1' in coercion
   to 'logical(1)'" with environment variable
   `_R_CHECK_LENGTH_1_LOGIC2_=true` set.

 * `getDevOption()` could produce "Error in is.character(type) && type
   != "*" : 'length(x) = 3 > 1' in coercion to 'logical(1)'" with
   environment variable `_R_CHECK_LENGTH_1_LOGIC2_=true` set.


# Version 2.16.0 [2018-07-21]

## New Features

 * Add support for RStudio's RStudioGD device, e.g. `toRStudioGD()`
   and `devEval()` with `type = "RStudioGD"`.

 * Added a `"null"` graphics device, `nulldev()`, that voids all
   graphics output.  It may also be opened by `devNew("nulldev")`.
   `devEval("nulldev", <expr>)`, and `toNullDev(<expr>)`, which will
   evaluate the expression while at the same time drop any plot
   output.

 * Added `suppressGraphics()`.
 
## Bug Fixes

 * Package did not install on R (< 3.0.0) because **base64enc** (>=
   0.1-3) failed to to install on those versions. Now require only
   **base64enc** (>= 0.1-2).


# Version 2.15.1 [2016-11-09]
 
## Bug Fixes

 * Calling `devNew(type, ..., aspectRatio)` with `type` being a
   function and neither `width` nor `height` could be inferred from
   the devices type generated an error when trying to generate a
   warning.
 
 * TESTS: Don't test `as.architecture()` on `recordedplot` objects
   that require coercion between endianess, which is yet not
   supported.
 
 
# Version 2.15.0 [2016-11-07]

## New Features

 * Printing a plot recorded by `capturePlot()` now automatically falls
   back to replaying it coerced to the current machine's architecture
   if the default replay fails.
 
 * Added `as.architecture()` for `recordedplot` objects to make it
   easy to coerce between 32-bit and 64-bit versions of a serialized
   recorded plot (e.g. via `capturePlot()`) so that it can be
   replotted everywhere.
 
 
# Version 2.14.0 [2016-03-08]

## New Features

 * Added `capturePlot()` making it possible to capture low-level plot
   commands using `grDevices::recordPlot()` such that the plot can be
   displayed / regenerated elsewhere, e.g. in a different / future R
   session.  Requires R (>= 3.3.0).

## Bug Fixes

 * `devEval(pdf, ...)` without explicit argument `ext` would give an
   error.

## Software Quality

 * Package test coverage is 91%.

 
# Version 2.13.2 [2015-12-16]

## Significant Changes

 * Package requires R (>= 2.14.0), because of `requireNamespace()`.

## Bug Fixes

 * `devSetLabel(which, label)` gave an error if `which` was a label.
 
 * Closing devices by their labels gave an error if they where not
   opened in ordered.

## Software Quality

 * ROBUSTNESS: Increased package test coverage from 72% to 87%.
 
 
# Version 2.13.1 [2015-09-21]

## New Features

 * Add `capabilitiesX11()`.

## Bug Fixes

 * `toX11()` gave error "Device type 'X11' is not known/supported".
 
 * `devOptions(grDevices::png)` returned `devOptions("favicon")` - not
   `devOptions("png")` as expected.

## Code Refactoring

 * Explicit import of **utils** and **graphics** functions. 

 
# Version 2.13.0 [2015-02-21]

## New Features

 * When calling `devEval()` on multiple devices then underlying
   graphics device functions no longer gives an error of unknown
   arguments, which means it is now possible to pass device specific
   arguments also when in multi-device calls, e.g. `devEval(c("x11",
   "png"), res = 100, { plot(1:10) })`.

## Bug Fixes

 * `devNew("quartz", which = "foo")` could set the label of device
   #1(!) when quartz devices was not supported.  This was because
   `quartz()` only gives a warning (and not an error) when it is not
   supported, so the internal code thought the devices was
   successfully opened.
   
 * Renaming incomplete files gave an error if there were already files
   renamed for similar reasons.  Added package test.
 
 * `devEval(type, ...)` gave 'Error in strsplit (type, split = "|",
   fixed = TRUE' if type was a device function. Added package tests
   showing that it's possible to do `devEval(type = grDevices::png,
   ext = "png", plot(1:10))` in addition to `devEval(type = "png", ext
   = "png", plot(1:10))`.

## Software Quality

 * TESTS: Package coverage 74% (was 64%).

## Code Refactoring

 * Cleanup: Using `requireNamespace()` instead of `require()`
   internally.


 
# Version 2.12.0 [2014-09-17]

## New Features

 * DEVICES: Added support for all `Cairo*` devices of the **Cairo**
   package.
 
 * DEVICES: Added `favicon()` device, which is a wrapper for `png()`
   with bells and whistles.  It has its own device options.  Updated
   `toFavicon()` to use default argument `field = "htmlscript"`, which
   generates an HTML script that dynamically sets the favicon.
 
 * Several functions now supports specifying device type names by
   regular expressions, e.g. `devOptions("cairo_.*")` and
   `devEval("cairo_.*", name = "foo", { plot(1:10) })`.  The latter
   will output one image file for each available `cairo_.*` device.
 
 * Added support for "global" device options to fall back on if no set
   for the device type queried, e.g. `devOptions("*", pointsize =
   14)`.
 
 * Now arguments `sep`, `path`, `field` and `force` for `devEval()`
   and the various `toNNN()` functions now utilizes `getDevOption()`,
   which is still backward compatibility with the old style R options.
 
 * Now `devIsInteractive()` without arguments returns all known
   interactive devices.

 * ROBUSTNESS: Now package does a better job of checking whether a
   particular device is supported on the current system,
   cf. `capabilities()` and `Cairo::Cairo.capabilities()`.

## Deprecated and Defunct

 * Cleanup: Dropped argument `field` for `toNNN()`, because the
   default is now NULL which corresponds to returning a
   `DevEvalProduct` object. In turn, this object has the pathname as
   it's value, which was the previous default `field` value.  Also,
   `as.character()` on this object returns the (relative) pathname.

 * Cleanup: All old-style R options (e.g. `devEval/args/field`) have
   been deprecated.  They will still work for a while but it is
   recommended to set them as `devOptions("*", field = ...)` instead.
 
 
# Version 2.11.5 [2014-09-30]

## New Features

 * Added `view()` and `!()` to `DevEvalProduct`.
 
## Bug Fixes

 * `devDone()` would close some devices despite them being on
   screen/interactive devices, e.g. an x11 device.
 
 * `devNew(x11)` on Unix/Linux where the default `width` or `height`
   failed to be inferred would throw an error reporting on "cannot
   coerce type 'closure' to vector of type 'character'".
 
 
# Version 2.11.4 [2014-09-16]

## New Features

 * ROBUSTNESS: Now `withPar()` also resets all the graphical
   parameters available upon entry even if no explicit ones were
   specified. This covers the case when `expr` changes the parameters,
   e.g. `withPar({ par(cex = 2L); plot(1:10) })`.
 
## Bug Fixes

 * Now `getPathname(..., relative = FALSE)` returns the absolute
   pathname.
 
 * `devOptions()` returned the incorrect options for device types
   `"eps"`, `"jpg2"`, and `"png2"`, if package was not attached.
 
 
# Version 2.11.3 [2014-09-12]

## New Features

 * Added `getDevOption()`.
 
## Bug Fixes

 * On Windows, `devOptions()` assumed that the **grDevices** package
   was attached.
 
 * `devOptions(type, name = NULL)` did not assign the option NULL.
 
 * `devDump()` fell back on option `devDump/args/path`, but that would
   never happen.  Dropping that option.
 
 
# Version 2.11.2 [2014-09-11]

## Bug Fixes

 *` devEval("cairo_pdf", ...)` for generate an image file with a
   \*.cairo_pdf filename extension. Now `devEval(..., ext = NULL)`
   does a better job of inferring the default extension from the
   device type.
 
## Software Quality

 * ROBUSTNESS: Added explicit package tests for `devOptions()`.
 
 
# Version 2.11.1 [2014-09-02]

## New Features

 * Added `getData()` to `DevEvalFileProduct`.
 
 
# Version 2.11.0 [2014-08-29]

## New Features

 * Added support for `devEval()` to try multiple device types
   one-by-one until success, e.g. `devEval("png|jpg|bmp", ...)`.
 
 
# Version 2.10.0 [2014-08-29]

## Significant Changes

 * Changed default argument `field` for `toNNN()` from `"fullname"` to
   `"pathname"` as in `getOption("devEval/args/field",
   "pathname")`. This should work for most compilers including LaTeX,
   although for the latter it is preferred to use `"fullname"`.  See
   the package vignette for details.

## Documentation

 * Update package vignette with information on how to output image
   files of multiple formats in one call.
 
 
# Version 2.9.3 [2014-08-17]

## Code Refactoring

 * Cleanup: Removed false `R CMD check` NOTE.
 
 * Bumped up the package dependencies.
 
 
# Version 2.9.2 [2014-05-15]

## Code Refactoring

 * Bumped up the package dependencies.
 
 
# Version 2.9.1 [2014-05-01]

## New Features

 * Added `withPar()` for plotting with temporarily set graphical
   parameters.
 
 
# Version 2.9.0 [2014-04-28]

## New Features

 * Added `toDefault()` for plotting to the default device analogously
   to how the other `toNNN()` device functions works.  Likewise, added
   `toX11()`, `toWindows()`, `toQuartz()`, `toCairoWin()`,
   `toCairoX11()`, and `toJavaGD()` for plotting to interactive/screen
   devices.
 
 * Now it's possible to use `devEval()` to open a new or activate an
   existing interactive/screen device.
 
 * Added support for (hidden) argument `which` to `devNew()`, such
   that `devNew(type, which = which)` avoids opening a new device iff
   an existing device of the same device type and index/label already
   is opened. For instance, calling `devNew("X11", which = "foo")`
   will open an X11 device and label it `foo`.  Subsequent calls will
   set the focus that same device.

## Bug Fixes

 * Now `devEval("windows", { plot(1:10) })` no longer gives "Error:
   Detected new graphics devices that was opened but not closed while
   executing devEval(): '2' (windows)".
 
## Code Refactoring

 * Bumped up package dependencies.

 
# Version 2.8.4 [2014-01-11]

## New Features

 * Added `asDataURI()` for converting an image file to an
   Base64-encoded data URI character string.
 
 
# Version 2.8.3 [2014-01-10]

## New Features

 * Added `toFavicon()` for outputting figures as HTML favicons.
 
 
# Version 2.8.2 [2014-01-02]

## New Features

 * Now the timestamp of the default path for `devDump()` is in the
   local one.
 
 
# Version 2.8.1 [2013-12-08]

## Bug Fixes

 * `devOptions(types)` would drop all options for combinations of
   device types that have identical sets of options, e.g. `types =
   c("png", "png")` or `types = c("bmp", "png")`.
 
## Code Refactoring

 * Bumped up package dependencies.

 * No longer need for an ad hoc NAMESPACE import.

 
# Version 2.8.0 [2013-10-29]

## New Features

 * Added `devDump()` which is short for calling `devEval(c("png",
   "pdf"), ..., which = devList(interactiveOnly = TRUE))`, i.e. it
   copies the content of open interactive ("screen") devices.
 
 * Added argument `interactiveOnly` to `devList()`.
 
 * If `expr` is missing, `devEval()` copies the current active device
   and `devEval(which = devList())` copies all open devices.  For
   example, `plot(1:10); devEval(c("png", "jpg", "pdf"), name =
   "myfig")`.

## Bug Fixes

 * `devSet(which)` where `which` is a very large number could leave
   lots of stray temporary devices open when error "too many open
   devices" occurred.  Now all temporary devices are guaranteed to be
   closed also when there is an error.
 
 * `devIsOpen()`, `dev(Get|Set)Label(which)` would not handle the case
   when the device was specified by an numeric `which` and there is a
   gap in the device list.

## Code Refactoring

 * Now package imports (no longer suggests) the **base64enc**
   package. This way packages using **R.devices** do not have to
   specify also **base64enc** if they use dataURI-encoding of images.

 
# Version 2.7.3 [2013-10-28]

## New Features

 * ROBUSTNESS: Now `devSet()` guarantees to close all temporary
   devices it opens.
 
 
# Version 2.7.2 [2013-10-15]

## Software Quality

 * ROBUSTNESS: Added package system tests for `devSet()`.

## Code Refactoring

 * Now the package vignettes are in vignettes/ - and not in inst/doc/ which
   will not be supported by R (>= 3.1.0).

 
# Version 2.7.1 [2013-10-07]

## Code Refactoring

 * Cleanup: Now explicitly importing only what is needed in NAMESPACE.
 
 * Bumped up package dependencies.
 
 
# Version 2.7.0 [2013-09-28]

## New Features

 * GENERALIZATION: Vectorized `devEval()`, e.g. it is now possible to
   do `devEval(c("png", "pdf"), name = "MyPlot", { plot(1:10)
   })`. Added arguments `initially` and `finally` to `devEval()`.
   Contrary to `expr` which is evaluated for each graphics
   type/device, these are evaluated only once per call.  This makes it
   possible to avoid repeating expensive computations.
 
 * GENERALIZATION: Vectorized `devIsInteractive()`, `devIsOpen()`,
   `devGetLabel()`, `devOff()`, and `devDone()`.
 
 * Now `devOff()` and `devDone()` checks if device is opened before
   trying to close it.  This avoids opening and closing of non-opened
   devices.
 
 * Updated the formal defaults of several `devEval()` arguments to be
   NULL.  Instead, NULL for such arguments are translated to default
   internally.  This was necessary in order to vectorize `devEval()`.
 
 * CONSISTENCY: Now `devList()` returns an empty integer vector
   (instead of NULL) if no open devices exists.
 
 * ROBUSTNESS: The device functions that are not vectorize do now
   throw an informative error if passed a vector.

 * Now the `R.devices` `Package` object is also available when the
   package is only loaded (but not attached).
 
## Software Quality

 * ROBUSTNESS: Added several more package system tests.

## Code Refactoring

 * ROBUSTNESS: Now declaring all S3 method in NAMESPACE.
 
 * Cleanup: Removed fall back attachments of **R.utils** as these
   are no longer needed with **R.oo** (>= 1.15.1).
 
 
# Version 2.6.1 [2013-09-17]

## New Features

 * ROBUSTNESS: Now `getDataURI()` throws an `Exception` is suggested
   package **base64enc** is not installed.

## Bug Fixes

 * Some package examples and system tests assumed that the suggested
   package **base64enc** is installed.

 * Package vignette assumed that **R.rsp** and **R.utils** are
   attached.

## Software Quality

 * Bumped up package dependencies.

 
# Version 2.6.0 [2013-08-29]

## New Features

 * Added support for retrieving a Base64-encoded data URI string from
   a `DevEvalFile`.
 
 * Added classes `DevEvalProduct` and `DevEvalFileProduct`, which are
   returned by `devEval()`.

## Software Quality

 * TESTS: Added package system tests.
 
 
# Version 2.5.2 [2013-08-27]

## New Features

 * Added `devIsInteractive()`.

## Bug Fixes

 * Now `devEval()` no longer passes a pathname to `devEval()` for
   interactive devices, which in turn would generate warnings.
 
## Code Refactoring

 * Package no longer utilizes `:::`.
 
 
# Version 2.5.1 [2013-08-17]
 
## New Features

 * Argument `ext` of `devEval()` can now be inferred from argument
   `type` also when `type` is passed via a string variable.
 
 
# Version 2.5.0 [2013-07-30]

## New Features

 * Added support the `win.metafile` (WMF) device type and added
   `toWMF()` creating (extended) WMF files.  Since the file format is
   *extended* WMF, which often has file extension *.emf, `toEMF()` was
   also added.  `toEMF()` uses the same device driver as `toWMF()`
   with the only difference that the file extension is *.emf instead
   of *.wmf.
 
 * Now `devOptions()` can query the options of multiple device
   types. Added arguments `options` and `drop` to `devOptions()`.
 
 * Now `devEval()` returns a list of class `DevEvalFile`.

## Documentation

 * Hiding internal/legacy functions from the help index.
 
 
# Version 2.4.2 [2013-07-15]

## New Features

 * Added argument `sep` to `devEval()` together with an option to set
   its default value.
 
 
# Version 2.4.1 [2013-07-12]

## Code Refactoring

 * Updated how vignettes are built and included.
 
 
# Version 2.4.0 [2013-07-03]

## New Features

 * Now `devNew()` returns the index of the opened device.
 
 * Now `devEval()` and `devNew()`, and hence `toPNG()` and so on, can
   be called without attaching the package, e.g. `R.devices::toPNG()`.

## Code Refactoring

 * Cleanup: Now package only imports the **R.utils**.  However, it
   will attach ("load") **R.utils** as soon as `devEval()` or
   `devNew()` is called.
 
 * Bumped up package dependencies.
 
 
# Version 2.3.0 [2013-05-30]

## Code Refactoring

 * Now the package vignette is built via the R (>= 3.0.0) vignette
   engines, if available.
 
 
# Version 2.2.4 [2013-05-20]

## Documentation

 * Now all Rd `\usage{}` lines are at most 90 characters long.
 
 
# Version 2.2.3 [2013-04-04]

## New Features

 * ROBUSTNESS: Now `devEval()` does a better job of making sure to
   close the same device as it opened.  Previously it would close the
   current active device, which would not be the correct one if for
   instance other devices had been open in the meanwhile/in parallel.
 
 
# Version 2.2.2 [2013-04-01]

## Code Refactoring

 * Now package builds with both **R.rsp** (< 0.9.1) and **R.rsp** (>=
   0.9.1).
 
 
# Version 2.2.1 [2013-03-28]

## Code Refactoring

 * Bumped up package dependencies.
 
 * Cleaned up the NAMESPACE file.
 
 
# Version 2.2.0 [2013-03-07]

## Documentation

 * Preparing package vignettes for the upcoming R 3.0.0 support for
   non-Sweave vignettes.

## Code Refactoring

 * Bumped up package dependencies.
 
 
# Version 2.1.6 [2013-02-13]

## New Features

 * Changed default argument `field` for `devEval()` from NULL to
   `getOption("devEval/args/field", NULL)`.
 
 * Changed default argument `field` for `toNNN()` from `"fullname"` to
   `getOption("devEval/args/field", "fullname")`.
 
 
# Version 2.1.5 [2013-02-13]

## Code Refactoring

 * Specifying new DESCRIPTION field `VignetteBuilder`.
 
 
# Version 2.1.4 [2012-12-19]

## Code Refactoring

 * Utilizing new `startupMessage()` of **R.oo**.
 
 
# Version 2.1.3 [2012-11-19]

## Documentation

 * Minor corrections and clarifications in the vignette.

## Code Refactoring

 * CONSISTENCY: Now using `throw()` instead of `stop()` everywhere.
 
 * Only importing what is necessary from **R.methodsS3** and **R.oo**.
 
 * Made all integer constants truly integers.
 
 
# Version 2.1.2 [2012-08-21]

## Documentation

 * Fixed minor typo in the vignette.
 
 * In `help(devEval)` the link to `help(devNew)` was broken.

## Code Refactoring
 
 * Updated versions of the package dependencies.
 
 
# Version 2.1.1 [2012-05-01]

## New Features

 * Now `devOptions()` returns options invisibly if some options were
   set, otherwise not, e.g. `devOptions()` versus `devOptions("png",
   width = 1024)`.

## Documentation

 * Added a first draft of a package vignette.
 
 
# Version 2.1.0 [2012-04-27]

## Code Refactoring

 * Merged updates from the **R.utils** v1.13.1.
 
 
# Version 2.0.0 [2011-11-05]

## Significant Changes

 * Created package by extracting all methods in **R.utils** v1.9.1
   that are related to graphical devices.
 
 * The below change log shows the changes to the device methods while
   they were in **R.utils**.  For this reason, we choose to set the
   version of this package such that it starts where we left
   **R.utils**.
 
 
# Version 1.9.1 [2011-11-05]

## New Features

 * Added `devOptions()`.
 
 * Added default `width` and `height` values to `eps()`.
 
 * Turned `png2()` and `jpeg2()` into plain functions without a
   generic. This is consistent with how `eps()` is defined.
 
 * Now the default `width` is inferred from `devOptions()` if needed.

## Documentation

 * Added an example to `help(devEval)`.
 
 
# Version 1.8.6 [2011-10-31]

## New Features

 * Added argument `field` to `devEval()`.
 
 
# Version 1.8.2 [2011-09-24]

## New Features

 * `devNew()` no longer gives a warning about argument `aspectRatio`
   is specified when both or neither of `width` and `height` are
   given, and `aspectRatio == 1`.
 
 
# Version 1.7.5 [2011-04-12]

## New Features

 * Now `devEval("jpg", ...)` is recognized as `devEval("jpeg", ...)`.
 
 
# Version 1.7.3 [2011-04-02]

## New Features

 * Now argument `force` of `devEval()` defaults to
   `getOption("devEval/args/force", TRUE)`.
 
 
# Version 1.7.2 [2011-03-18]

## New Features

 * Now argument `path` of `devEval()` defaults to
   `getOption("devEval/args/path", "figures/")`.
 
 * Now `devEval()` does a better job of "cleaning up" `name` and
   `tags`.
 
 
# Version 1.7.1 [2011-03-18]

## New Features

 * `devNew()` gained option `devNew/args/par`, which can be used to
   specify the default graphical parameters for `devNew()`.  Any
   additional parameters passed via argument `par` will override such
   default ones, if both specifies the same parameter.
 
 * The automatic archiving of `devEval()` is not considered unless the
   **R.archive** package is loaded, regardless of option settings.

## Documentation

 * The title of `help(devDone)` was incorrect.
 
 
# Version 1.7.0 [2011-03-10]

## New Features

 * Now argument `aspectRatio` of `devNew()` defaults to 1 (not NULL).
 
 * REPRODUCIBLE RESEARCH: Now `devEval()` archives any generated image
   files if **R.archive** option `devEval` is TRUE.
 
 
# Version 1.6.3 [2011-02-20]

## New Features

 * Added argument `par` to `devNew()` for applying graphical
   parameters at the same time as the device is opened, which is
   especially useful when using `devEval()`.
 
 * Changed argument `force` of `devEval()` to default to TRUE.
 
 
# Version 1.6.2 [2011-02-14]

## New Features

 * Added trial version of `devEval()` for simple creation of images.
 
 * Added argument `aspectRatio` to `devNew()`, which updates/sets the
   `height` or the `width`, if the one of the other is not given.
 
 
# Version 1.5.5 [2010-10-26]

## New Features

 * Now argument `which` to `devSet()` can be any object.  If not a
   single numeric or a single character string, then a checksum
   character string is generated using `digest::digest(which)`.
 
 
# Version 1.0.8 [2008-10-16]

## New Features

 * Now `devDone(which = 1)` does nothing.  Before it gave an error.
 
## Bug Fixes

 * Argument `type` of `devNew()` did not take `function`:s.
 
 
# Version 1.0.6 [2008-09-08]

## New Features

 * Now `devNew()` filters out arguments `file` and `filename` if the
   device is interactive.
 
 
# Version 1.0.4 [2008-08-01]

## New Features

 * Added several functions for extending the current functions dealing
   with devices.  All added functions can address a device by a label
   in addition to the standard device index.  The `devGetLabel()` and
   `devSetLabel()` gets and sets the label of a give device.
   `devList()` lists the indices of existing device named by their
   labels, cf. `dev.list()`.  The functions `devSet()` and `devOff()`
   work like `dev.set()` and `dev.off()` but accept labels as well.
   Furthermore, `devSet(idx)` will open a device with index `idx` if
   it does not exists, and `devSet(label)` a device with that label if
   not already opened.  The `devIsOpen()` checks if a device is open
   or not. The `devDone()` function calls `devOff()` except for screen
   devices.
 
 
# Version 1.0.0 [2008-02-26]

## Bug Fixes

 * The default filename for `eps()` had extension \*.ps not \*.eps.
 
 
# Version 0.7.6 [2006-02-15]

## New Features

 * Since the `png2()` and `jpeg2()` devices are in this package, the
   `eps()` device from **R.graphics** has been moved here for
   consistency.
 
 
# Version 0.6.0 [2005-09-24]

## New Features

 * Added trial versions of `jpeg2()` and `png2()`.
