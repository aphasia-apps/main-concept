

# Define UI for application that draws a histogram
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
               
               tabPanel(value = "Intro", title = "Intro",
                            intro_tab_div
               ),
               
               
               ############################ Assessment ################################
               
               tabPanel(value = "Scoring", title = "Scoring",
                            scoring_div
               ),
               
               ############################ Results ###################################
               
               tabPanel(value = "Results", title = "Results",
                            #results_tab_div
               )
               
               ########################################################################
               
               # close navbar page
    ),
    
    # adjusting for footer. 
    br(), br(), br(), br(), br(), 
    
    
  )

)
