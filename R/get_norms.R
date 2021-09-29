
#' Get Norms
#' 
#' gets normative data from google sheets, or just uses a locally stored
#' version that has to be updated manually
#'
#' @param google_sheets should the functionget norms from google sheets? 
#' @param stimulus which stimulus was chosen
#'
#' @description Note that if googlesheets fails, static norms will be used. 
#' @return
#' @export
get_norms <- function(stimulus, google_sheets = F){
  
  if(!isTruthy(google_sheets)){
    
    norms = list(
      acc = acc_norms %>% dplyr::filter(stim==stimulus),
      eff = eff_norms %>% dplyr::filter(stim == stimulus)
    )
    
    return(norms)
  } else {

  # links to google sheets for norms:
  refused_umbrella = "1oYiwnUdO0dOsFVTmdZBCxkAQc5Ui-71GhUSchK_YY44"
  broken_window = "12SAkAG8VCAkhCFv4ceJiqgRZ7U9-P9bEcet--hDeW2s"
  cinderella = "1fpDq7aTrKVkfjdv8ka7BS5_iHEJ8HHI-q9nJI6wDAEA"
  sandwich = "1o29bBQbyNlmtL05kkTuLV6z5auz1msDeLSxIO1p_3EA"
  cat_rescue = "1sTvSX0Ws0kPTw-5HHyY8JO2CubqWVgEzDvE5BuGSefc"

  # go into deauth mode
  googlesheets4::gs4_deauth()
  
  acc <- tryCatch(
    googlesheets4::read_sheet(ss = get(stimulus), sheet = 1),
          error = function(e) "Unable to connect; using norms updated 8/1/21"
        )
  
  norms = list(
    acc = acc,
    eff = eff_norms %>% dplyr::filter(stim == stimulus)
  )

  if(is.character(acc)){
    norms$acc = acc_norms %>%
             dplyr::filter(stim==stimulus)
  } 
    
  
  return(norms)
  }
  

}



# This is code to update the static norms...

# update_acc_norms <- function() {
#   refused_umbrella = get_norms("refused_umbrella")
#   cat_rescue = get_norms("cat_rescue")
#   cinderella = get_norms("cinderella")
#   sandwich = get_norms("sandwich")
#   broken_window = get_norms("broken_window")
# 
#   acc_norms <- dplyr::bind_rows(tibble::lst(refused_umbrella$acc, cat_rescue$acc,
#                                                cinderella$acc, sandwich$acc, broken_window$acc),
#                                    .id = "stim") %>%
#                   dplyr::mutate(stim = stringr::str_remove(stim, "[$]acc"))
# 
#   return(
#     acc_norms
#   )
#   
# }
# 
# acc_norms <- update_acc_norms()
# 
# load(here::here("R", "sysdata.rda"))
# # make sure this is up to date...
# usethis::use_data(
#   answers,
#   elements,
#   keys,
#   main_concepts,
#   mc_reference,
#   scoring_mca,
#   transcriptDefault,
#   sty,
#   # norms
#   eff_norms,
#   acc_norms,
#   #other args
#   internal = T,
#   overwrite = T
#   )
