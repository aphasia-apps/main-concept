
#' Get summary table
#' 
#' creates the summary table for the results page. 
#'
#' @param results the data frame of results
#' @param norms the norms for the scored stimulus
#' @param scoring which scoring system is selected
#' @param min how long did the sample take, if 0, considered NA. 
#'
#' @return
#' @export
get_summary_table <- function(results, norms, scoring = "dalton_richardson", min = 0){
  
  acc = norms$acc
  eff = norms$eff
  
  # points - scoring systems
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
  
  # grab the reusults
  df = results %>%
    dplyr::select(Concept = concept,
                  Code = Result#,
                  #Score = score
                  ) %>%
    # count the number of codes in each category
    dplyr::summarize(
              `Composite` = NA,#sum(Score),
              `AC` = sum(Code == 'AC'),
              `AI` = sum(Code == 'AI'),
              `IC` = sum(Code == 'IC'),
              `II` = sum(Code == 'II'),
              Absent = sum(Code == 'Absent'),
              `Attempts` = sum(Code == 'AC'|Code == 'AI'|Code == 'IC'| Code == 
                                 'II'),
              `AC/min` = NA
    ) %>% 
    # go long
    tidyr::pivot_longer(cols = everything(), names_to = 'Variable', values_to = 'Count') %>%
    dplyr::mutate(Count = as.character(Count))
  
  # score is NA to start, then will fill it out. 
  df$Score = NA

  # number of each code * the value in the scoring system (vals above)
  df[[1,2]] = NA
  df[[2,3]] = round(as.numeric(df[2,2])*vals$AC)
  df[[3,3]] = round(as.numeric(df[3,2])*vals$AI)
  df[[4,3]] = round(as.numeric(df[4,2])*vals$IC)
  df[[5,3]] = round(as.numeric(df[5,2])*vals$II)
  df[[6,3]] = round(as.numeric(df[6,2])*vals$absent)
  
  #composite
  comp = sum(df[,3], na.rm = T)
  df[[1,3]] = round(as.numeric(comp))
  
  # calculate efficiency scores if time > 0 seconds
  if(min >0){
    ac_min = as.numeric(df[2,2])/(min/60)
    df[[8,2]] = paste0(as.character(round(ac_min,1)), "/min")
  } else {
    df[[8,2]] = NA
  }

  # percentiles start as NA
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
    
         if(min >0){
            df[[8,4]] = ecdf_fun(subset(eff, Aphasia==1)$AC_min, ac_min)
        } else {
          df[[8,4]] = NA
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
        # AC/min
        df[[8,5]] = ecdf_fun(subset(eff, Aphasia==0)$AC_min, ac_min)
    } else {
      df[[8,5]] = NA
    }
    
  } else {
    df$`Percentile (Aphasia)` = NA
    df$`Percentile (Control)` = NA
  }
  return(df)
}