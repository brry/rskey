### rskey

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version-last-release/rskey)](https://cran.r-project.org/package=rskey) 
[![downloads](http://cranlogs.r-pkg.org/badges/rskey)](https://www.r-pkg.org/services)
[![Rdoc](http://www.rdocumentation.org/badges/version/rskey)](https://www.rdocumentation.org/packages/rskey)
!["rskey dependencies"](https://tinyverse.netlify.com/badge/rskey)

### rstudio addins for Keyboard shortcuts

Rstudio addins to examine selected code in the Rstudio editor.  
*Berry Boessenkool (<berry-b@gmx.de>), May 2017, with `selectobject` code idea from
digital-dharma/RStudioAddIns).*

I find it very useful to bind the addins to keyboard shortcuts like this (and
[label](https://github.com/brry/rstudioberry/raw/master/inst/keyboardRlabels.ods)
the keyboard):

* F3 - structure of an object - `str(selected_code)`
* F4 - head of an object - `head(selected_code)`
* F5 - tail of an object - `tail(selected_code)`
* F6 - View an object - `View(selected_code)`
* F7 - funSource of an object - `funSource(selected_code)`
* F8 - summary of an object - `summary(selected_code)`
* F9 - dim of an object - `dim(selected_code)`
* F10 - class of an object - `class(selected_code)`
* F11 - plot an object - `plot(selected_code, las=1)`
* F12 - histogram of an object - `hist(selected_code, col="moccasin", breaks=50, las=1)`

To use such keyboard shortcuts, follow these instructions:

```R
if(!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("brry/rskey")

# either set all bindings:
rskey::setKeyboardBindings(overwrite=TRUE)
# by default also sets CTRL+Y for ReDo and CTRL+H for setWorkingDirToActiveDoc

# or manually:
# Rstudio - Tools - Modify Keyboard Shortcurts
# click on an addin shortcut field and press the desired key combination
# (Restart Rstudio)
```


### funSource
`funSource` provides an easy option to open the source code of a function in a browser window.  
Through github, there are nice syntax highlighting and search options.

#### find package
`funSource(someFunction)` tries to find the corresponding package to the input function.  
You can also explicitly request `funSource("somePackage::someFunction")`.  
This works even if the package is not installed (in which case you do need the quotation marks).

#### open urls
In the default browser, it the opens the first link if it exists, the second if not:  

* github.com/cran/`somePackage`/blob/master/R/`someFunction`.R (or `.r` file)
* github.com/search?q=`someFunction` function repo:cran/`somePackage`+path:R

The second link is a github search query needed when a function is defined in a file with a different name.  
Functions in the base R packages will be searched in the 
[wch/r-source/src/library](https://github.com/wch/r-source/tree/trunk/src/library) repo.  

#### limits
Currently, the `funSource`-initiated github search doesn't find `names` or `dimnames` in base R.
Any idea to solve this kind of limitation is welcome!

#### origin
`funSource` is imported from
[berryFunctions](https://github.com/brry/berryFunctions/blob/master/R/funSource.R).

#### examples
Examples on links opened by `funSource`:

Functions in CRAN packages - `spatstat::rescale`:  
<https://github.com/cran/spatstat/blob/master/R/rescale.R>  
[https://github.com/search?q=rescale function repo:cran/spatstat+path:R](https://github.com/search?q=rescale%20function%20repo:cran/spatstat+path:R)

Functions in base packages - `graphics::hist`:  
<https://github.com/wch/r-source/tree/trunk/src/library/graphics/R/hist.R>  
[https://github.com/search?q=hist function repo:wch/r-source+path:src/library/graphics/R](https://github.com/search?q=hist%20function%20repo:wch/r-source+path:src/library/graphics/R)
