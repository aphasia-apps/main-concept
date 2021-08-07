# get_concepts <- function(concept){
#   tb = tb %>%
#     filter(name == concept)
#   
#   l = tagList()
#   for(i in 1:tb[[1,1]]){
#     l[[i]] =  HTML(paste0(get(paste0(tb[[1,2]], i)), "<hr>"))
#   }
#   return(l)
#   
# }