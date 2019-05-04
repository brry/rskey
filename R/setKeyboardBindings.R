#' @title Set Rstudio keyboard bindings
#' @description Set Rstudio keyboard bindings as mapped 
#'              on \url{https://github.com/brry/rskey#rskey}.
#'              \bold{By default, this overwrites existing F3:F12 mappings!}
#' @return Returns nothing
#' @author Berry Boessenkool, \email{berry-b@@gmx.de}, Jan 2019
#' @seealso \code{\link{addins}}
#' @importFrom berryFunctions l2df removeSpace
#' @importFrom utils read.table
#' @export
#' @param overwrite       Logical. Should existing mappings on F3, F4, ..., F12
#'                        be overwritten? Still informs if this occurs. DEFAULT: TRUE
#' @param removeLastYank  Logical. Should the annoying Rstudio default to override
#'                        "Redo" (CTRL+Y) with some weird yank be removed? 
#'                        DEFAULT: TRUE (Ctrl+Y becomes "Redo" again)
#' @param workdir2filedir Logical. Set CTRL+H for setWorkingDirToActiveDoc?
#'                        DEFAULT: TRUE
#'

setKeyboardBindings <- function(
  overwrite=TRUE, 
  removeLastYank=TRUE,
  workdir2filedir=TRUE
  )
{
# Demand permission:
OK <- readline("Is it OK to create / change the 3 files at '~/.R/rstudio/keybindings'? y/n: ")
if(tolower(substr(OK,1,1)) != "y") stop("Not setting keyboard bindings ",
                                        "because you declined.")
# read current keybinding files:
file_ai <- "~/.R/rstudio/keybindings/addins.json"
file_ed <- "~/.R/rstudio/keybindings/editor_bindings.json"
file_rs <- "~/.R/rstudio/keybindings/rstudio_bindings.json"
if(!dir.exists("~/.R/rstudio/keybindings")) 
    dir.create("~/.R/rstudio/keybindings", recursive=TRUE)
if(!file.exists(file_ai)) cat("{\n}", file=file_ai)
if(!file.exists(file_ed)) cat("{\n}", file=file_ed)
if(!file.exists(file_rs)) cat("{\n}", file=file_rs)
key_ai <- readLines(file_ai, warn=FALSE)
key_ed <- readLines(file_ed, warn=FALSE)
key_rs <- readLines(file_rs, warn=FALSE)


# get currently set keyboard shortcuts:
getsetkeys <- function(x)
  {
  source <- deparse(substitute(x))
  if(length(x)<3) return(data.frame(fun=NULL))
  x <- x[-c(1,length(x))]
  x <- gsub("\"", "", x)
  x <- gsub(",$", "", x)
  x <- berryFunctions::l2df(strsplit(x, " :"))
  colnames(x) <- c("fun","key")
  x$fun <- berryFunctions::removeSpace(x$fun)
  x$key <- berryFunctions::removeSpace(x$key)
  x$source <- source
  checkfor <- paste0("F", 3:12)
  if(workdir2filedir[[1]]) checkfor <- c(checkfor, "Ctrl+H")  
  x$exists <- x$key %in% checkfor
  x$remove <- x$exists & overwrite[[1]]
  x$replace <- substr(x$fun, 1,7) != "rskey::" & x$remove
  x
}
setkeys <- rbind( getsetkeys(key_ai), getsetkeys(key_ed), getsetkeys(key_rs)  )

# Don't warn about Ctrl+H if that's already set to setWorkingDirToActiveDoc:
if(workdir2filedir) if(nrow(setkeys)>0)
  setkeys[setkeys$fun=="setWorkingDirToActiveDoc" & setkeys$key =="Ctrl+H", 
          c("remove","replace")] <- c(TRUE,FALSE)


if(nrow(setkeys)>0) if(any(setkeys$remove))
{
# Warn about overwritten entries:
if(any(setkeys$replace)) message("Overwriting the following existing keyboard bindings:\n",
           paste(paste0(setkeys$key, " - ", setkeys$fun)[setkeys$replace], collapse="\n"))
# Warn about non-overwritten entries:
not_ov <- setkeys$exists & !setkeys$remove
if(any(not_ov)) message("The following keyboard bindings already existed and are not overwritten:\n",
                         paste(paste0(setkeys$key, " - ", setkeys$fun)[not_ov], collapse="\n"))
# remove entries to be overwritten (elsewhere):
setkeys$remove[substr(setkeys$fun, 1,7) == "rskey::" & is.na(setkeys$key)] <- TRUE
rm_ai <- setkeys[setkeys$source=="key_ai",]$remove
rm_ed <- setkeys[setkeys$source=="key_ed",]$remove
rm_rs <- setkeys[setkeys$source=="key_rs",]$remove
if(any(rm_ai)) key_ai <- key_ai[- (which(rm_ai)+1)]
if(any(rm_ed)) key_ed <- key_ed[- (which(rm_ed)+1)]
if(any(rm_rs)) key_rs <- key_rs[- (which(rm_rs)+1)]
}


# Add new entries:

new <- read.table(as.is=TRUE, header=TRUE, sep="|",  strip.white=TRUE, text="fun | key
rskey::str_addin       | F3
rskey::head_addin      | F4
rskey::tail_addin      | F5
rskey::View_addin      | F6
rskey::funSource_addin | F7
rskey::summary_addin   | F8
rskey::dim_addin       | F9
rskey::class_addin     | F10
rskey::plot_addin      | F11
rskey::hist_addin      | F12")
if(nrow(setkeys)>0) new <- new[!new$key %in% setkeys[!setkeys$remove,"key"]   , ]

if(nrow(new)>0)
{
 to_add <- paste0("    \"",new$fun,"\" : \"",new$key,"\"")
 to_add <- paste(to_add, collapse=",\n")
 if(length(key_ai)>2) to_add <- paste0(to_add,",")
 key_ai <- c(key_ai[1], to_add, key_ai[-1])
} 


if(workdir2filedir)
  {
  to_add <- "    \"setWorkingDirToActiveDoc\" : \"Ctrl+H\""
  if(length(key_rs)>2) to_add <- paste0(to_add,",")
  key_rs <- c(key_rs[1], to_add, key_rs[-1])
  } 


if(removeLastYank) if(!any(grepl("pasteLastYank", key_rs)))
  {
  to_add <- "    \"pasteLastYank\" : \"\""
  if(length(key_rs)>2) to_add <- paste0(to_add,",")
  key_rs <- c(key_rs[1], to_add, key_rs[-1])
  } 


# Write new contents to the files:
writeLines(key_ai, file_ai)
writeLines(key_ed, file_ed)
writeLines(key_rs, file_rs)

message("The keyboard shortcuts were successfully set.\n",
        "Please restart Rstudio now for the changes to take effect.")

}
