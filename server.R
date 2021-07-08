

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
        values$previous <- read.csv(file$datapath)
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
        updateNavbarPage(session, "mainpage", selected = "scoring")
        
    })
    
    #############################START OVER#########################################
    # if start over is hit, go to home page
    # start assessment button then resets everything
    observeEvent(input$start_over,{
        shinyjs::reset("intro_tab")
        updateTabsetPanel(session, "glide", "glide1")
        updateNavbarPage(session, "mainpage",
                         selected = "intro")
        values$datetime <- Sys.time() # reestablishes datetime
        values$i=0
        values$concept = list()
        values$selected_sentences = list()
        values$concept_accuracy = list()
        
    })
    
    #################################### COUNTER #################################
    #counter fnctions to change page contents ######
    # note this also saves the input data to the reactive list 'values' #####
    # this is probably ok for the time being
    observeEvent(input$nxt,{
        
        # score = c(input$accuracy1, input$accuracy2, input$accuracy3, input$accuracy4)
        # len = length(score)
        # component = seq(1,len,1)
        # concept = rep(values$i, len)
        # 
        # values$concept[[values$i]] = values$i
        # values$selected_sentences[[values$i]] = input$score_mca
        # values$concept_accuracy[[values$i]] = tibble(rating = score,
        #                                              component = component,
        #                                              concept = concept)
        values$i <- values$i + 1
    })
    
    # counter down
    observeEvent(input$prev,{
        values$i <- values$i - 1
    })
    #counter up getting started
    observeEvent(input$start,{
        #input$start
        #isolate({
        values$i <- values$i + 1
        #})
    })
    observeEvent(input$goback,{
        #input$prev
        #isolate({
        values$i <- 0
        # })
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
    
    ################################## REACTIVE DATA ###############################
    # ------------------------------------------------------------------------------
    ################################################################################
    
    
    
    
    ################################## OUTPUTS ####################################
    # ------------------------------------------------------------------------------
    ################################################################################
    
    
    ###################################### SCORING INFO ############################
    
    stim_task <- reactive({
        tibble(
            stim = input$input_stimulus,
            stim_num = if(input$input_stimulus == 'broken_window'){1
            } else if(input$input_stimulus=='cat_rescue'){2
            } else if(input$input_stimulus == 'refused_umbrella'){3
            } else if(input$input_stimulus == 'cinderella'){4
            } else if(input$input_stimulus == 'sandwich'){5
            } else {0},
            num_slides = if(input$input_stimulus == 'broken_window'){8
            } else if(input$input_stimulus=='cat_rescue'){10
            } else if(input$input_stimulus == 'refused_umbrella'){10
            } else if(input$input_stimulus == 'cinderella'){34
            } else if(input$input_stimulus == 'sandwich'){10
            } else {0}
        )
    })
    
    output$scoring_info <- renderUI({
        img_val = values$i
        paste_val = if(input$input_stimulus == 'broken_window'){'bw'
        } else if(input$input_stimulus == 'cat_rescue'){'cr'
        } else if(input$input_stimulus == 'refused_umbrella'){'u'
        } else if(input$input_stimulus == 'cinderella'){'c'
        } else if(input$input_stimulus == 'sandwich'){'s'
        } else {}
        if(img_val>0 && img_val < stim_task()$num_slides+1){
            return(get(paste0(paste_val, img_val)))
        } else {}
    })
    
    ###################################### SELECT BUTTONS SENTENCES ###################
    # displays the unique sentences to be selected
    # get sentences #######
    sentences <- reactive({
        df = tibble(txt = unlist(tokenize_sentences(input$input_transcript)))
    })
    
    output$sentence_buttons <- renderUI({
        df = sentences()
            checkboxGroupButtons(
                inputId = "score_mca",
                justified = T,
                individual = T,
                choices = unique(df$txt)
        )
        
    })
    

})
