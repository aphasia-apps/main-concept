

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    # reactiveValues is a list where elements of the list can change
    # startign places for pages and storing data. ####
    values = reactiveValues(i=0,
                            concept = list(),
                            selected_sentences = list(),
                            concept_accuracy = list()
    )
    values$previous <- NULL # previous data if uploaded
    values$num_previous <- 0 # number of previous tests
    values$datetime <- Sys.time() # establishes datetime when app opens for saving
    
    
    ################################## PREVIOUS DATA ###############################
    # ------------------------------------------------------------------------------
    ################################################################################ 
    
    # observer for uploading data
    observeEvent(input$file1,{
        file <- input$file1
        ext <- tools::file_ext(file$datapath)
        # check upload
        req(file)
        validate(need(ext == "csv", "Please upload a csv file"))
        # save upload
        values$previous <- read.csv(file$datapath) %>%
            drop_na(response)
        # assign number of previous values
        values$num_previous <- length(unique(values$previous$date))
        
    })
    
    ################################## OBSERVERS ###################################
    # ------------------------------------------------------------------------------
    ################################################################################
    
    ###########################Intro tab next and back############################
    observeEvent(input$glide_next1,{
        updateTabsetPanel(session, "glide", "glide2")
    })
    
    observeEvent(input$glide_back1,{
        updateTabsetPanel(session, "glide", "glide1")
    })
    
    observeEvent(input$glide_next2,{
        updateTabsetPanel(session, "glide", "glide3")
    })
    
    observeEvent(input$glide_back2,{
        updateTabsetPanel(session, "glide", "glide2")
    })
    
    ################################## START ASSESSMENT ############################
    # start button. sets the i value to 1 corresponding to the first slide
    # switches to the assessment tab
    # initialize values in here so that they reset whever someone hits start. 
    observeEvent(input$start, {
        # dataframe of items, difficulty, discrimination; NA column for responses 
        values$i = 0
        # got to slides
        updateNavbarPage(session, "mainpage", selected = "Assessment")
        
    })
    
    #############################START OVER#########################################
    # if start over is hit, go to home page
    # start assessment button then resets everything
    observeEvent(input$start_over,{
        shinyjs::reset("intro_tab")
        updateTabsetPanel(session, "glide", "glide1")
        updateNavbarPage(session, "mainpage",
                         selected = "Home")
        values$datetime <- Sys.time() # reestablishes datetime
        values$i=0
        values$concept = list()
        values$selected_sentences = list()
        values$concept_accuracy = list()
        
    })
    
    ################################## FOOTER MODAL ################################
    # ------------------------------------------------------------------------------
    ################################################################################
    # More information modal
    observeEvent(input$info, {
        showModal(modalDialog(
            tags$iframe(src="README.html", width = "100%",
                        height = "650px", frameBorder = "0"),
            easyClose = TRUE,
            footer = NULL,
            size = "l"
        ))
    })
    # readme modal. probabily will be deleted
    observeEvent(input$dev, {
        showModal(modalDialog(
            tags$iframe(src="README.html", width = "100%",
                        height = "650px", frameBorder = "0"),
            size = "l",
            easyClose = TRUE,
            footer = NULL
        ))
    })
    


})
