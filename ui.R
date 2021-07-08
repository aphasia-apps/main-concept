

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
               
               tabPanelBody(value = "Home",
                            #intro_tab_div
               ),
               
               ############################ Practice ##################################
               
               tabPanelBody(value = "Practice", 
                            #uiOutput("practice_tab")
               ),
               
               ############################ Assessment ################################
               
               tabPanelBody(value = "Assessment", 
                            #uiOutput("slides_tab")
               ),
               
               ############################ Results ###################################
               
               tabPanelBody(value = "Results", 
                            #results_tab_div
               )
               
               ########################################################################
               
               # close navbar page
    ),
    
    # adjusting for footer. 
    br(), br(), br(), br(), br(), 
    
    
  )

)
