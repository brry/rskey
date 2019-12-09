#' @title wrap Rnw source code in "\\rcode{}"
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Nov 2019
#' @seealso \code{\link{selectobject}}
#' @importFrom rstudioapi getActiveDocumentContext insertText
#' @export
#'
rcode <- function()
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

out <- paste0("\\rcode{", so_text, "}")
rstudioapi::insertText(text=out, id=so_context$id)
# message("\\rcode is added to ", so_context$path)
return(invisible(out))
}

