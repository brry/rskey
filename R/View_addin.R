#' @title Rstudio View on F6
#' @description Rstudio addin to \code{\link{View}} a highlighted object.
#' Instead of an object name, code creating data can be highlighted as well.
#' It can be very useful to bind this addin to F6, for example.
#' @return Invisible Null, opens window as per \code{\link{View}}.
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom utils View
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#' @seealso \code{\link{selectobject}}, \code{\link{str_addin}}, \code{\link{head_addin}}
#' @examples
#' # Go to Addins - browse Addins - Keyboard shortcuts - map "View an object" to F6
#'
#' @param obj Some R object. DEFAULT: Rstudio addin selected code
#'
#'
View_addin <- function(obj=selectobject()) {
  # open View window of object
  if(!is.data.frame(obj)) try( obj <- as.data.frame(obj)  )
  View(obj)
}
