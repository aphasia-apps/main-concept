
#' Run Main Concept App
#' @description Function to locally run the main concept app
#' @export
#' @import shiny 
#' @examples
#' \dontrun{
#' runMCA()
#' }
runMCA <- function(...) {
  ui <- app_ui
  server <- app_server
  shinyApp(ui, server, ...)
}
