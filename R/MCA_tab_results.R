
#' Get results div
#'
#' @return
#' @export
get_results_div <- function(){
  tagList(
    div(id="waiter",
        column(width = 10, offset = 1,
               fluidRow(
                 column(align = "center", width = 12, 
                    h2("Results", style = "padding-bottom:5px;")
                    )
               ),
               fluidRow(
                 column(width = 5, align = "center",
                        div(
                          h4("Results summary", style = "float:left"),
                          div(style = "float:right;margin-top:1rem;margin-bottom:.5rem;",
                              shinyWidgets::dropdownButton(
                                includeMarkdown(system.file("app/www/interpreting.md", package = "mainConcept")),
                                circle = F, status = "default",size = "s",
                                icon = icon("info"), width = "500px", 
                                tooltip = shinyWidgets::tooltipOptions(title = "Interpreting this table")
                              ))
                        ),
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
                 column(width = 6, align = "center", offset = 1,
                        div(
                          h4("Scores relative to norms", style = "float:left"),
                          div(style = "float:right;margin-top:1rem;margin-bottom:.5rem;",
                              shinyWidgets::dropdownButton(
                                includeMarkdown(system.file("app/www/interpreting_plot.md", package = "mainConcept")),
                                circle = F, status = "default",size = "s",
                                icon = icon("info"), width = "500px", right = T,
                                tooltip = shinyWidgets::tooltipOptions(title = "Interpreting this plot")
                              ))
                        ),
                            plotOutput("plot", width = "100%", height = "360px"),br(),br(),
                            div(
                              div(tags$b("Variable:", HTML('&nbsp;')),
                                  style = "display: inline-block;"),
                              div(shinyWidgets::radioGroupButtons(
                                "norm_variable",
                                size = "s",
                                choices = c("Composite" = "MC COMPOSITE",
                                            "AC" = "AC",
                                            "Attempts" = "MC Attempts",
                                            #"Composite/min" = "COMP_min",
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
}