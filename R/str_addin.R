#' @title Rstudio str on F3
#' @description Rstudio addin to show the \code{\link{str}}ucture of a highlighted object.
#' Instead of an object name, code creating data can be highlighted as well.
#' It can be very useful to bind this addin to F3, for example.
#' @return Nothing, prints as per \code{\link{str}}.
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom rstudioapi insertText
#' @importFrom utils str
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#'             To be added to \url{https://github.com/daattali/addinslist#readme}
#' @examples
#' # Go to Addins - browse Addins - Keyboard shortcuts - map "structure of an object" to F3
#'
#'
str_addin <- function() {
  # Extract highlighted text from Active Document
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text

  # Error Checking to Ensure Text is Selected
  if(nchar(text) == 0) stop("Nothing is highlighted in the RStudio Source Editor.",
                            "Please ensure an object is highlighted.", call.=FALSE)

  # Execute code to account for cases where highlighed text is not an object, but code that generates one
  object <- eval(parse(text=text))

  # return structure of object
  str(object)

}
