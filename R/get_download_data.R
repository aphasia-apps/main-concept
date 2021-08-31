
#' get_download_data
#'
#' @param x score
#' @param perc percent
#'
#' @return
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