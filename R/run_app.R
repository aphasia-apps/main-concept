#' @export
runMCA <- function() {
  appDir <- system.file("shiny-apps", "mca", package = "mainconcept")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}