##### results tab

results_div <-
  tagList(
    column(width = 10, offset = 1,
      fluidRow(
                  br(),
                  h4("This will be information about interpreting results"),
                  textOutput("random_text"),
                  br(),
        ),
      fluidRow(
        column(width = 5, align = "center",
               #tableOutput("sequencing"),
               h4("Results"),
               tableOutput("results_mca_table"),
        ),
        column(width = 7,
               h4("Plot goes here"),
               div(align = "center",
                plotOutput("random_plot", height = "260")
               )
        )
      ),br(),
      fluidRow(
        column(align = "center", width = 10, offset = 1,
                  downloadButton("downloadData", "Download Data")
        ), br(), br(), br(), 
        column(align = "center", width = 12,
               actionButton("start_over", "Start Over", icon = icon("undo")))
      )
    )
  )