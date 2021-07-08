# Define UI
shinyUI(
  tagList(
    includeCSS("www/style.css"),
    navbarPage(title = "Main Concept, Sequencing & Story Grammar",
               id = "mainpage",
               footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div
               ),
               theme = minimal_theme,
               
               ############################ Instructions ############################## 
               tabPanel(value = "intro", title = "Intro",
                            intro_tab_div
               ),
               ############################ Scoring ###################################
               tabPanel(value = "scoring", title = "Scoring",
                            scoring_div
               ),
               ############################ Results ###################################
               tabPanel(value = "results", title = "Results",
                            #results_tab_div
               )
               ########################################################################
    ),
    # adjusting for footer. 
    br(), br(), br(), br(), br(), 
  )
)
