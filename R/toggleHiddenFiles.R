#' Toggle visibility of hidden files in RStudio
#'
#' @export
toggleHiddenFiles <- function() {
  # .rs.* functions live in the "tools:rstudio" environment; fetching them
  # dynamically avoids R CMD check notes about undefined globals
  rs <- as.environment("tools:rstudio")
  get_pref <- get(".rs.getUserPref", envir = rs, inherits = FALSE)
  set_pref <- get(".rs.setUserPref", envir = rs, inherits = FALSE)

  new_value <- !get_pref("show_hidden_files")
  set_pref("show_hidden_files", new_value)
  invisible(new_value)
}
