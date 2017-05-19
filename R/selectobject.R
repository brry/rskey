#' @title Select object
#' @description Rstudio addin to create object from highlighted object name orcode
#' @return The object
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom rstudioapi insertText
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#' @seealso str_addin
#' @examples
#' # see str_addin
#'
#'
selectobject <- function() {
  # Extract highlighted text from Active Document
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text

  # Error Checking to Ensure Text is Selected
  if(nchar(text) == 0) stop("Nothing is highlighted in the RStudio Source Editor.",
                            "Please ensure an object is highlighted.", call.=FALSE)

  # Execute code to account for cases where highlighed text is not an object, but code that generates one
  object <- eval(parse(text=text))

  # return object
  return(object)

}
