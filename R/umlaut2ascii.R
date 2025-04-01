#' @title Umlaut to ASCII
#' @description Convert Umlaute in Script to ASCII. Less aggressive than 
#' <https://github.com/dreamRs/prefixer/#not-ascii>
#' @return path, invisibly
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Feb 2022
#' @keywords file
#' @seealso \code{berryFunctions\link[berryFunctions]{convertUmlaut}()}
#' @export
#'
umlaut2ascii <- function()
{
doc <- rstudioapi::getSourceEditorContext()
x <- readLines(con=doc$path, encoding="UTF-8")
#x <- doc$contents # improper string escaping
n <- length(x)
if(x[n]=="") x <- x[-n] # remove last line if empy
#x <- stringi::stri_escape_unicode(x) # way too aggressive
x <- gsub("\u00E4", "\\u00E4",x, fixed=TRUE) # ae
x <- gsub("\u00F6", "\\u00F6",x, fixed=TRUE) # oe
x <- gsub("\u00FC", "\\u00FC",x, fixed=TRUE) # ue
x <- gsub("\u00DF", "\\u00DF",x, fixed=TRUE) # ss
x <- gsub("\u00C4", "\\u00C4",x, fixed=TRUE) # Ae
x <- gsub("\u00D6", "\\u00D6",x, fixed=TRUE) # Oe
x <- gsub("\u00DC", "\\u00DC",x, fixed=TRUE) # Ue
writeLines(text=x, con=doc$path)
return(invisible(doc$path))
}
