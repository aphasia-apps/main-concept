# Define UI
shinyUI(
  tagList(
    includeCSS("www/style.css"),
    useShinyjs(),
    navbarPage(title = "Main Concept Analysis",
               id = "mainpage",
               footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div
               ),
               
               theme = minimal_theme,
               
               ############################ Instructions ############################## 
               tabPanelBody(value = "intro",# title = "Intro", 
                            intro_tab_div
               ),
               ############################ Scoring ###################################
               tabPanelBody(value = "scoring",# title = "Scoring",
                            uiOutput("scoring_div")
               ),
               ############################ Results ###################################
               tabPanelBody(value = "results",# title = "Results",
                            results_div
               ),#,
               #tabPanel(value = "start_over", title = "Start Over")
               ########################################################################
         br(),br(),br(),br()     
    )
  )
)
