
#' Get results div
#'
#' @return
#' @export
get_results_div <- function(){
  tagList(
    div(id="waiter",
        column(width = 10, offset = 1,
               fluidRow(
                 h4("This will be information about interpreting results"),
                 textOutput("random_text"),
               ),
               fluidRow(
                 column(width = 5, align = "center",
                        br(),
                        tableOutput("results_mca_table"),
                        div(
                          div(tags$b("Scoring system: ", HTML('&nbsp;')),
                              style = "display: inline-block;"),
                          div(shinyWidgets::radioGroupButtons(
                                  "scoring_system",
                                 size = "s",
                                 choices = c("Dalton & Richardson 2016" = "dalton_richardson",
                                             "Kong 2009" = "kong"
                                             )
                                 ),
                              style = "display: inline-block;"
                              )
                        )
                 ),
                 column(width = 7,
                        div(align = "center",  br(),
                            plotOutput("plot", height = "360"),
                            div(
                              div(tags$b("Variable:", HTML('&nbsp;')),
                                  style = "display: inline-block;"),
                              div(shinyWidgets::radioGroupButtons(
                                "norm_variable",
                                size = "s",
                                choices = c("Composite" = "MC COMPOSITE",
                                            "AC" = "AC",
                                            "Attempts" = "MC Attempts",
                                            "Composite/min" = "COMP_min",
                                            "AC/min"= "AC_min"
                                )
                              ),
                              style = "display: inline-block;"
                              )
                            )
                        )
                 )
               )
        )
    )
  )
}