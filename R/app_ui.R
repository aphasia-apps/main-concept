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
      # this css when added to custom.css did not load in the right priority, 
      # so now its here
      tags$style(".swal2-popup {font-size: 1rem !important;}"),
      # UI starts here
      navbarPage(
              # Navbar content
              title = "Main Concept Analysis",
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
                !!!list(bslib::nav_spacer(),
                        bslib::nav_item(pagetitle()),
                        bslib::nav_item(
                         tags$a(icon("github"),
                                 href = "https://github.com/aphasia-apps/mainConcept",
                                 target = "_blank",
                                 style = "color:black;")
                        )
                )
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

