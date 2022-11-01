
#' Ecdf function
#'
#' @param x score
#' @param perc percent
#' @export
ecdf_fun <- function(x,perc){
    scales::label_percent()(stats::ecdf(x)(perc))
}
