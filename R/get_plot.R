
#' get plot
#'
#' @param norms norms pulled from googlesheets or static if not accessed 
#' @param current_score the total score
#' @param stim which stimulus was scored
#' @param scoring scoring
#' @param norm_var norm_var
#' @param basesize base size not working
#'
#' @return a density plot 
#' @export
get_plot <- function(norms, current_score, stim, scoring = "dalton_richardson", norm_var, basesize){
  
  #val = subset(mc_reference, name == stim)$num 
  #max_val = val*3
  
    if(norm_var == "MC COMPOSITE"){
      vert_line <- current_score[1]
      xlabel <- "Composite Score"
      
      dat = norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = max(dat$score)
      
    } else if (norm_var == "AC"){
      vert_line <- current_score[2]
      xlabel <- "Number of Accurate Complete Concepts"
      
      dat = norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = max(dat$score)
      
    } else if (norm_var == "MC Attempts"){
      vert_line <- current_score[3]
      xlabel <- "Number of Attempts"
      
      dat = norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = max(dat$score)
      
    # } else if (norm_var == "COMP_min"){
    #   vert_line <- current_score[4]
    #   xlabel <- "Composite/min (TO BE DELETED)"
    #   
    #   dat = eff_norms %>%
    #     dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
    #     dplyr::rename(score = norm_var)
    #   
    #   val = quantile(dat$score, probs = .97)
    #   
    } else if (norm_var == "AC_min"){
      vert_line <- current_score[4]
      xlabel <- "Accurate Complete concepts/minute"
      
      dat = eff_norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = quantile(dat$score, probs = .97)
      
    } else {
      vert_line <- 0
      xlabel <- ""
    }

  
  

  p = dat %>%
    ggplot2::ggplot(ggplot2::aes(x=score, fill = group, group = group)) +
    # ggplot2::geom_density(alpha = .5) +
    ggplot2::geom_vline(ggplot2::aes(xintercept = vert_line), color = "darkred", linetype = "dashed", size = 1.5) +
    ggplot2::theme_minimal(base_size = basesize) +
    ggplot2::scale_x_continuous(
      limits = c(0,val),
      breaks = seq(0,val, 2)) +
    ggplot2::theme(
          axis.text.y=ggplot2::element_blank(),
          axis.ticks.y = ggplot2::element_blank(),
          legend.position = c(0.87, 0.15),
          legend.background = ggplot2::element_rect(fill = scales::alpha("white", 0.75), color = "black")) +
    ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B")) +
    ggplot2::labs(y=NULL, x=xlabel,
                  #caption = "Dashed red line indicates current score",
                  fill = NULL)
  
  if(scoring == "dalton_richardson"){
    p = p + 
      ggplot2::geom_density(alpha = .5)
      
  }
    
  return(p)

}


