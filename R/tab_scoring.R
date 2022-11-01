
#' Get scoring Div
#' 
#' This function renders the UI for input$mainpage == "intro" on the navbar. 
#'
#' @param num current item to be shown
#'
#' @export
get_scoring_div <- function(num) {
  scoring_div <- fluidRow(column(
    width = 10,
    offset = 1,
    # first row: shows the concept information
    fluidRow(
      style = "margin-bottom: 5px;",
      column(
        width = 12,
        style = "max-height: 200px; overflow: scroll;",
        htmlOutput("scoring_info")
      )
    ),
    # second row: shows the sentences 
    fluidRow(
      style = "max-height: 250px; overflow: auto;",
      column(
        width = 12,
        style = "min-height: 101%;",
        h5("Select the sentences that match the concept."),
        uiOutput("sentence_buttons")
      )
    ),
    # third row - this shows the referent thing which we're not really
    # using yet. we should probably say why that is there. 
    fluidRow(
      column(width = 6,
             h5("Score each concept noted above.")),
      column(
        width = 6,
        align = "right",
        checkboxInput("referent", "Used prior referent")
      )
    ),
    # fourth row this has the buttons for scoring each element. 
    fluidRow(column(
      align = "center",
      width = 8,
      offset = 2,
      uiOutput("score_sentences")
    ))
  ))
  
}