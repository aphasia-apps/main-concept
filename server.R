

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
    
    # observe({
    #     hide(selector = "#mainpage li a[data-value=intro]")
    #     hide(selector = "#mainpage li a[data-value=scoring]")
    #     hide(selector = "#mainpage li a[data-value=results]")
    #     hide(selector = "#mainpage li a[data-value=start_over]")
    #     
    #     if(input$mainpage != "intro"){
    #         toggle(selector = "#mainpage li a[data-value=start_over]")
    #     }
    # }, priority = 1000)
    
    observe({
        if(values$i==0 || input$mainpage == "scoring"){
            shinyjs::disable(selector = "#mainpage li a[data-value=results]")
            shinyjs::disable(selector = "#mainpage li a[data-value=scoring]")
            shinyjs::enable(selector = "#mainpage li a[data-value=intro]")
        } else if(input$mainpage == "results"){
            shinyjs::enable(selector = "#mainpage li a[data-value=scoring]")
            } else if(input$mainpage == "intro" && values$i>0){
                shinyjs::enable(selector = "#mainpage li a[data-value=scoring]")
                } else {
            shinyjs::enable(selector = "#mainpage li a[data-value=intro]")
        }
        
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
        updateTabsetPanel(session, "glide", "glide4")
    })
    
    observeEvent(input$glide_back3,{
        updateTabsetPanel(session, "glide", "glide3")
    })
    
    # buttons to advanc scoring. dont delete you bozo. 
    observe(
        if(input$mainpage == "scoring"){
            shinyjs::show("footer_buttons")
        } else {
            shinyjs:: hide("footer_buttons")
        }
    )
    
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
       # values$i <- values$i + 1
        # got to slides
        updateNavbarPage(session, "mainpage", selected = "scoring")
        
    })
    
    #############################START OVER#########################################
    # if start over is hit, go to home page
    
    observeEvent(input$start_over,{
        
            shinyjs::reset("intro_tab")
            updateTabsetPanel(session, "glide", "glide1")
            
            # immediately navigate back to previous tab
            updateTabsetPanel(session, "mainpage",
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
        
        
        score = c(input$accuracy1, input$accuracy2, input$accuracy3, input$accuracy4)
        len = length(score)
        
        if(len < concept_len()[1,1]){
            showNotification("Please score all components",  type = "error")
        } else {
        
        component = seq(1,len,1)
        concept = rep(values$i, len)

        values$concept[[values$i]] = values$i
        values$selected_sentences[[values$i]] = input$score_mca
        values$concept_accuracy[[values$i]] = tibble(rating = score,
                                                     component = component,
                                                     concept = concept)
        
            if (values$i == stim_task()$num_slides) {
                updateNavbarPage(session, "mainpage", selected = "results")
            } else{
            values$i <- values$i + 1
            }
   
        }
        
        
    })
    
    # counter down
    observeEvent(input$prev,{
        check0 = values$i - 1
        if(check0<1){
            check0 = 1
            values$i <- check0
        } else {
            values$i <- check0
        }

    })
    #counter up getting started
    # observeEvent(input$start,{
    #     #input$start
    #     #isolate({
    #     values$i <- values$i + 1
    #     #})
    # })
    # observeEvent(input$goback,{
    #     #input$prev
    #     #isolate({
    #     values$i <- 0
    #     # })
    # })
    
    
    ################################## FOOTER MODAL ################################
    # ------------------------------------------------------------------------------
    ################################################################################
    # More information modal
    observeEvent(input$info, {
        showModal(modalDialog(
            tags$iframe(src="https://docs.google.com/document/d/e/2PACX-1vR0_QBT5Ra5nDj5781RtlJcvSvEr8JJ9AwAJ9-xVbs_05c3khjw9Zj8__hA0CnrLQ/pub?embedded=true", width = "100%",
                        height = "650px", frameBorder = "0"),
            easyClose = TRUE,
            footer = NULL,
            size = "l"
        ))
    })
    # readme modal. probabily will be deleted
    observeEvent(input$about, {
        showModal(modalDialog(
            tags$iframe(src="https://aphasia-apps.github.io/main-concept/", width = "100%",
                        height = "650px", frameBorder = "0"),
            # div(
            #     includeMarkdown(here("www", "bio.md"))
            # ),
            size = "l",
            easyClose = TRUE,
            footer = NULL
        ))
    })
    
    observeEvent(input$references, {
        # showModal(modalDialog(
        #     div(
        #         includeMarkdown(here("www", "references.md"))
        #     ),
        #     size = "l",
        #     easyClose = TRUE,
        #     footer = NULL
        # ))
        
    })
    

    ################################## REACTIVE DATA ###############################
    # ------------------------------------------------------------------------------
    ################################################################################
    
    
    
    
    ################################## OUTPUTS #################################
    # --------------------------------------------------------------------------
    ############################################################################
    
    output$scoring_div <- renderUI({
        get_scoring_div(num=values$i)
    })
        
    ###################################### SCORING INFO ########################
    # craetes variables necessary to pull correct info for each concept ########
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
    
    ############################# Display Concept HTML CODE ####################
    output$scoring_info <- renderUI({
        img_val = values$i
        paste_val = if(input$input_stimulus == 'broken_window'){'bw'
        } else if(input$input_stimulus == 'cat_rescue'){'cr'
        } else if(input$input_stimulus == 'refused_umbrella'){'u'
        } else if(input$input_stimulus == 'cinderella'){'c'
        } else if(input$input_stimulus == 'sandwich'){'s'
        } else {}
        if(img_val>0 && img_val < stim_task()$num_slides+1){
            return(div(style = sty,
                       markdown(get(paste0(paste_val, img_val))))
            )
        } else {}
    })
    
    ############################### SELECT BUTTONS SENTENCES ###################
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
                choices = unique(df$txt),
                selected = if (length(values$selected_sentences)>=values$i && values$i>0){
                    values$selected_sentences[[values$i]]
                } else {sel()},
        )
        
    })
    
    # resets the check box group sentences input when values$i changes
    # later, change this to return to what was selected for that page
    sel = eventReactive(values$i,{
        sel = NULL
        sel
    })
    
    ######################### MAIN CONCEPT SCORING STUFF #######################
    
    # how long is the current concept?
    concept_len <- reactive({
        tmp = main_concepts %>%
            dplyr::filter(task == input$input_stimulus) %>%
            ungroup() %>%
            dplyr::select(concept_length) %>%
            slice(values$i)
    })
    
    # holds label information for scoring buttons
    concept_labels <- reactive({
        main_concepts %>%
            dplyr::filter(task == input$input_stimulus)
    })
    
    ########### These four setup the scoring buttons for concepts ##############
    ########### Score 1, 2, 3, 4 create the buttons ############################
    ########### score_sentences pulls them together to be rendered #############
    test_var <- "Accurate"
    
    # concept 1
    output$score1 <- renderUI({
        if(values$i<stim_task()$num_slides+1){
            radioGroupButtons(
                inputId = "accuracy1",
                label = concept_labels()[values$i, 2], 
                choices = c("Accurate", "Inaccurate", "Absent"),
                direction = "vertical",
                selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
                    values$concept_accuracy[[values$i]][1,1]
                } else {test_var}
            )
        } else {}
        
    })
    
    # concept 2
    output$score2 <- renderUI({
        if(values$i<stim_task()$num_slides+1){
            radioGroupButtons(
                inputId = "accuracy2",
                label = concept_labels()[values$i, 3], 
                choices = c("Accurate", "Inaccurate", "Absent"),
                direction = "vertical",
                selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
                    values$concept_accuracy[[values$i]][2,1]
                } else {test_var}
            )
        }else{}
        
    })
    
    # concept 3 - only shown when concept length is longer than 3
    output$score3 <- renderUI({
        if(values$i<stim_task()$num_slides+1){
            if(concept_len()[1,1]<3){} else {
                radioGroupButtons(
                    inputId = "accuracy3",
                    label = concept_labels()[values$i, 4], 
                    choices = c("Accurate", "Inaccurate", "Absent"),
                    direction = "vertical",
                    selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
                        values$concept_accuracy[[values$i]][3,1]
                    } else {test_var}
                )
            } 
        }else{}
        
    })
    
    # concept 4 - only shown below for the one occurance. 
    output$score4 <- renderUI({
        radioGroupButtons(
            inputId = "accuracy4",
            label = concept_labels()[values$i, 5], 
            choices = c("Accurate", "Inaccurate", "Absent"),
            direction = "vertical",
            selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
                values$concept_accuracy[[values$i]][4,1]
            } else {test_var}
        )
    })
    
    # gatheres the concept scoring buttons into a single UI to show. 
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
    
    filter_concepts <- reactive({
        main_concepts %>%
            ungroup() %>%
            dplyr::filter(task == input$input_stimulus) %>% 
            dplyr::select(id, e1:e4) %>%
            pivot_longer(cols= e1:e4, names_to = "component", values_to = "element") %>%
            mutate(component = as.numeric(str_remove(component, "e"))) %>%
            rename(concept = id)
    })
    
    # Creates a table of the results. 
    # see scoring logic. 
    results_mca <- eventReactive(input$nxt,{
        if(values$i==stim_task()$num_slides){
            mca = bind_rows(values$concept_accuracy) %>%
                left_join(filter_concepts(), by = c('concept', 'component')) %>%
                drop_na(element) %>%
                group_by(concept) %>%
                summarize(absent = sum(as.numeric(rating == "Absent")),
                          accurate = sum(as.numeric(rating == "Accurate")),
                          inaccurate = sum(as.numeric(rating == "Inaccurate"))) %>%
                mutate(
                    accuracy = case_when(
                        inaccurate > 0 ~ "I",
                        accurate > 0 ~ "A",
                        TRUE ~ "Absent"
                    ),
                    completeness = case_when(
                        absent > 0 ~ "I",
                        absent == 0 ~ "C",
                        TRUE ~ "missed"
                    )
                ) %>%
                mutate(completeness = ifelse(accuracy == "Absent", "", completeness)) %>%
                unite(col = "Result", accuracy, completeness, sep = "", remove = F) %>%
                left_join(scoring_mca, by = "Result")
        } else {}
        
    })
    
    results_mca_tab <- reactive({
        results_mca() %>%
            select(Concept = concept, Code = Result, Score = score) %>%
            summarize(`Accurate Complete` = sum(Code == 'AC'),
                      `Accurate Incomplete` = sum(Code == 'AI'),
                      `Inaccurate Complete` = sum(Code == 'IC'),
                      `Inaccurate Incomplete` = sum(Code == 'II'),
                      Absent = sum(Code == 'Absent'),
                      `Main Concept Attempts` = sum(Code == 'AC'|Code == 'AI'|Code == 'IC'| Code == 
                                                        'II'),
                      `Composite Score` = sum(Score)
            ) %>% 
            pivot_longer(cols = everything(), names_to = 'Variable', values_to = 'Score') %>%
            mutate(Score = as.character(Score))
    })
    
    output$results_mca_table <- renderTable(
        results_mca_tab(),
        align = "c", colnames = F
    )
    
    output$random_text <- renderText({
        shinipsum::random_text(nwords = 100)
    })
    
    output$random_plot <- renderPlot({
        shinipsum::random_ggplot(type = "dotplot")
    }, height = 250 )
    
    
    ##############3 Downloads #############3
    
    output$downloadData <- downloadHandler(
        filename = function() {
            paste(input$stimMC, "_MC_summary.xlsx", sep = "")
        },
        content = function(file) {
            writexl::write_xlsx(list(overall = results_mca_tab(),
                                     by_concept = results_mca(),
                                     transcript = transcr()), file)
        }
    )
    
    output$downloadData_raw <- downloadHandler(
        filename = function() {
            paste(input$stimMC, "_MC_concept.csv", sep = "")
        },
        content = function(file) {
            write.csv(bind_rows(values$concept_accuracy), file)
        }
    )
    
    output$downloadData_rawsen <- downloadHandler(
        filename = function() {
            paste(input$stimMC, "_MC_sentence.csv", sep = "")
        },
        content = function(file) {
            write.csv(get_sentence_data(values$selected_sentences), file)
        }
    )
    

})
