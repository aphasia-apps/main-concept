
#' get_download_data
#' 
#' organizes data for downloading
#'
#' @param current_tab current navbar tab selected
#' @param values all the values and stuff
#' @param results_tab the table from the results page
#'
#' @return a list of data that goes into writeexcel (list elements to tabs)
#' @export
get_download_data <- function(current_tab, values, results_tab){
  dat = list(
    transcript = tibble::tibble(
      transcript = values$transcript
    ),
    by_concept = values$results_mca,
    by_component = dplyr::bind_rows(values$concept_accuracy)
  )
  
  if(current_tab == "results"){
    dat$summary_scores = results_tab
  }
  return(dat)
}