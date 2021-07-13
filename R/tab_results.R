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
        column(width = 4, align = "center",
               #tableOutput("sequencing"),
               h4("Table of Results"),
               tableOutput("results_mca_table"),
        ),
        column(width = 8,
               h4("Plot goes here"),
               div(align = "center",
                plotOutput("random_plot", height = "260")
               )
        )
      ),br(),
      fluidRow(
        column(align = "center", width = 10, offset = 1,
                  downloadButton("downloadData", "Download Summary Data"),
                  downloadButton("downloadData_raw", "Download Concept Data"),
                  downloadButton("downloadData_rawsen", "Download Sentence Data")
        ), br(), br(),
        column(align = "center", width = 12,
               actionButton("start_over", "Start Over", icon = icon("undo")))
      )
    )
  )