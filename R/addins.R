#' @title Rstudio keyboard shortcuts on F-keys
#' @description Rstudio addins to examine highlighted code / object.
#' It can be very useful to bind these addins as outlined in \url{https://github.com/brry/rstudioberry#rstudio-addins-for-keyboard-shortcuts}
#' @return Output of the respective functions
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @name addins
#' @importFrom utils str head View
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#'             To be added to \url{https://github.com/daattali/addinslist#readme}
#' @seealso \code{\link{selectobject}, \link{funSource}}
#' @examples
#' # Go to Addins - browse Addins - Keyboard shortcuts - map commands as desired
#'
#' @param obj List containing \code{object} (some R object) \code{fullcode}
#'            (code, objectname, expression) and \code{code} (potentially truncated version).
#'            DEFAULT: Rstudio addin selected code from \code{\link{selectobject}}
#'
str_addin <- function(obj=selectobject()) {
  message("str(", obj$code, ")")
  str(obj$object)
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
View_addin <- function(obj=selectobject()) {
  message("View(", obj$code, ")")
  obj <- obj$object
  if(!is.data.frame(obj)) try( obj <- as.data.frame(obj)  )
  View(obj)
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
  dim(obj$object)
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
  message("plot(", obj$code, ")")
  plot(obj$object)
  }
