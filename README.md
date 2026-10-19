### rskey

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version-last-release/rskey)](https://cran.r-project.org/package=rskey) 
[![downloads](http://cranlogs.r-pkg.org/badges/rskey)](https://www.r-pkg.org/services)
[![Rdoc](https://api.rdocumentation.org/badges/version/rskey)](https://www.rdocumentation.org/packages/rskey)

### rstudio addins for Keyboard shortcuts

Rstudio addins to examine selected code in the Rstudio editor.  
*Berry Boessenkool (<berry-b@gmx.de>), 2017-2026*


### Quick setup

```R
install.packages("remotes")
remotes::install_github("brry/rskey")
rskey::setKeyboardBindings()
# moves existing shortcuts to backup file
```

* `F3`: structure of an object - `str(selected_code)`
* `F4`: head of an object - `head(selected_code)`
* `F5`: tail of an object - `tail(selected_code)`
* `F6`: View an object - `View(selected_code)`
* `F7`: funSource of an object - `funSource(selected_code)`
* `F8`: summary of an object - `summary(selected_code)`
* `F9`: dim of an object - `dim(selected_code)`
* `F10`: class of an object - `class(selected_code)`
* `F11`: plot an object - `plot(selected_code, las=1)`
* `F12`: histogram of an object - `hist(selected_code, col="moccasin", breaks=50, las=1)`
* *also sets:*
* `CTRL/CMD` + `Y`: redo (by removing it from paste last yank)
* `CTRL` + `H`: set working dir to active document
* `ALT` + `S`: quarto render document 
* `ALT`+`W`, or `control`+`W`: toggle line wrapping (depending on OS)
* `CTRL/CMD` + `Shift` + `Y`: score for [course](https://github.com/brry/fpsetup#exercises)
* *for my convenience sets:*
* `CTRL/CMD` + `R`: add `\rcode{text}` around text in an Rnw document
* `CTRL/CMD` + `K`: knit Rnw file to pdf rskey::bknit2pdf (**set to knitDocument if wanted**)
* *removes*:
* `CTRL/CMD` + `Shift` + `D`: roxygenizePackage to enable duplicate text/line inside a package
* `CTRL/CMD` + `Shift` + `K`: knitDocument as I prefer `CTRL/CMD` + `K`

selectively (un)set some manually:

- Rstudio - Tools - Modify Keyboard Shortcuts
- click on an addin shortcut field and press the desired key combination

[label](https://github.com/brry/rskey/raw/master/inst/keyboardRlabels.ods) the keyboard if wanted :)

### funSource
`funSource` provides an easy option to open the source code of a function in a browser window.  
Through github, there are nice syntax highlighting and search options.

#### find package
`funSource(someFunction)` tries to find the corresponding package to the input function.  
You can also explicitly request `funSource("somePackage::someFunction")`.  
This works even if the package is not installed (in which case you do need the quotation marks).

#### open urls
In the default browser, it opens the first link if it exists, the second if not:  

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
The `selectobject` code idea is from digital-dharma/RStudioAddIns).

#### examples
Examples on links opened by `funSource`:

Functions in CRAN packages - `ggplot2::aes`:  
<https://github.com/cran/ggplot2/blob/master/R/aes.R>  
[https://github.com/search?q=aes function repo:cran/ggplot2+path:R](https://github.com/search?q=aes%20function%20repo:cran/ggplot2+path:R)

Functions in base packages - `graphics::hist`:  
<https://github.com/wch/r-source/blob/trunk/src/library/graphics/R/hist.R>  
[https://github.com/search?q=hist function repo:wch/r-source+path:src/library/graphics/R](https://github.com/search?q=hist%20function%20repo:wch/r-source+path:src/library/graphics/R)
