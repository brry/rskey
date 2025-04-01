#' @title run python exercise development test
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jan 2023
#' @seealso \code{\link{selectobject}}
#' @export
#'
pycheck <- function() 
{
 if(!requireNamespace("codeoceanR", quietly=TRUE))
  {
  warning("R package codeoceanR must be available for this function.",
          "\nSee   https://github.com/openHPI/codeoceanR#setup-once-only")
  return()
  }
 codeoceanR:::py_local_score()
}
