
#' Get intro div
#' 
#' This function renders the UI for input$mainpage == "intro" on the navbar. 
#'
#' @return
#' @export
get_intro_div <- function() {
  column(
    width = 12,
    tabsetPanel(
      type = "hidden",
      id = "glide",
      # UI for first intro page
      # the "glide" name comes from shinyGlide which I didn't end up using...
      # still, the glide numbers represent the tabpanel selected on the 
      # intro page of the navbar. input$glide == "glide1" for example. 
      tabPanelBody(value = "glide1",
                   column(
                     width = 10,
                     offset = 1,
                     # content for first page
                     div(includeMarkdown(
                       system.file("app/www/intro.md",
                                   package = "mainConcept")
                     )),br(),
                     # buttons to progress
                     div(align = "center",
                         actionButton("glide_next1", "Get Started")),
                     div(style = "margin-top: 30px;",
                         tags$em("Note: This app is currently under development and is not ready for clinical or research use.", style = "color: red;")
                     )
                   )),
      # UI for second intro page
      tabPanelBody(value = "glide2",
                   column(
                     width = 10,
                     offset = 1,
                     # table stuff with styling
                     # div(class = "ox-hugo-table basic-styling",
                     #     includeMarkdown(
                     #       system.file("app/www/scoring.md",
                     #                   package = "mainConcept")
                     #     )),
                     div(
                       includeMarkdown(
                               system.file("app/www/scoring.md",
                                           package = "mainConcept")
                             ),
                       DT::dataTableOutput("scoring_table_output"), br(),
                       tags$p("Get started using the app by selecting 'Training' to begin the training modules or
                              'Start scoring' to begin scoring a transcript.")
                     ),
                     
                     # buttons
                     div(
                       align = "center",
                       actionButton("glide_back1", "Back"),
                       actionButton("glide_training", "Training Modules"),
                       actionButton("glide_next2", "Score Transcript")
                     )
                   )),
      # This page takes patient information. only navigated to if scoring
      # not a part of the training module. 
      # probably some unnecessary html building in here...
      tabPanelBody(value = "glide3",
                   column(
                     width = 10,
                     offset = 1,
                     div(
                       align = "center",
                       div(
                         style = "display: inline-block; text-align: left;",
                         br(),
                         # participant information
                         h5("Enter participant information"),
                         br(),
                         # name
                         textInput("name", "Enter a Name"),
                         # which stimulus you're scoring
                         selectInput(
                           inputId = "input_stimulus",
                           label = "Select stimulus",
                           c(
                             "Broken Window" = 'broken_window',
                             "Cat Rescue" = 'cat_rescue',
                             "Refused Umbrella" = 'refused_umbrella',
                             "Cinderella" = 'cinderella',
                             "Sandwich" = 'sandwich'
                           ),
                           selected = "broken_window"#,
                           #inline = F
                         ),
                         # time taken during the task
                         # if left at zero, essentially ignored. 
                         # this could be a bit confusing...may have to change.
                         numericInput(
                           "input_duration",
                           "Enter Duration (seconds)",
                           value = 0,
                           min = 0,
                           max = 720
                         ),
                         # can enter any notes. these are only in the 
                         # report and downloaded data. 
                         textAreaInput(
                           "notes",
                           "Enter any notes",
                           width = "100%",
                           height = "100px"
                         ),
                         br(),
                         p(
                           tags$em(
                             "Note, for privacy reasons, data is not
                             retained after the page is closed or refreshed."
                           ),
                           style = "max-width:300px;"
                         ),
                         br()
                       )
                     ),
                     # buttons to progress
                     div(
                       align = "center",
                       actionButton("glide_back2", "Back"),
                       actionButton("glide_next3", "Next")
                     )
                   )),
      # last panel within intro. this is for trasncribing and segmenting
      # transcripts. Question of whether we should recommend that 
      # users save their transcript in a text file prior to progressing...
      tabPanelBody(value = "glide4",
                   fluidRow(
                     column(
                       width = 5,
                       offset = 1,
                       # tabset within! wow were 3 levels deep here...
                       # good thing you can't tell. 
                       tabsetPanel(
                         id = "instructions",
                         # this is for transcribing instructions
                         tabPanel(
                           "Transcribing",
                           br(),
                           div(
                             # because they're too much for smaller screens...
                             style = "height:500px; overflow:auto;",
                             # read in the markdown text. 
                               includeMarkdown(
                                 system.file("app/www/transcribing.md",
                                             package = "mainConcept")
                               ))
                         ),
                         # these are segmenting instructions. 
                         tabPanel("Segmenting", br(),
                                  includeMarkdown(
                                    system.file("app/www/segmenting.md",
                                                package = "mainConcept")
                                  ))
                         #)
                         #)
                       )
                     ),
                     column(
                       width = 5,
                       # This is the text box for the participant to
                       # enter their transcript. 
                       # should we validate certain elements of the transcript?
                       # its not really necessary for scoring (at least pragmatically)
                       # but we could check for periods...
                       textAreaInput(
                         "input_transcript",
                         "Enter transcript (separate utterances with a period)",
                         height = "400px",
                         width = "100%",
                         value = "",#transcriptDefault
                       ),
                       # these are the detailed transcription instructions
                       # opens a modal from app_server.R
                       actionButton("full_transcription",
                                    "Detailed transcription rules"),
                     )
                   ),
                   br(),
                   fluidRow(column(
                     width = 10,
                     offset = 1,
                     # buttons
                     div(
                       align = "center",
                       actionButton("glide_back3", "Back"),
                       actionButton("start",
                                    "Begin Scoring")
                     )
                   ))),
      # This is a hidden tabset panel that is used just for training
      # the only way to get here is to select training module. 
      # this just seemed like the best place to put it
      # also its consistent with the rest of the app. 
      # training_markdown is in app_server.R
      tabPanelBody(value = "glide4_training",
                   div(id = "training_div2",
                       fluidRow(
                         uiOutput("training_markdown")
                       )))
    )
  )
}
