#' get training table function
#' 
#' outputs the training table with ansswers and feedback for the modal
#'
#' @param dat_in data going into the table
#' @param hide_answers should answers (a column) be hidden?
#'
#' @return
#' @export
get_training_table <- function(dat_in, hide_answers = T){
  
  dat_out <- dat_in %>%
    dplyr::select(#Component = component,
      Element,
      `Your rating` = rating,
      `Correct rating` = correct_rating,
      Feedback = feedback) 
  
  if(isTruthy(hide_answers)){
    dat_out <- dat_out %>%
      dplyr::select(-3)
  }
  return(
    dat_out
  )
}