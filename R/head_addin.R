#' @title Rstudio head on F4
#' @description Rstudio addin to show the \code{\link{head}} of a highlighted object.
#' Instead of an object name, code creating data can be highlighted as well.
#' It can be very useful to bind this addin to F4, for example.
#' @return Output from \code{\link{head}}.
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom utils head
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#' @seealso \code{\link{selectobject}}, \code{\link{str_addin}}
#' @examples
#' # Go to Addins - browse Addins - Keyboard shortcuts - map "head of an object" to F4
#'
#' @param obj Some R object. DEFAULT: Rstudio addin selected code
#'
#'
head_addin <- function(obj=selectobject()) {
  # return structure of object
  head(obj)

}
