#' @title Rstudio keyboard shortcuts on F-keys
#' @description Rstudio addins to examine highlighted code / object.
#' It can be very useful to bind these addins as outlined in 
#' \url{https://github.com/brry/rskey#rstudio-addins-for-keyboard-shortcuts}
#' @return Output of the respective functions
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @name addins
#' @importFrom utils str head tail View
#' @importFrom berryFunctions funSource
#' @seealso \code{\link{selectobject}}, 
#'          \code{berryFunctions::\link[berryFunctions]{funSource}},
#'          \url{https://github.com/daattali/addinslist#readme}
#' @examples
#' # Go to Addins - browse Addins - Keyboard shortcuts - map commands as desired
#' # or use    setKeyboardBindings()
#' 
#' # highlight objects or code (examples below), then press keyboard shortcut
#' iris
#' iris$Sepal.Length + 10
#' 
#' @param obj List containing \code{object} (some R object) \code{fullcode}
#'            (code, objectname, expression) and \code{code} 
#'            (potentially truncated version).
#'            For funSource_addin, only the function name should be highlighted.
#'            DEFAULT: Rstudio addin selected code from \code{\link{selectobject}}
#' 
str_addin <- function(obj=selectobject()) {
  message("str(", obj$code, ", max.level=3)")
  str(obj$object, max.level=3)
  }

#' @export
#' @rdname addins
#' 
head_addin <- function(obj=selectobject()) {
  message("head(", obj$code, ")")
  head(obj$object)
  }

#' @export
#' @rdname addins
#' 
tail_addin <- function(obj=selectobject()) {
  message("tail(", obj$code, ")")
  tail(obj$object)
  }

#' @export
#' @rdname addins
#' 
View_addin <- function(obj=selectobject()) {
  message("View(", obj$code, ")")
  obj <- obj$object
  if(!is.data.frame(obj)) try( obj <- as.data.frame(obj)  )
  View(obj)
  }

#' @export
#' @importFrom utils packageVersion
#' @rdname addins
#' 
funSource_addin <- function(obj=selectobject(eval=FALSE)) {
  message("funSource(", obj, ")")
  if(grepl("[^[:alnum:]|^_|^.|^:]", obj) && packageVersion("berryFunctions")<"1.18.3") 
    warning("funSource accepts only a function name as input (without brackets etc).")
  berryFunctions::funSource(obj)
}

#' @export
#' @rdname addins
#' 
summary_addin <- function(obj=selectobject()) {
  message("summary(", obj$code, ")")
  summary(obj$object)
  }

#' @export
#' @rdname addins
#' 
dim_addin <- function(obj=selectobject()) {
  message("dim(", obj$code, ")")
  out <- dim(obj$object)
  if(is.null(out)) return(paste0("dim: NULL, class: ",class(obj$object),
                                 ", length: ", length(obj$object)))
  out
  }

#' @export
#' @rdname addins
#' 
class_addin <- function(obj=selectobject()) {
  message("class(", obj$code, ")")
  class(obj$object)
  }

#' @export
#' @rdname addins
#' @importFrom graphics plot
#' 
plot_addin <- function(obj=selectobject()) {
  message("plot(", obj$code, ", las=1)")
  plot(obj$object, las=1)
  }

#' @export
#' @rdname addins
#' @importFrom graphics hist
#' 
hist_addin <- function(obj=selectobject()) {
  message("hist(", obj$code, ", col='moccasin', breaks=50, las=1)")
  hist(obj$object, col="moccasin", breaks=50, las=1,
       main=paste("Histogram of", obj$code), xlab=obj$code)
  }
