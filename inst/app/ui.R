# Define UI


shinyUI(
  tagList(
    includeCSS(here("www", "style.css")),
    useShinyjs(),
    useWaiter(), 
    autoWaiter("waiter"),
    waiterPreloader(html=spin_dots(),color="white"),
    navbarPage(title = "Main Concept Analysis",
               id = "mainpage",
               footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div()
               ),
               
               theme = minimal_theme(),
               
               ############################ Instructions ############################## 
               tabPanel(value = "intro", title = "Intro", 
                        uiOutput("intro_div")
               ),
               ############################ Scoring ###################################
               tabPanel(value = "scoring", title = "Scoring",
                          uiOutput("scoring_div")
               ),
               ############################ Results ###################################
               tabPanel(value = "results", title = "Results", 
                        uiOutput("results_div")
               ),#,
               #tabPanel(value = "start_over", title = "Start Over")
               ########################################################################
         br(),br(),br(),br()     
    )
  )
)
