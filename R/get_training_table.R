#' get training table function
#'
#' @param values 
#'
#' @return
#' @export
get_training_table <- function(dat_in){
  
  return(
    dat_in %>%
      dplyr::select(#Component = component,
                    Element,
                    `Your rating` = rating,
                    `Correct rating` = correct_rating,
                    Feedback = feedback) #%>%
      #dplyr::mutate(Component = as.character(Component))
  )
}