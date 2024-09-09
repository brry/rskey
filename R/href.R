#' @title wrap URL in Rnw source code in "href link text"
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Oct 2021
#' @seealso \code{\link{selectobject}}, \code{\link{rcode}}
#' @importFrom rstudioapi getActiveDocumentContext insertText
#' @export
#'
href <- function()
{
# Extract highlighted text from Active Document
so_context <- try(rstudioapi::getActiveDocumentContext(), silent=TRUE)
if(inherits(so_context, "try-error")) stop("rstudioapi::getActiveDocumentContext failed.\n",
"This can happen if you clicked in a code_browser instead of a script window.", call.=FALSE)
so_text <- so_context$selection[[1]]$text

# Error Checking to Ensure Text is Selected
if(nchar(so_text) == 0) stop("Nothing is highlighted in the RStudio Source Editor. ",
                          "Please ensure a function argument section is highlighted.",
                            call.=FALSE)

out <- paste0("\\href{", so_text, "}{displaytext}")
rstudioapi::insertText(text=out, id=so_context$id)
return(invisible(out))
}

