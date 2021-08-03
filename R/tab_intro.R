
intro_tab_div <-
   column(width = 12,
          tabsetPanel(type="hidden",
                      id = "glide",
                      tabPanelBody(value = "glide1",
                                   column(width = 10, offset = 1,
                                          div(
                                            includeMarkdown(here("www", "intro.md"))
                                            #markdown(intro_md)
                                          ),
                                          div(align="center",
                                              actionButton("glide_next1", "Next"))
                                   )
                                   
                      ),
                      tabPanelBody(value = "glide2",
                                   column(width = 10, offset = 1,
                                          div(class="ox-hugo-table basic-styling",
                                            #markdown(scoring_md)
                                            includeMarkdown(here("www", "scoring.md"))
                                          ),
                                          div(align="center",
                                              actionButton("glide_back1", "Back"),
                                              actionButton("glide_next2", "Get Started"))
                                   )
                                   
                      ),
                      tabPanelBody(value = "glide3",
                                   column(width = 10, offset = 1,
                                    div(align = "center",
                                       div(style="display: inline-block; text-align: left;",
                                           h5("Input participant information"), br(),
                                           textInput("name", "Enter a Name"),
                                           selectInput(inputId = "input_stimulus",
                                                        label = "Select stimulus",
                                                        c("Broken Window" = 'broken_window',
                                                          "Cat Rescue" = 'cat_rescue',
                                                          "Refused Umbrella" = 'refused_umbrella',
                                                          "Cinderella" = 'cinderella',
                                                          "Sandwich" = 'sandwich'),
                                                        selected = "broken_window"#, 
                                                        #inline = F
                                                       ),
                                           numericInput("input_duration",
                                                        "Enter Duration (seconds)",
                                                        value = 0,
                                                        min = 0,
                                                        max = 720
                                           ),
                                           textAreaInput("notes", "Enter any notes", width = "100%", height = "100px"),
                                           #fileInput("file1", "Upload previous results", accept = ".csv"),
                                       )
                                   ),
                                   div(align = "center",
                                       actionButton("glide_back2", "Back"),
                                       actionButton("glide_next3", "Next")
                                   )
                                  )
                      ),
                      tabPanelBody(value = "glide4",
                                fluidRow(
                                   column(width = 5, offset = 1,
                                   #div(align = "center",
                                       #div(style="display: inline-block; text-align: left;",
                                           ### Use this to set how many items to run.
                                   "We recommended copying and saving samples into a text editor (e.g. microsoft word) after transcribing and before scoring.", br(), br(),
                                     tabsetPanel(id ="instructions",
                                                 tabPanel("Transcribing", br(),
                                                          "This will be info about transcribing",
                                                          includeMarkdown(here("www", "transcribing.md"))
                                                 ),
                                                 tabPanel("Segmenting", br(),
                                                          "This will be info about segmenting",
                                                          includeMarkdown(here("www", "segmenting.md"))
                                                          )
                                             #)
                                           #)
                                       )
                                   ),
                                   column(width = 5,
                                           textAreaInput("input_transcript",
                                                         "Enter transcript (separate utterances with a period)",
                                                         height = "400px",
                                                         width = "100%",
                                                         value = transcriptDefault
                                           )
                                        )
                                      ),
                                fluidRow(
                                  column(width = 10, offset = 1,
                                       div(align = "center",
                                               actionButton("glide_back3", "Back"),
                                               actionButton("start",
                                                            "Begin Scoring")
                                           )
                                       )
                                )
                                   )
                      )
   )




