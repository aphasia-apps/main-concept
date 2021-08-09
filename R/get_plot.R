
#' get plot
#'
#' @param norms norms pulled from googlesheets or static if not accessed 
#' @param current_score the total score
#' @param stim which stimulus was scored
#'
#' @return a density plot 
#' @export
get_plot <- function(norms, current_score, stim){
  
  val = subset(mc_reference, name == stim)$num 
  max_val = val*3
  
  dat = norms %>%
    dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
    dplyr::rename(score = `MC COMPOSITE`)

  p = dat %>%
    ggplot2::ggplot(aes(x=score, fill = group, group = group)) +
    ggplot2::geom_density(alpha = .3) +
    ggplot2::theme_minimal(base_size = 14) +
    ggplot2::geom_vline(aes(xintercept = current_score), color = "darkred", linetype = "dashed") +
    ggplot2::scale_x_continuous(limits = c(0,max_val), breaks = seq(0,max_val, 2)) +
    ggplot2::theme(axis.text.y=ggplot2::element_blank(),
          axis.ticks.y = ggplot2::element_blank()) +
    ggplot2::labs(y=NULL, x="Composite Score")
  
  return(p)

}


