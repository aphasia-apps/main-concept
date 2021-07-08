scoring_div <-
  fluidRow(
    column(width = 10,offset = 1,
           fluidRow(
                       htmlOutput("scoring_info")
             ),
           fluidRow(
                       h4("1. Select the sentences that match the concept."),
                       uiOutput("sentence_buttons"),
           ),
           fluidRow(
                       h4("2. Score each concept noted above. The current score is [current score]."),
                            uiOutput("score_sentences")
           ),
           fluidRow(
             column(width = 4, offset = 4,
               align = "center",
                    actionButton("prev", label = "", icon = icon('arrow-left')),
                    actionButton("nxt", label = "",  icon = icon('arrow-right'))
               )
             )
           )
    )