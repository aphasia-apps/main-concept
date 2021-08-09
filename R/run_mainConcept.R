
#' Run Main Concept Function
#' @import tidyr 
#' @import ggplot2
#' @import stringr
#' @import dplyr
#' @import shinipsum
#' @import googlesheets4
#' @import shiny
#' 
#' @description The main function of the package to open the app
#' @return a shiny app!
#' @examples
#' \dontrun{
#' run_mainConcept()
#' }
#' @export
run_mainConcept <- function() {
  appDir <- system.file("app", package = "mainconcept")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
