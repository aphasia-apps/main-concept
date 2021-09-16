
#' Get summary table
#'
#' @param results the data frame of results
#' @param norms the norms for the scored stimulus
#'
#' @return
#' @export
get_summary_table <- function(results, norms, scoring = "dalton_richardson", min = 0){
  
  acc = norms$acc
  eff = norms$eff
  
  vals <- 
    if(scoring == "dalton_richardson"){
      tibble::tibble(
        AC = 3,
        AI = 2,
        IC = 2,
        II = 1,
        absent = 0
      )
    } else if(scoring == "kong") {
      tibble::tibble(
        AC = 3,
        AI = 2,
        IC = 1,
        II = 1,
        absent = 0
      )
    }
  
  df = results %>%
    dplyr::select(Concept = concept,
                  Code = Result#,
                  #Score = score
                  ) %>%
    dplyr::summarize(
              `Composite` = NA,#sum(Score),
              `AC` = sum(Code == 'AC'),
              `AI` = sum(Code == 'AI'),
              `IC` = sum(Code == 'IC'),
              `II` = sum(Code == 'II'),
              Absent = sum(Code == 'Absent'),
              `Attempts` = sum(Code == 'AC'|Code == 'AI'|Code == 'IC'| Code == 
                                 'II'),
              `Composite/min` = NA,
              `AC/min` = NA
    ) %>% 
    tidyr::pivot_longer(cols = everything(), names_to = 'Variable', values_to = 'Count') %>%
    dplyr::mutate(Count = as.character(Count))
  
  df$Score = NA

  df[[1,2]] = NA
  df[[2,3]] = round(as.numeric(df[2,2])*vals$AC)
  df[[3,3]] = round(as.numeric(df[3,2])*vals$AI)
  df[[4,3]] = round(as.numeric(df[4,2])*vals$IC)
  df[[5,3]] = round(as.numeric(df[5,2])*vals$II)
  df[[6,3]] = round(as.numeric(df[6,2])*vals$absent)
  
  #composite
  comp = sum(df[,3], na.rm = T)
  df[[1,3]] = round(as.numeric(comp))
  
  if(min >0){
    comp_min = comp/(min/60)
    df[[8,2]] = paste0(round(comp_min,1), "/min")
    ac_min = as.numeric(df[2,2])/(min/60)
    df[[9,2]] = paste0(as.character(round(ac_min,1)), "/min")
  } else {
    df[[8,2]] = NA
    df[[9,2]] = NA
  }

  
  df$`Percentile (Aphasia)` = NA
  df$`Percentile (Control)` = NA
  
  if(scoring == "dalton_richardson"){
    # aphasia norms
    #composite
    df[[1,4]] = ecdf_fun(subset(acc, Aphasia==1)$`MC COMPOSITE`, as.numeric(df[1,3]))
    # AC
    df[[2,4]] = ecdf_fun(subset(acc, Aphasia==1)$AC, as.numeric(df[2,2]))
    # Attempts
    df[[7,4]] = ecdf_fun(subset(acc, Aphasia==1)$`MC Attempts`, as.numeric(df[7,2]))
    # composite/min
        if(min >0){
            df[[8,4]] = ecdf_fun(subset(eff, Aphasia==1)$COMP_min, comp_min)
    # AC/min
            df[[9,4]] = ecdf_fun(subset(eff, Aphasia==1)$AC_min, ac_min)
        } else {
          df[[8,4]] = NA
          df[[9,4]] = NA
        }
    
    # control norms
    #composite
    df[[1,5]] = ecdf_fun(subset(acc, Aphasia==0)$`MC COMPOSITE`, as.numeric(df[1,3]))
    # AC
    df[[2,5]] = ecdf_fun(subset(acc, Aphasia==0)$AC, as.numeric(df[2,2]))
    # Attempts
    df[[7,5]] = ecdf_fun(subset(acc, Aphasia==0)$`MC Attempts`, as.numeric(df[7,2]))
    # composite/min
    if(min >0){
        df[[8,5]] = ecdf_fun(subset(eff, Aphasia==0)$COMP_min, comp_min)
        # AC/min
        df[[9,5]] = ecdf_fun(subset(eff, Aphasia==0)$AC_min, ac_min)
    } else {
      df[[8,5]] = NA
      
      df[[9,5]] = NA
     
      
    }
    
  } else {
    df$`Percentile (Aphasia)` = NA
    df$`Percentile (Control)` = NA
  }
  return(df)
}