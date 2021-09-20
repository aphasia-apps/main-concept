




#' get training transcript
#'
#' @param module_num 
#'
#' @export
get_training_trascript_div <- function(module_num){
  
  get_ortho = paste0("app/www/","module", module_num, ".md")
  get_answer = paste0("app/www/","answer_module", module_num, ".md")
  
  return(
    div(
        fluidRow(
          column(width = 10, offset = 1,
                 div(id = "transcript_box",
                 includeMarkdown(system.file(get_ortho, package = "mainConcept"))
                 )
          )
        ),
        fluidRow(
          column(width = 5, offset = 1,
                 tabsetPanel(id ="instructions2",
                             tabPanel("Transcribing", value = "tr2",
                                      div(style="height:400px; overflow:auto;margin:1%;",
                                          includeMarkdown(system.file("app/www/transcribing.md", package = "mainConcept"))
                                      )
                             ),
                             tabPanel("Segmenting", value = "seg2",
                                      div(style="height:400px; overflow:auto;margin:1%;",
                                      includeMarkdown(system.file("app/www/segmenting.md", package = "mainConcept"))
                                      )
                             )
                             #)
                             #)
                 )
          ),
          column(width = 5,
                 textAreaInput("input_transcript_training",
                               "Enter transcript (separate utterances with a period)",
                               height = "120px",
                               width = "100%",
                               value = ""
                 ),
                 br(),
                 shinyjs::hidden(
                   div(id = "correct_transcript",
                      div(id = "transcript_box",
                        includeMarkdown(system.file(get_answer, package = "mainConcept"))
                      )
                    )
                 )
          )
        )
    )
    
  )
}

