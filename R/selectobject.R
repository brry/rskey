#' @title Select object
#' @description Rstudio addin to create object from highlighted object name or code.
#' Also works in browser mode, albeit not in the code_browser window.
#' @return List with the (evaluated) object and the code generating it as a character string
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, May 2017
#' @export
#' @importFrom rstudioapi getActiveDocumentContext
#' @importFrom utils tail head
#' @references Heavily borrowed from \url{https://github.com/digital-dharma/RStudioAddIns}
#' @seealso \code{\link{addins}, \link{funSource}}
#' @examples
#' # see str_addin
#' 
#' @param eval Should text be evaluated? 
#'             If FALSE, the output is a charstring of the marked text.
#'             DEFAULT: TRUE
selectobject <- function(eval=TRUE) {
  # Extract highlighted text from Active Document
  so_context <- try(rstudioapi::getActiveDocumentContext(), silent=TRUE)
  if(inherits(so_context, "try-error")) stop("rstudioapi::getActiveDocumentContext failed.\n",
  "This can happen if you clicked in a code_browser instead of a script window.", call.=FALSE)
  so_text <- so_context$selection[[1]]$text

  # Error Checking to Ensure Text is Selected
  if(nchar(so_text) == 0) stop("Nothing is highlighted in the RStudio Source Editor. ",
                            "Please ensure an object (or some code) is highlighted.",
                            call.=FALSE)
  if(!eval) return(so_text)
  
  # Execute code to account for cases where highlighed text is not an object, but code that generates one
  object <- try(eval.parent(parse(text=so_text), n=2), silent=TRUE)

  if(inherits(object, "try-error"))
  {
  frames <- sys.frames()
  frames <- head(frames, -3) # remove last 3 levels from this function
  frames <- try(tail(frames,1)[[1]], silent=TRUE)
  # if not in browser mode, but object simply doesn't exist:
  if(inherits(frames,"try-error")) frames <- parent.frame()
  # try again
  object <- try(eval(parse(text=so_text), envir=frames), silent=TRUE)
  }

  if(inherits(object, "try-error"))
     stop("Code evaluation failed: ",attr(object, "condition")$message, call.=FALSE)

  # selected code (short version for printing)
  textshort <- so_text
  w <- options("width")$width
  if(nchar(textshort) > w-6 ) textshort <- paste0(substr(textshort,1,w-11), "[...]")
  if(substring(textshort, nchar(textshort)) == "\n")
    textshort <- substr(textshort, 1, nchar(textshort)-1)

  # return object
  return(invisible(list(object=object, code=textshort, fullcode=so_text)))

}
