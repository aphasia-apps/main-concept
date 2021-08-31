
#' Get summary table
#'
#' @param results the data frame of results
#' @param norms the norms for the scored stimulus
#'
#' @return
#' @export
get_summary_table <- function(results, norms, scoring = "dalton_richardson"){
  
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
                                 'II')
    ) %>% 
    tidyr::pivot_longer(cols = everything(), names_to = 'Variable', values_to = 'Count') %>%
    dplyr::mutate(Count = as.character(Count))
  
  df$Points = NA
  #df[[1,3]] = round(as.numeric(df[1,2]))
  df[[1,2]] = NA
  df[[2,3]] = round(as.numeric(df[2,2])*vals$AC)
  df[[3,3]] = round(as.numeric(df[3,2])*vals$AI)
  df[[4,3]] = round(as.numeric(df[4,2])*vals$IC)
  df[[5,3]] = round(as.numeric(df[5,2])*vals$II)
  df[[6,3]] = round(as.numeric(df[6,2])*vals$absent)
  comp = sum(df[,3], na.rm = T)
  df[[1,3]] = round(as.numeric(comp))
  #df[[6,3]] = NA

  
  df$`Percentile (Aphasia)` = NA
  df$`Percentile (Control)` = NA
  
  if(scoring == "dalton_richardson"){
    # aphasia norms
    df[[1,4]] = ecdf_fun(subset(norms, Aphasia==1)$`MC COMPOSITE`, as.numeric(df[1,3]))
    df[[2,4]] = ecdf_fun(subset(norms, Aphasia==1)$AC, as.numeric(df[2,2]))
    #df[[3,4]] = ecdf_fun(subset(norms, Aphasia==1)$AI, as.numeric(df[3,2]))
    #df[[4,4]] = ecdf_fun(subset(norms, Aphasia==1)$IC, as.numeric(df[4,2]))
    #df[[5,4]] = ecdf_fun(subset(norms, Aphasia==1)$II, as.numeric(df[5,2]))
    #df[[6,4]] = ecdf_fun(subset(norms, Aphasia==1)$AB, as.numeric(df[6,2]))
    df[[7,4]] = ecdf_fun(subset(norms, Aphasia==1)$`MC Attempts`, as.numeric(df[7,2]))
    # control norms
    df[[1,5]] = ecdf_fun(subset(norms, Aphasia==0)$`MC COMPOSITE`, as.numeric(df[1,3]))
    df[[2,5]] = ecdf_fun(subset(norms, Aphasia==0)$AC, as.numeric(df[2,2]))
    #df[[3,5]] = ecdf_fun(subset(norms, Aphasia==0)$AI, as.numeric(df[3,2]))
    #df[[4,5]] = ecdf_fun(subset(norms, Aphasia==0)$IC, as.numeric(df[4,2]))
    #df[[5,5]] = ecdf_fun(subset(norms, Aphasia==0)$II, as.numeric(df[5,2]))
    #df[[6,5]] = ecdf_fun(subset(norms, Aphasia==0)$AB, as.numeric(df[6,2]))
    df[[7,5]] = ecdf_fun(subset(norms, Aphasia==0)$`MC Attempts`, as.numeric(df[7,2]))
  } else {
    df$`Percentile (Aphasia)` = NA
    df$`Percentile (Control)` = NA
  }
  return(df)
}