#' @export
#' @importFrom waiter autoWaiter useWaiter waiterPreloader spin_dots
#' @importFrom here here
#' @importFrom shinyjs useShinyjs hidden hide show enable disable
#' @importFrom bslib bs_theme font_google
#' @importFrom readr read_csv
#' @importFrom tokenizers tokenize_sentences
#' @importFrom shinyWidgets checkboxGroupButtons radioGroupButtons
#' @importFrom openxlsx write.xlsx
#' @import tidyr 
#' @import ggplot2
#' @import stringr
#' @import dplyr
#' @import shinipsum
#' @import googlesheets4
#' @import shiny
run_mainConcept <- function() {
  appDir <- system.file("app", package = "mainconcept")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
