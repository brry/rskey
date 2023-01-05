#' @title pass Rnw document to knit2pdf
#' @description pass the filename (selected window) to \code{knitPres::rnw2pdf}.
#' Developed when MikTex and Rstudio stopped talking to each other. 
#' Can be schorcut to e.g. CTRL + K
#' @return invisible charstring with file name
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jul 2021
#' @importFrom rstudioapi documentSave getSourceEditorContext
#' @export
#' @param open  Open pdf file?
#' @param clean Clean up temporary files? DEFAULT: TRUE (unlike in tools::texi2pdf)
#' @param \dots Further arguments passed to \code{knitr::knit}
#'
bknit2pdf <- function(open=TRUE, clean=TRUE, ...)
{
# save changes:
rstudioapi::documentSave()
# extract file name of currently open, or last focused, RStudio document.
rnwfile <- rstudioapi::documentPath()

# Test if github package is installed: 
if(!requireNamespace("knitPres", quietly=TRUE))
  {
  warning("R package knitPres must be available for this function.",
          "\nSee   https://github.com/brry/knitPres#knitpres")
  return()
  }

rstudioapi::executeCommand("activateConsole") # Focus to Console
knitPres::rnw2pdf(rnwfile, open=open, clean=clean, ...)
return(invisible())
}
