#' @title score exercises in the course Fundamentals of Programming
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jan 2023 / Mar 2026
#' @seealso \code{\link{selectobject}}
#' @export
#'
score <- function() 
{
 if(!requireNamespace("codeoceanR", quietly=TRUE))
  {
  warning("R package codeoceanR must be available for this function.",
          "\nSee   https://github.com/openHPI/codeoceanR#setup-once")
  return()
  }
 codeoceanR::rt_score()
}
