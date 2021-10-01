#' Generates results text for top of results page
#'
#' @param values values reactive
#' @param results results_mca_tab()
#'
#' @return some text to be put in a p() tag. 
#' @export

get_results_text <- function(results, num_concepts, time){
  
  report <- "Please download the report for a detailed explanation of these results."
  
  txt_acc <- glue::glue('
       
    The main concept score for this person is {results[1,3]}. This is in the {results[1,4]} percentile of PWAs and the {results[1,5]} percentile of controls. This individual produced {results[2,2]}/{num_concepts} accurate/complete main concepts, which is in the {results[2,4]} percentile of PWAs and the {results[2,5]} percentile of controls. This individual produced {results[3,2]}/{num_concepts} accurate/incomplete main concepts, {results[4,2]}/{num_concepts} inaccurate/complete main concepts, and {results[5,2]}/{num_concepts} inaccurate/incomplete main concepts. There were {results[7,2]}/{num_concepts} main concept attempts, which is in the {results[7,4]} percentile of PWAs and {results[7,5]} percentile of controls. Finally, {results[6,2]}/{num_concepts} main concepts were absent in this individual’s sample.  
    ')
  
  if(time > 0){ 
  txt_eff <- glue::glue('
    This individual produced {results[8,2]} main concepts/minute, which is in the {results[8,4]} percentile of PWAs and the {results[8,5]} percentile of controls.  
                  ')
  
  all_text <- paste(txt_acc, txt_eff, report)
  return(all_text)
  } else {
    return(paste(txt_acc, report))
  }

}
