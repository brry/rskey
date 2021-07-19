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
#' @param \dots Further arguments passed to \code{knitr::\link{knit}}
#'
bknit2pdf <- function(open=FALSE, clean=TRUE, ...)
{
# save changes:
rstudioapi::documentSave()
 
# extract file name of selected window tab:
rnwfile <- try(rstudioapi::getSourceEditorContext(), silent=TRUE)
if(inherits(rnwfile, "try-error")) 
  stop("rstudioapi::getSourceEditorContext failed:\n", rnwfile , call.=FALSE) 
rnwfile <- rnwfile$path

# Test if github package is installed: 
if(!requireNamespace("knitPres", quietly=TRUE))
  {
  warning("R package knitPres must be available for this function.",
          "\nSee   https://github.com/brry/knitPres#knitpres")
  return()
  }

knitPres::rnw2pdf(rnwfile, open=open, clean=clean, ...)
return(invisible())
}
