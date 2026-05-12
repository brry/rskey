#' @title Set Rstudio keyboard bindings
#' @description Set Rstudio keyboard bindings as mapped 
#'              on \url{https://github.com/brry/rskey#rskey}.
#' @return Returns nothing
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jan 2019, May 2026
#' @seealso \code{\link{addins}}
#' @importFrom berryFunctions newFilename openFile
#' @export
#' @param openfolder      Logical: Open folders after writing the files?
#'                        Uses \code{berryFunctions\link[berryFunctions]{openFile}()}. DEFAULT: TRUE
#'

setKeyboardBindings <- function(
  openfolder=TRUE
  )
{
# Set paths
p1 <- "~/.config/rstudio/"
if(.Platform$OS.type == "windows") p1 <- paste0(Sys.getenv("APPDATA"), "/RStudio/")
p1 <- paste0(p1, "keybindings/rstudio_bindings.json")

p2 <- "~/.R/rstudio/keybindings/addins.json"

# Ask permission
message("setKeyboardBindings wants to write the files:\n", p1, "\n", p2,
        "\nIf these files exist, they are kept as a copy.")
ok <- readline("Can I write files as in the message? y/n: ")
if(!tolower(substr(ok,1,1))=="y") stop("You did not give write access.")

# Create dir if needed:
d2 <- dirname(p2)
if(!dir.exists(d2)) dir.create(d2, recursive=TRUE)

# backup files if they exist:
replaceFile <- function(fn)
  {
  if(!file.exists(fn)) return(fn)
  newname <- berryFunctions::newFilename(fn, quiet=TRUE)
  file.rename(fn, newname)
  message("Existing file was renamed to ", newname)
  return(fn)
  }
p1 <- replaceFile(p1)
p2 <- replaceFile(p2)

# Set new entries:
cat('{
"pasteLastYank": "",
"setTerminalToCurrentDirectory": "",
"setWorkingDirToActiveDoc": "Ctrl+H",
"knitDocument": "",
"roxygenizePackage": "",
"quartoRenderDocument": "Alt+S"
}', file=p1)
cat('{
"rskey::str_addin": "F3",
"rskey::head_addin": "F4",
"rskey::tail_addin": "F5",
"rskey::View_addin": "F6",
"rskey::funSource_addin": "F7",
"rskey::summary_addin": "F8",
"rskey::dim_addin": "F9",
"rskey::class_addin": "F10",
"rskey::plot_addin": "F11",
"rskey::hist_addin": "F12",
"rskey::rcode": "Ctrl+R",
"rskey::bknit2pdf": "Ctrl+K",
"rskey::score": "Ctrl+Shift+Y"
}', file=p2)

# Wrap up:
if(openfolder) berryFunctions::openFile(dirname(c(p1,p2)))

message("The keyboard shortcuts were successfully set.\n",
        "Please restart Rstudio now for the changes to take effect.")
}
