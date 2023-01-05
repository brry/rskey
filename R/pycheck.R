#' @title run python exercise development test
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jan 2023
#' @seealso \code{\link{selectobject}}
#' @importFrom rstudioapi getActiveDocumentContext
#' @importFrom berryFunctions checkFile
#' @export
#'
pycheck <- function()
{
rstudioapi::documentSave()
p <- rstudioapi::documentPath()
p <- substr(basename(p),1,3)
p <- paste0(p,"testrun.py")
berryFunctions::checkFile(p)
message("running python ", p)
system2("python", p)
}
