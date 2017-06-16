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
                            "Please ensure an object (or some code) is highlighted.",
                            call.=FALSE)

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

if(FALSE){
# Currently, selectObject does not work when in a browser:
dd <- function(k) {h <- k*2; browser(); h-3}
dd(5)
# try marking k and hitting F3
# Error: 'x' should be a list of {range, text} pairs

#tryStack error in NULL: 'x' should be a list of {range, text} pairs
#-- tryStack sys.calls: dd -> rstudioberry:::str_addin -> message ->
# selectobject -> tryStack -> rstudioapi::getActiveDocumentContext ->
# as.document_selection -> stop -> NULL
#Error in obj$code : $ operator is invalid for atomic vectors

# If I go to the source file (instead of Rstudio's code_browser) and press F3 there, I get:
#Browse[1]> rstudioberry:::str_addin()
#Error in eval(expr, envir, enclos) : object 'k' not found

# Using eval.parent instead of eval does not help!
}
