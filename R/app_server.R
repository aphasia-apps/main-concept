#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
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
  
  w <- waiter::Waiter$new(
    color = waiter::transparent(0.1),
    html = waiter::spin_refresh()
  )
  
  w1 <- waiter::Waiter$new(
    color = waiter::transparent(0.1),
    html = waiter::spin_refresh()
  )
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
    
  })
  
  ################################## OBSERVERS ###################################
  # ------------------------------------------------------------------------------
  ################################################################################
  
  # disables the navbar buttons in different situations
  
  observe({
    #if(values$i==0 || input$mainpage == "scoring"){
      shinyjs::disable(selector = "#mainpage li a[data-value=results]")
      shinyjs::disable(selector = "#mainpage li a[data-value=scoring]")
      shinyjs::disable(selector = "#mainpage li a[data-value=intro]")
      if(input$mainpage != "results"){
        shinyjs::hide("report")
      } else {
        shinyjs::show("report")
      }
    # } else if(input$mainpage == "results"){
    #   shinyjs::enable(selector = "#mainpage li a[data-value=scoring]")
    # } else if(input$mainpage == "intro" && values$i>0){
    #   shinyjs::enable(selector = "#mainpage li a[data-value=scoring]")
    # } else {
    #   shinyjs::enable(selector = "#mainpage li a[data-value=intro]")
    # }
    
    # if(input$mainpage == "intro"){
    #   shinyjs::disable("downloadData")
    # } else {
    #   shinyjs::enable("downloadData")
    # }
  })
  
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
  
  observeEvent(input$glide_next3,{
    w$show()
    values$norms = get_norms(stimulus = input$input_stimulus)
    values$time = Sys.time()
    w$hide()
    updateTabsetPanel(session, "glide", "glide4")
  })
  
  observeEvent(input$glide_back3,{
    updateTabsetPanel(session, "glide", "glide3")
  })
  
  # buttons to advance scoring. dont delete you bozo. 
  
  observe(
    if(input$mainpage == "scoring"){
      shinyjs::show("footer_buttons")
    } else {
      shinyjs:: hide("footer_buttons")
    }
  )
  
  # can't hit previous on first page 
  
  observe(
    if(values$i == 1){
      shinyjs::disable("prev")
    } else {
      shinyjs::enable("prev")
    }
  )
  
  ################################## START ASSESSMENT ############################
  # start button. sets the i value to 1 corresponding to the first slide
  # switches to the assessment tab
  observeEvent(input$start, {
    
    values$i = 1
    values$stim_task <- tibble::tibble(
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
    updateNavbarPage(session, "mainpage", selected = "scoring")
    values$transcript = input$input_transcript
    
  })
  
  #############################START OVER#########################################
  
  # if start over is hit, go to home page
  
  observeEvent(input$start_over,{
    # shinyWidgets::confirmSweetAlert(
    #   inputId = "confirm_start_over",
    #   session = session,
    #   title = "Are you sure you want to start over?",
    #   text = "All data will be lost.",
    #   type = "warning",
    #   width = "300px", 
    # )
    
    showModal(modalDialog(
      title="Are you sure you want to start over?",
      "All data will be lost.",
      footer = tagList(actionButton("confirm_start_over", "Start over"),
                       modalButton("Cancel")
      ), 
      size = "s",
    ))
    
    
    
    
  })
  
  observeEvent(input$confirm_start_over,{
    if(isTruthy(input$confirm_start_over)){
      session$reload()
    }
  })
  
  ########################## STORE RESPONSES #################################
  #counter fnctions to change page contents ######
  # note this also saves the input data to the reactive list 'values' #####
  
  # if next is hit
  # - store responses
  # iterate values$i which changes the concept which is displayed
  observeEvent(input$nxt,{
    
    # grab selected components
    score = c(input$accuracy1, input$accuracy2, input$accuracy3, input$accuracy4)
    len = length(score)
    
    # require them all to be scored. 
    if(len < values$concept_len){
      showNotification("Please score all components",  type = "error")
    } else {
      
      component = seq(1,len,1)
      concept = rep(values$i, len)
      # saving the data
      values$concept[[values$i]] = values$i
      values$selected_sentences[[values$i]] = ifelse(is.null(input$score_mca), "none", input$score_mca)
      values$concept_accuracy[[values$i]] = tibble::tibble(rating = score,
                                                           component = component,
                                                           concept = concept)
      
      ##### Training feedback ######
      
      if (isTruthy(values$training)){
        
        values$check = values$concept_accuracy[[values$i]] %>%
          dplyr::inner_join(values$answers, by = c("component", "concept"))
        #print(values$check)
        check_concepts = all(values$check$rating == values$check$correct_rating)
        check_sentences = values$selected_sentences[[values$i]] == values$key[[values$i]]
        
        if(isTruthy(check_concepts) & isTruthy(check_sentences)){
          
          shinyWidgets::confirmSweetAlert(
            inputId = "alert_correct_answer",
            session = session,
            title = "Nice Work!",
            text = div(
              DT::DTOutput("training_table")
            ),
            type = "success",
            width = "300px", 
            html = T
          )
         
        } else if (isTruthy(check_concepts)) {
          
          shinyWidgets::sendSweetAlert(
            session = session,
            title = "Try Again!",
            text = div(
              tags$em("Your concepts are correct, but you didn't select the correct utterance."),br(),
              DT::DTOutput("training_table")
            ),
            type = "error",
            width = "300px", 
            html = T
          )
          
        } else {
          
          shinyWidgets::sendSweetAlert(
            session = session,
            title = "Try Again!",
            text = div(
              DT::DTOutput("training_table")
            ),
            type = "error",
            width = "300px", 
            html = T
          )
          
        }
        
        
      } else {
        
        # only do this part here if not trianing
        # go to results if the scoring is done. 
        if (values$i == values$stim_task$num_slides) {
          w1$show()
          print(unlist(values$selected_sentences))
          updateNavbarPage(session, "mainpage", selected = "results")
        } else{
          # otherwise iterate values$i and move on to the next item. 
          values$i <- values$i + 1
        }
        
        
      }
      
      
      

      
    #}
    # put all the results together. 
      values$results_mca <- 
        get_long_results_df(concept_accuracy = values$concept_accuracy,
                            filtered_concepts = 
                              values$concept_labels %>%
                              dplyr::ungroup() %>%
                              dplyr::select(id, e1:e4) %>%
                              tidyr::pivot_longer(cols= e1:e4, names_to = "component", values_to = "element") %>%
                              dplyr::mutate(component = as.numeric(stringr::str_remove(component, "e"))) %>%
                              dplyr::rename(concept = id)
        )

    } 
    
    
    
  })
  
  # if you his previous, go back. prev is disabled on concept 1. 
  observeEvent(input$prev,{
    values$i <- values$i -1
  #  print(values$concept_accuracy[[values$i]])
  })
  
  observeEvent(input$alert_correct_answer,{
    req(isTruthy(input$alert_correct_answer))
    if (values$i == values$stim_task$num_slides) {
      w1$show()
      updateNavbarPage(session, "mainpage", selected = "results")
    } else{
      # otherwise iterate values$i and move on to the next item. 
      values$i <- values$i + 1
    }
  })
  
  
  ################################## FOOTER MODAL ################################
  # ------------------------------------------------------------------------------
  ################################################################################

  observeEvent(input$about, {
    showModal(modalDialog(
      div(style="margin:5%;",
        includeMarkdown(system.file("app/www/bio.md", package = "mainConcept"))
      ),
      size = "l",
      easyClose = TRUE
    ))
  })
  
  # dont delete this. uncomment it when you change the footer onclick
  observeEvent(input$references, {
    showModal(modalDialog(
      div(style="margin:5%",
          includeMarkdown(system.file("app/www/references.md", package = "mainConcept"))
      ),
      size = "l",
      easyClose = TRUE
    ))
    
  })
  
  ################################### OTHER MODALS ############################
  #trascription rules
  observeEvent(input$full_transcription, {
    showModal(modalDialog(
      tags$iframe(src = "www/full_transcription.html",
                  frameBorder="0",
                  height = "650px",
                  width = "100%"),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  #trascription rules
  observeEvent(input$full_transcription2, {
    showModal(modalDialog(
      tags$iframe(src = "www/full_transcription.html",
                  frameBorder="0",
                  height = "650px",
                  width = "100%"),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  ################################## REACTIVE DATA ###############################
  # ------------------------------------------------------------------------------
  ################################################################################
  
  ################################## OUTPUTS #################################
  # --------------------------------------------------------------------------
  ############################################################################
  
  # this is the UI For the scoring tab
  
  output$intro_div <- renderUI({
    get_intro_div()
  })
  
  # this is the UI For the scoring tab
  
  output$scoring_div <- renderUI({
    get_scoring_div(num=values$i)
  })
  
  # this is the UI For the results tab
  
  output$results_div <- renderUI({
    get_results_div()
    
  })
  
  ############################# Display Concept HTML CODE ####################
  # these are the concepts
  # gets fed to the scoring_div
  
  output$scoring_info <- renderUI({
    img_val = values$i
    paste_val = if(values$stim_task$stim == 'broken_window'){'bw'
    } else if(values$stim_task$stim == 'cat_rescue'){'cr'
    } else if(values$stim_task$stim == 'refused_umbrella'){'u'
    } else if(values$stim_task$stim == 'cinderella'){'c'
    } else if(values$stim_task$stim == 'sandwich'){'s'
    } else {}
    if(img_val>0 && img_val < values$stim_task$num_slides+1){
      return(div(style = sty,
                 #includeMarkdown(paste0("www/", input$input_stimulus, "/", paste0(paste_val, img_val, ".md")))
                 includeMarkdown(system.file(paste0("app/www/", 
                                                    values$stim_task$stim, "/",
                                                    paste0(paste_val, img_val, ".md")), package = "mainConcept"))
      )
      )
    } else {}
  })
  
  ############################### SELECT BUTTONS SENTENCES ###################
  # displays the unique sentences to be selected
  # get sentences #######
  output$sentence_buttons <- renderUI({
    req(values$transcript)
    df = tibble::tibble(txt = stringr::str_trim(unlist(strsplit(values$transcript, "(?<=\\.)", perl = T))))
    shinyWidgets::checkboxGroupButtons(
      inputId = "score_mca",
      justified = T, size = "sm",
      individual = T,
      choices = unique(df$txt),
      selected = if (length(values$selected_sentences)>=values$i && values$i>0){
        values$selected_sentences[[values$i]]
      } else {NULL},
    )
    
  })
  
  ######################### MAIN CONCEPT SCORING STUFF #######################
  
  # how long is the current concept?
  observeEvent(values$i,{
    req(values$i>0)
    values$concept_len <-
      main_concepts %>%
      dplyr::filter(task == values$stim_task$stim) %>%
      dplyr::ungroup() %>%
      #dplyr::select(concept_length) %>%
      dplyr::slice(values$i) %>%
      dplyr::pull(concept_length)
  })
  
  # holds label information for scoring buttons
  observeEvent(values$stim_task$stim,{
    req(values$stim_task$stim)
    values$concept_labels <- 
      main_concepts %>%
      dplyr::filter(task == values$stim_task$stim)
  })
  
  ########### These four setup the scoring buttons for concepts ##############
  ########### Score 1, 2, 3, 4 create the buttons ############################
  ########### score_sentences dplyr::pulls them together to be rendered #############
  
  # change to AN when ready for release. 
  #test_var <- "Absent" #"Absent" # NA
  choices = c("Accurate", "Inaccurate", "Absent")
  choice_tests = c("Accurate", "Inaccurate", "Absent")
  # concept 1
  output$score1 <- renderUI({
    if(values$i<values$stim_task$num_slides+1){
      shinyWidgets::radioGroupButtons(
        inputId = "accuracy1",
        label = values$concept_labels[values$i, 2], 
        choices = choices,
        direction = "vertical",
        selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
          values$concept_accuracy[[values$i]][1,1]
        } else {
          #NA
          sample(choice_tests, 1)
          }
      )
    } else {}
    
  })
  
  # concept 2
  output$score2 <- renderUI({
    if(values$i<values$stim_task$num_slides+1){
      shinyWidgets::radioGroupButtons(
        inputId = "accuracy2",
        label = values$concept_labels[values$i, 3], 
        choices = c("Accurate", "Inaccurate", "Absent"),
        direction = "vertical",
        selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
          values$concept_accuracy[[values$i]][2,1]
        } else {
          #NA
          sample(choice_tests, 1)
        }
      )
    }else{}
    
  })
  
  # concept 3 - only shown when concept length is longer than 3
  output$score3 <- renderUI({
    if(values$i<values$stim_task$num_slides+1){
      if(values$concept_len<3){} else {
        shinyWidgets::radioGroupButtons(
          inputId = "accuracy3",
          label = values$concept_labels[values$i, 4], 
          choices = c("Accurate", "Inaccurate", "Absent"),
          direction = "vertical",
          selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
            values$concept_accuracy[[values$i]][3,1]
          } else {
            #NA
            sample(choice_tests, 1)
          }        
          )
      } 
    }else{}
    
  })
  
  # concept 4 - only shown below for the one occurance. 
  output$score4 <- renderUI({
    shinyWidgets::radioGroupButtons(
      inputId = "accuracy4",
      label = values$concept_labels[values$i, 5], 
      choices = c("Accurate", "Inaccurate", "Absent"),
      direction = "vertical",
      selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
        values$concept_accuracy[[values$i]][4,1]
      } else {
        #NA
        sample(choice_tests, 1)
      }    )
  })
  
  # gathers the concept scoring buttons into a single UI to show. 
  output$score_sentences <- renderUI({
    if (input$input_stimulus == "cinderella" && values$i == 16){
      tagList(
        fluidRow(
          column(width = 3, align = "center",
                 uiOutput("score1")
          ),
          column(width = 3, align = "center",
                 uiOutput("score2")
          ),
          column(width = 3, align = "center",
                 uiOutput("score3")
          ),
          column(width = 3, align = "center",
                 uiOutput("score4")
          )
        )
      )
    } else {
      tagList(
        fluidRow(
          column(width = 4, align = "center", 
                 uiOutput("score1")
          ),
          column(width = 4, align = "center",
                 uiOutput("score2")
          ),
          column(width = 4, align = "center",
                 uiOutput("score3")
          )
        )
      )
    }
    
  })
  
  
  ################################## RESULTS #################################
  # --------------------------------------------------------------------------
  ############################################################################
  
  # which concepts are important for this stimulus?
  # filter_concepts <- reactive({
  #     main_concepts %>%
  #         dplyr::ungroup() %>%
  #         dplyr::filter(task == input$input_stimulus) %>% 
  #         dplyr::select(id, e1:e4) %>%
  #         tidyr::pivot_longer(cols= e1:e4, names_to = "component", values_to = "element") %>%
  #         dplyr::mutate(component = as.numeric(str_remove(component, "e"))) %>%
  #         dplyr::rename(concept = id)
  # })
  
  # gets the summary table of results. 
  results_mca_tab <- reactive({
    get_summary_table(results = values$results_mca,
                      norms = values$norms,
                      scoring = input$scoring_system,
                      min = input$input_duration)
  })
  
  # outputs summmary table 
  output$results_mca_table <- renderTable({
    tab = results_mca_tab() %>%
      dplyr::mutate(Score = as.character(Score))
    w1$hide()
    return(tab)
  },
  align = "c", 
  colnames = T,
  spacing = "s",
  width = "100%",
  na = "-")
  
  # outputs summary plot
  output$plot <- renderPlot({
    get_plot(norms = values$norms$acc,
             current_score = as.numeric(c(
               results_mca_tab()[[1,3]], # composite
               results_mca_tab()[[2,2]], # AC
               results_mca_tab()[[7,2]],
               readr::parse_number(results_mca_tab()[[8,2]])
             )
             ),
             stim = values$stim_task$stim,
             scoring = input$scoring_system,
             norm_var = input$norm_variable,
             basesize=14)
  })
  
  
  ############## Downloads ##################################################3
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$stimMC, "_MC_summary.xlsx", sep = "")
    },
    content = function(file) {
      openxlsx::write.xlsx(
                  get_download_data(
                              current_tab = input$mainpage,
                              values = values,
                              results_tab = results_mca_tab())
      , file)
    }
  )
  
  ################################## TRAINING #################################
  # --------------------------------------------------------------------------
  ############################################################################
  
  # This will be about the training module - a modal
  observeEvent(input$glide_training, {
    showModal(modalDialog(
      title = "Main Concept Analysis Training Modules",
             div(id="training_div",
                 includeMarkdown(system.file("app/www/training_module.md",
                                             package = "mainConcept")),
                 radioButtons("training_module",
                              label = h4('Pick a training module'),
                              choices = c("Broken Window 1" = "1",
                                          "Broken Window 2" = "2",
                                          "Cat Rescue 1" = "3"),
                              selected = "1",
                              inline = T)
      ),
      size = "m",
      easyClose = TRUE,
      footer = tagList(actionButton("start_training", "Start scoring"),
                       modalButton("Cancel")
      )
    ))
  })
  
  training_transcript1 <- "Okay. I’ve done this before. He kicked the ball. It went doodoodoo and went through the glass. It’s his dad sitting in the the couch. It’s not good."
  training_transcript2 <- "He kicking ball. And the lamp it hits. Man yelled."
  training_transcript3 <- "Looks like the problem is the cat is stuck up in a tree. Father is out on the and. he's kind of stuck himself I think. The little girl is crying for the cat. She's got an umbrella. There's a guy up in the or. a dog barking up the tree. And the fire department is coming. A little girl was trying to reach him I guess. I don't know if she was trying to get this ladder or not. I have no idea about that. But anyway the firemen are coming. The fire truck is there. And they're coming out with a ladder apparently to help get the cat and father out of the tree."
  # All the things that need to start happening for training to work. 
  observeEvent(input$start_training,{
    values$training = T
    values$i = 1
    values$key =keys[[as.numeric(input$training_module)]]
    values$datetime <- Sys.time()
    
    
    stim_in <- if(input$training_module == "1"){"broken_window"
      } else if (input$training_module == "2"){"broken_window"
      } else if (input$training_module == "3"){"cat_rescue"}
    
    values$hide_answers = ifelse(input$training_module != "1", T, F)
    
    values$answers <- answers %>% dplyr::filter(module == input$training_module)
    
    values$stim_task <- tibble::tibble(
      stim = stim_in,
      stim_num = if(stim_in == 'broken_window'){1
      } else if(stim_in=='cat_rescue'){2
      } else if(stim_in == 'refused_umbrella'){3
      } else if(stim_in == 'cinderella'){4
      } else if(stim_in == 'sandwich'){5
      } else {0},
      num_slides = if(stim_in == 'broken_window'){8
      } else if(stim_in=='cat_rescue'){10
      } else if(stim_in == 'refused_umbrella'){10
      } else if(stim_in == 'cinderella'){34
      } else if(stim_in == 'sandwich'){10
      } else {0}
    )
    values$transcript = get(paste0("training_transcript", input$training_module))
    values$norms = get_norms(stimulus = stim_in, google_sheets = T) 
    # static_norms %>% dplyr::filter(stim==input$input_stimulus)
    removeModal()
    updateTabsetPanel(session, "glide", "glide4_training")
  })
  
  observeEvent(input$start_training_scoring,{
    updateNavbarPage(session, "mainpage", selected = "scoring")
  })
  
  observeEvent(input$show_transcript_answer,{
    shinyjs::show("correct_transcript")
  })
  
  observe(
    if(isTruthy(input$glide == "glide4_training" & input$mainpage == "intro")){
      shinyjs::show("footer_buttons_training")
    } else {
      shinyjs:: hide("footer_buttons_training")
    }
  )
  
  output$training_table <- DT::renderDT({
    req(values$check)
    get_training_table(values$check, values$hide_answers)
  }, options = list(
    dom = 't',
    ordering=F,
    searching=F,
    columnDefs=list(list(targets=-1, class="dt-left", width = "60%"))
  ))
  
  output$training_markdown <- renderUI({
    get_training_trascript_div(input$training_module)
  })
  
  
  ##################################### REPORT #################################
  
  output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "report.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- system.file("report.Rmd", package = "mainConcept")#file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(
                     summary_table = results_mca_tab(),
                     norms = values$norms$acc,
                     current_score = as.numeric(c(
                       results_mca_tab()[[1,3]], # composite
                       results_mca_tab()[[2,2]], # AC
                       results_mca_tab()[[7,2]],
                       #readr::parse_number(results_mca_tab()[[8,2]]),
                       readr::parse_number(results_mca_tab()[[8,2]])) 
                     ),
                     stim = values$stim_task$stim,
                     num_concepts = values$stim_task$num_slides,
                     scoring = input$scoring_system,
                     norm_var = input$norm_variable,
                     name = ifelse(nchar(input$name)>0, input$name, "X"),
                     start_time = values$time)
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    }
  )
  
  
  
}
