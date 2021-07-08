scoring_div <-
  fluidRow(
    column(width = 12,
           fluidRow(
                       htmlOutput("img")
             ),
           fluidRow(
                       h4("1. Select the sentences that match the concept."),
                       uiOutput("sortable"),
           ),
           fluidRow(
                       h4("2. Score each concept noted above. The current score is [current score]."),
                       #column(width = 12, align = "center", 
                       div( id = "mca_results", 
                            uiOutput("scores1234")
                       )
           ),
           fluidRow(
             column(width = 4, offset = 4,
               align = "center",
                    #column(width = 12, style = "align:center;",
                    actionButton("prev", label = "", icon = icon('arrow-left')),
                    actionButton("nxt", label = "",  icon = icon('arrow-right')) #style = "float:right;",
             )
                    
           )
    )
  )