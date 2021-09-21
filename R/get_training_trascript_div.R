




#' get training transcript
#' 
#' transcription page for training
#'
#' @param module_num which module is running
#'
#' @export
get_training_trascript_div <- function(module_num) {
  # pulls the current markdown file the the transcripts
  get_ortho = paste0("app/www/", "module", module_num, ".md")
  get_answer = paste0("app/www/", "answer_module", module_num, ".md")
  
  return(
    div(fluidRow(column(
    width = 10,
    offset = 1,
    # this is the box holding the orthographic transcript
    div(id = "transcript_box",
        includeMarkdown(
          system.file(get_ortho, package = "mainConcept")
        ))
  )),
  fluidRow(
    column(
      width = 5,
      offset = 1,
      # transcription instructions
      tabsetPanel(
        id = "instructions2",
        tabPanel(
          "Transcribing",
          value = "tr2",
          div(style = "height:400px; overflow:auto;margin:1%;",
              includeMarkdown(
                system.file("app/www/transcribing.md", package = "mainConcept")
              ))
        ),
        # segementing instructions
        tabPanel(
          "Segmenting",
          value = "seg2",
          div(style = "height:400px; overflow:auto;margin:1%;",
              includeMarkdown(
                system.file("app/www/segmenting.md", package = "mainConcept")
              ))
        )
        #)
        #)
      )
    ),
    column(
      width = 5,
      # enter transcript here
      textAreaInput(
        "input_transcript_training",
        "Enter transcript (separate utterances with a period)",
        height = "120px",
        width = "100%",
        value = ""
      ),
      br(),
      # hidden: the correct transcript. an action button in footer shows it. 
      shinyjs::hidden(div(
        id = "correct_transcript",
        div(id = "transcript_box",
            includeMarkdown(
              system.file(get_answer, package = "mainConcept")
            ))
      ))
    )
  )))
}
