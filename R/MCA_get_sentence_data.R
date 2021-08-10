
#' Get sentence data
#'
#' @param rds_list a list sentences
#'
#' @return
#' @export
get_sentence_data <- function(rds_list){
  a = rds_list
  newlist = list()
  for(i in 1:length(a)){
    
    newlist[[i]] = expand_grid(
      concept = i,
      sentences = unlist(a[[i]])
      
    )
  }
  return(dplyr::bind_rows(newlist))
}

