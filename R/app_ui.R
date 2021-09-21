#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
    tagList(
      # Adds the inst/ folder 
      golem_add_external_resources(),
      # use the shinyjs functions
      shinyjs::useShinyjs(),
      # for the loading screens/icons
      waiter::useWaiter(), 
      waiter::autoWaiter("waiter"),
      waiter::waiterPreloader(html=waiter::spin_dots(),color="white"),
      # this css when added to custom.css did not load in the right priority, 
      # so now its here
      tags$style(".swal2-popup {font-size: 1rem !important;}"),
      # UI starts here
      navbarPage(
              # Navbar content
              title = div(
                            div("Main Concept Analysis"), # title
                            div(id = "navbar-right",
                                # buttons on the right
                                # not always shown
                                downloadButton("report", "Download Report"),
                                downloadButton("downloadData", "Download Data"),
                                actionButton("start_over",
                                             "Start Over",
                                             icon = icon("undo")),
                                style = "position: absolute; right: 5px; top: 8px;")
                ),
                  # when referencing status of navbar, id is mainpage (input$mainpage == "...")
                 id = "mainpage",
                  # footer div
                 footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div()
                 ),
                 # loads theme function from theme.R
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
                 ),
                 ########################################################################
                 br(),br(),br(),br()     
      )
    )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'mainConcept'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

