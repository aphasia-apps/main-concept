
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
    ggplot2::ggplot(ggplot2::aes(x=score, fill = group, group = group)) +
    ggplot2::geom_density(alpha = .5) +
    ggplot2::theme_minimal(base_size = 14) +
    ggplot2::geom_vline(ggplot2::aes(xintercept = current_score), color = "darkred", linetype = "dashed", size = 1.5) +
    ggplot2::scale_x_continuous(limits = c(0,max_val), breaks = seq(0,max_val, 2)) +
    ggplot2::theme(
          axis.text.y=ggplot2::element_blank(),
          axis.ticks.y = ggplot2::element_blank(),
          legend.position="bottom") +
    ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B")) +
    ggplot2::labs(y=NULL, x="Composite Score", caption = "Dashed red line indicates current score", fill = NULL)
  
  return(p)

}


