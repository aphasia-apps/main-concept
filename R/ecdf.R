
#' Ecdf function
#'
#' @param x score
#' @param perc percent
#'
#' @return
#' @export
ecdf_fun <- function(x,perc){
    scales::label_percent()(stats::ecdf(x)(perc))
}
