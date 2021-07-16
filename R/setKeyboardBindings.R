#' @title Set Rstudio keyboard bindings
#' @description Set Rstudio keyboard bindings as mapped 
#'              on \url{https://github.com/brry/rskey#rskey}.
#'              \bold{By default, this overwrites existing F3:F12 mappings!}
#' @return Returns nothing
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jan 2019
#' @seealso \code{\link{addins}}
#' @importFrom berryFunctions l2df removeSpace openFile
#' @importFrom utils read.table read.csv
#' @importFrom stats na.omit
#' @export
#' @param overwrite       Logical. Should existing mappings on F3, F4, ..., F12
#'                        be overwritten? Still informs if this occurs. DEFAULT: TRUE
#' @param removeLastYank  Logical. Should the annoying Rstudio default to override
#'                        "Redo" (CTRL+Y) with some weird yank be removed? 
#'                        DEFAULT: TRUE (CTRL+Y becomes "Redo" again)
#' @param workdir2filedir Logical. Set CTRL+H for setWorkingDirToActiveDoc?
#'                        DEFAULT: TRUE
#' @param roampath        Char. If not NULL, both files are also copied to this path, 
#'                        e.g. C:/Users/berry/AppData/Roaming/RStudio/keybindings.
#'                        Seems to be irrelevant in Rstudio 1.4.
#'                        DEFAULT: RStudio/keybindings folder at \code{\link{Sys.getenv}("APPDATA")}
#' @param openfolder      Logical: Open folder(s) after writing the files?
#'                        Uses \code{berryFunctions\link{openFile}()}. DEFAULT: TRUE
#'

setKeyboardBindings <- function(
  overwrite=TRUE, 
  removeLastYank=TRUE,
  workdir2filedir=TRUE,
  roampath=paste0(Sys.getenv("APPDATA"),"/RStudio/keybindings"),
  openfolder=TRUE
  )
{
# work in roaming path?
dor <- !is.null(roampath)
if(dor & !file.exists(roampath)) 
  {
  message("roampath ('",roampath,"') does not exist. Ignoring it.")
  dor <- F
  }

# Demand permission:
OK <- readline(paste0("Is it OK to create / change the files at '~/.R/rstudio/keybindings'",
                      if(dor) paste0(" and '",roampath,"'")," ? y/n: "))
if(tolower(substr(OK,1,1)) != "y") stop("Not setting keyboard bindings ",
                                        "because you declined permission.")
# Create dir if needed:
if(!dir.exists("~/.R/rstudio/keybindings"))
    dir.create("~/.R/rstudio/keybindings", recursive=TRUE)

# new entries to be set:
# addins.json
new_a <- read.table(as.is=TRUE, header=TRUE, sep="|",  strip.white=TRUE, text="
fun                    | key
rskey::str_addin       | F3
rskey::head_addin      | F4
rskey::tail_addin      | F5
rskey::View_addin      | F6
rskey::funSource_addin | F7
rskey::summary_addin   | F8
rskey::dim_addin       | F9
rskey::class_addin     | F10
rskey::plot_addin      | F11
rskey::hist_addin      | F12
rskey::rcode           | Ctrl+,
rskey::bdoc            | Ctrl+Alt+Y")

# rstudio_bindings.json
new_r <- read.table(as.is=TRUE, header=TRUE, sep="|",  strip.white=TRUE, text="
fun                      | key
setWorkingDirToActiveDoc | Ctrl+H
pasteLastYank            | ")
new_r <- new_r[c(workdir2filedir, removeLastYank),]


setkeys <- function(path, file, new)
  {
  # read current keybindings:
  fn <- paste0(path, "/", file)
  if(!file.exists(fn)) cur <- "" else
  cur <- readLines(fn, warn=FALSE)
  cur <- cur[-c(1,length(cur))] # leading and trailing curly bracket
  cur <- gsub(",$", "", cur)
  cur <- gsub("\"", "", cur)
  # split by a single colon: https://stackoverflow.com/questions/62314152
  cur <- strsplit(cur, "(?<!:):(?!:)", perl=TRUE) # strsplit(cur, "\\b:\\b") would not handle surrounding spaces
  cur <- if(length(cur)>0) berryFunctions::l2df(cur) else read.csv(text="a,b")
  colnames(cur) <- c("fun","key")
  cur$fun <- berryFunctions::removeSpace(cur$fun)
  cur$key <- berryFunctions::removeSpace(cur$key)
  cur <- unique(cur) # ignore duplicates
  # warn about (non) overwritten entries, ignoring unchanged entries:
  exi <- cur$key %in% new$key
  exi <- exi & ! paste(cur$fun,cur$key) %in% paste(new$fun,new$key)
  exi <- exi & cur$key != ""
  warnlist <- paste(paste0(cur$key, " - ", cur$fun)[exi], collapse="\n")
  eximsg <- if(overwrite) "Overwriting the following existing keyboard bindings" else
       "The following keyboard bindings already existed and are not overwritten"
  if(any(exi)) message(eximsg, " in ", fn, ":\n", warnlist)
  # remove entries to (not) be overwritten:
  if(overwrite) cur <- cur[!exi,] else  new <- new[!new$key %in% cur$key[exi], ]
  # format new list:
  final <- rbind(cur, new)
  final <- na.omit(unique(final))
  dfun <- final$fun[duplicated(final$fun)]
  dkey <- final$key[duplicated(final$key)]
  if(length(dfun)>0 | length(dkey)>0) message("Manually remove duplicate entries in ", 
                                       fn, ":\n", toString(c(dfun,dkey)))
  final$fun <- paste0('"', final$fun, '"')
  final$key <- paste0('"', final$key, '"')
  final <- paste0(final$fun, ": ", final$key, collapse=",\n")
  # Write new file:
  cat("{\n", file=fn, append=FALSE)
  cat(final, file=fn, append=TRUE)
  cat("\n}", file=fn, append=TRUE)
  }

# Actually set keys:

setkeys("~/.R/rstudio/keybindings", "rstudio_bindings.json", new_r)
setkeys("~/.R/rstudio/keybindings",           "addins.json", new_a)
if(dor) setkeys(roampath, "rstudio_bindings.json", new_r)
if(dor) setkeys(roampath,           "addins.json", new_a)

if(openfolder)
  {
  berryFunctions::openFile("~/.R/rstudio/keybindings")
  if(dor) berryFunctions::openFile(roampath)
  }
message("The keyboard shortcuts were successfully set.\n",
        "Please restart Rstudio now for the changes to take effect.")
}
