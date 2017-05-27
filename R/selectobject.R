#' @title Select object
#' @description Rstudio addin to create object from highlighted object name or code
#' @return List with the (evaluated) object and the code generating it as a character string
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom rstudioapi insertText
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#' @seealso \code{\link{addins}, \link{funSource}}
#' @examples
#' # see str_addin
#'
#'
selectobject <- function() {
  # Extract highlighted text from Active Document
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text

  # Error Checking to Ensure Text is Selected
  if(nchar(text) == 0) stop("Nothing is highlighted in the RStudio Source Editor. ",
                            "Please ensure an object is highlighted.", call.=FALSE)

  # Execute code to account for cases where highlighed text is not an object, but code that generates one
  object <- eval(parse(text=text))

  # selected code (short version for printing)
  textshort <- text
  w <- options("width")$width
  if(nchar(textshort) > w-6 ) textshort <- paste0(substr(textshort,1,w-11), "[...]")
  if(substring(textshort, nchar(textshort)) == "\n")
    textshort <- substr(textshort, 1, nchar(textshort)-1)

  # return object
  return(invisible(list(object=object, code=textshort, fullcode=text)))

}
