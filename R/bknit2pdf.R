#' @title pass Rnw document to knit2pdf
#' @description pass the filename (selected window) to \code{knitr::knit2pdf}.
#' Developed when MikTex and Rstudio stopped talking to each other. 
#' Can be schorcut to e.g. CTRL + SHIFT + K
#' @return invisible charstring with file name
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jul 2021
#' @importFrom rstudioapi documentSave getSourceEditorContext
#' @importFrom knitr knit
#' @importFrom tools texi2pdf file_path_sans_ext
#' @importFrom berryFunctions openFile
#' @export
#' @param open  Open pdf file?
#' @param clean Clean up temporary files? DEFAULT: TRUE (unlike in tools::texi2pdf)
#' @param \dots Further arguments passed to \code{knitr::\link{knit2pdf}}
#'
bknit2pdf <- function(open=TRUE, clean=TRUE, ...)
{
# save changes:
rstudioapi::documentSave()
 
# extract file name of selected window tab:
rnwfile <- try(rstudioapi::getSourceEditorContext(), silent=TRUE)
if(inherits(rnwfile, "try-error")) stop("rstudioapi::getSourceEditorContext failed:\n", rnwfile , call.=FALSE) 
rnwfile <- rnwfile$path
# check if Rnw file:
if(!grepl("\\.Rnw$", rnwfile, ignore.case=TRUE)) stop("Not a .Rnw file, hence aborted: ", rnwfile)

# Convert to pdf
message("Running knitr::knit2pdf on ",rnwfile, " starting ", as.character(Sys.time()), "...")
pdffile <- try(knitr::knit2pdf(rnwfile, output=sub("\\.Rnw$", ".tex", rnwfile), clean=FALSE, ...), silent=TRUE)
if(inherits(pdffile, "try-error")) stop("knitr::knit2pdf failed for ", rnwfile, " with: ", pdffile)

# Tex log warnings, if any:
if(requireNamespace("knitPres", quietly=TRUE)){
logwarnings <- knitPres::get_texlog_warnings(sub("\\.Rnw$", ".log", rnwfile))
if(!is.null(logwarnings))
message(paste0("Tex log messages:\n---\n",
               paste(logwarnings, collapse="\n---\n"), "\n---")   )
}

# manual cleanup
ext2r <- c(".aux", "-concordance.tex", ".nav", ".out", ".snm", ".synctex.gz", ".toc", ".vrb")
f2r <- paste0(tools::file_path_sans_ext(rnwfile), ext2r)
if(clean) unlink(f2r)

# open pdf + output
if(open) message("Done :)\nOpening ",pdffile)
if(open) berryFunctions::openFile(pdffile)
return(invisible(rnwfile))
}
