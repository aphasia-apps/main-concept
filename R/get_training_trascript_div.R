




#' get training transcript
#'
#' @param module_num 
#'
#' @export
get_training_trascript_div <- function(module_num){
  
  get_file = paste0("app/www/","module", module_num, ".md")
  
  return(
    div(
      includeMarkdown(system.file(get_file, package = "mainConcept"))
    )
  )
}