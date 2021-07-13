get_scoring_div <- function(num){
  
  scoring_div<- fluidRow(
    column(width = 10,offset = 1,
           fluidRow(style = "margin-bottom: 5px;",
             column(width = 12,
                       htmlOutput("scoring_info")
             )
           ),
           fluidRow(style = "max-height: 250px; overflow: auto;",
             column(width = 12, 
                       h5("Select the sentences that match the concept."), 
                       uiOutput("sentence_buttons")
             )
           ),
           fluidRow(
             column(width = 12, 
                       h5("Score each concept noted above."), 
                            uiOutput("score_sentences")
             )
           )
           )
    )
  
}