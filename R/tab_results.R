
#' Get results div
#' 
#' this function generates the UI for the results page. 
#'
#' @return
#' @export
get_results_div <- function() {
  # allows for a loading screen to start the results page. 
  # not quite waiting long enough and need to fix...
  tagList(div(id = "waiter",
              column(
                width = 10,
                offset = 1,
                # fluidRow(column(
                #   align = "center",
                #   width = 12,
                #   h2("Results", style = "padding-bottom:5px;")
                #   )
                # ),
                fluidRow(
                  # this column is for the table. 
                  column(
                    width = 5,
                    align = "center",
                    div(
                      h4("Results", style = "float:left"),
                      div(
                        style = "float:right;margin-top:1rem;margin-bottom:.5rem;",
                        # this is for the little i with information about the table
                        shinyWidgets::dropdownButton(
                          includeMarkdown(
                            system.file("app/www/interpreting.md", package = "mainConcept")
                          ),
                          circle = F,
                          status = "default",
                          size = "s",
                          icon = icon("info"),
                          width = "500px",
                          tooltip = shinyWidgets::tooltipOptions(title = "Interpreting this table")
                        )
                      )
                    ),
                    # table output
                    tableOutput("results_mca_table"),
                    # option to choose the scoring system
                    div(
                      div(tags$b("Scoring system: ", HTML('&nbsp;')),
                          style = "display: inline-block;"),
                      div(
                        # choices. 
                        shinyWidgets::radioGroupButtons(
                          "scoring_system",
                          size = "s",
                          choices = c("Dalton & Richardson 2016" = "dalton_richardson",
                                      "Kong 2009" = "kong")
                        ),
                        style = "display: inline-block;"
                      )
                    )
                  ),
                  # this column is for the plot. 
                  column(
                    width = 6,
                    align = "center",
                    offset = 1,
                    div(
                      h4("Scores relative to norms", style = "float:left"),
                      div(
                        style = "float:right;margin-top:1rem;margin-bottom:.5rem;",
                        # same dropdown here. 
                        shinyWidgets::dropdownButton(
                          includeMarkdown(
                            system.file("app/www/interpreting_plot.md", package = "mainConcept")
                          ),
                          circle = F,
                          status = "default",
                          size = "s",
                          icon = icon("info"),
                          width = "500px",
                          right = T,
                          tooltip = shinyWidgets::tooltipOptions(title = "Interpreting this plot")
                        )
                      )
                    ),
                    # here's the plot
                    plotOutput("plot", width = "100%", height = "360px"),
                    br(),
                    br(),
                    # choose what variable you want to see. 
                    div(
                      div(tags$b("Variable:", HTML('&nbsp;')),
                          style = "display: inline-block;"),
                      div(
                        shinyWidgets::radioGroupButtons(
                          "norm_variable",
                          size = "s",
                          choices = c(
                            "Composite" = "MC COMPOSITE",
                            "AC" = "AC",
                            "Attempts" = "MC Attempts",
                            "AC/min" = "AC_min"
                          )
                        ),
                        style = "display: inline-block;"
                      )
                    )
                    
                  )
                ),br(),
                fluidRow(
                  column(
                    align = "left",
                    width = 12, 
                    h4("Summary:"),
                    uiOutput("results_text")
                  )
                )
              )))
}