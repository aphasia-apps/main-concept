
#' Returns the page title for the navbar
#' 
#' Reveals keys for testing inputs during tests (not permitted by keys).
#' Code for download buttons, start-over, help, and github link
#'
#' @export
pagetitle <- function(){
  
     title = div(
       downloadButton("report", "Download Report"),
       downloadButton("downloadData", "Download Data"),
       shinyjs::hidden(actionButton("start_over","Start Over")),
       actionButton(
         inputId = "info",
         label = "Scoring Manual",
         icon = icon("book"),
         onclick = "window.open('https://drive.google.com/drive/folders/1bxazjgQWx-WD8ELTJjwBm_5IToRpgQhQ', '_blank')",
       ),
# 
#        actionButton(
#          inputId = "about",
#          label = "About",
#        ),
       # actionButton(
       #   inputId = "feedback",
       #   label = "Give feedback",
       # )
     )

  return(title)
}