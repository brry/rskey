#' @title Rstudio str on F3
#' @description Rstudio addin to show the \code{\link{str}}ucture of a highlighted object.
#' Instead of an object name, code creating data can be highlighted as well.
#' It can be very useful to bind this addin to F3, for example.
#' @return Nothing, prints as per \code{\link{str}}.
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom utils str
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#'             To be added to \url{https://github.com/daattali/addinslist#readme}
#' @seealso \code{\link{selectobject}}, \code{\link{head_addin}}
#' @examples
#' # Go to Addins - browse Addins - Keyboard shortcuts - map "structure of an object" to F3
#'
#' @param obj Some R object. DEFAULT: Rstudio addin selected code
#'
#'
str_addin <- function(obj=selectobject()) {
  # return structure of object
  str(obj)

}
