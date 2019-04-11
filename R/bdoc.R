#' @title Create documentation for a function
#' @description Create Roxygen documentation skeleton for a function
#' @return charstring, also printed via \code{\link{message}}
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Apr 2019
#' @seealso \code{\link{selectObject}}
#' @export
#'
bdoc <- function()
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
#
# Argument section with DEFAULTs
arg <- strsplit(so_text, "function(", fixed=TRUE)[[1]][2]
arg <- sub(")$", "", arg)
arg <- unlist(strsplit(arg, ","))
arg <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", arg, perl=TRUE)
arg <- regmatches(arg, regexpr("=", arg), invert=TRUE) # strsplit for first occurrence of =
arg <- sapply(arg, "[", 1:2)
arg[2,is.na(arg[2,])] <- ""
arg[2, arg[2,]!=""] <- paste("DEFAULT:", arg[2,arg[2,]!=""])
if(arg[1,ncol(arg)]=="...") arg[2,ncol(arg)] <- "Further arguments passed to \\code{\\link{plot}}"
arg <- sub("...", "\\dots", arg, fixed=TRUE)
nc <- max(c(nchar(arg[1,]),8)) + 1
arg[1,] <- sprintf(paste0("%-",nc,"s"), arg[1,]) # pad spaces
arg <- paste0("' @param ", arg[1,], arg[2,])
arg <- paste(arg, collapse="\n")
#
# Date
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
date <- paste0(format(Sys.Date(), "%b %Y"), "\n")
Sys.setlocale("LC_TIME", lct)
#
# Write function structure
out <- paste0(
"' @title title
' @description description
' @details detailsMayBeRemoved
' @aliases aliasMayBeRemoved
' @section Warning: warningMayBeRemoved
' @return ReturnValue
' @author Berry Boessenkool, \\email{berry-b@@gmx.de}, ", date,
"' @seealso \\code{\\link{help}}, \\code{graphics::\\link[graphics]{plot}}
' @keywords aplot
 @importFrom package fun1 fun2
' @export
' @examples
'
", arg, "
'")

message(out)
return(invisible(out))
}
