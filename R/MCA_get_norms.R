
#' Get Norms
#'
#' @param stimulus which stimulus was chosen
#' @description Note that if googlesheets fails, static norms will be used. 
#' @return
#' @export
get_norms <- function(stimulus){

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
    norms$acc = static_norms %>%
             dplyr::filter(stim==stimulus)
  } 
    
  
  return(norms)
  

}





# update_static_norms <- function() {
#   load(here::here("R", "sysdata.rda"))
#   refused_umbrella = get_norms("refused_umbrella")
#   cat_rescue = get_norms("cat_rescue")
#   cinderella = get_norms("cinderella")
#   sandwich = get_norms("sandwich")
#   broken_window = get_norms("broken_window")
# 
#   static_norms <- dplyr::bind_rows(tibble::lst(refused_umbrella$acc, cat_rescue$acc,
#                                                cinderella$acc, sandwich$acc, broken_window$acc),
#                                    .id = "stim") %>%
#                   dplyr::mutate(stim = stringr::str_remove(stim, "[$]acc"))
#   eff_norms <- dplyr::bind_rows(tibble::lst(refused_umbrella$eff, cat_rescue$eff,
#                                             cinderella$eff, sandwich$eff, broken_window$eff),
#                                 .id = "stim") %>%
#     dplyr::mutate(stim = stringr::str_remove(stim, "[$]eff"))
#   usethis::use_data(static_norms, eff_norms, main_concepts, mc_reference,scoring_mca, transcriptDefault, sty, internal = T, overwrite = T)
# 
# }
