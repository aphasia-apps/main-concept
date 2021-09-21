
#' get plot
#' 
#' function to build the plot for the results page
#'
#' @param norms norms pulled from googlesheets or static if not accessed 
#' @param current_score the total score
#' @param stim which stimulus was scored
#' @param scoring scoring
#' @param norm_var norm_var
#' @param basesize base size of plot
#'
#' @return a density plot 
#' @export
get_plot_report <-
  function(norms,
           current_score,
           stim,
           scoring = "dalton_richardson",
           norm_var,
           basesize) {
    
    # each of these will be based on the variable chosen in the radiogroupbuttons
    # below the plot. 
    
    # composite score
    if (norm_var == "MC COMPOSITE") {
      vert_line <- current_score[1]
      xlabel <- "Composite Score"
      
      dat = norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = max(dat$score)
      
    # Accurate complete concepts
    } else if (norm_var == "AC") {
      vert_line <- current_score[2]
      xlabel <- "Number of Accurate Complete Concepts"
      
      dat = norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = max(dat$score)
      
    # number of attempts
    } else if (norm_var == "MC Attempts") {
      vert_line <- current_score[3]
      xlabel <- "Number of Attempts"
      
      dat = norms %>%
        dplyr::mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
        dplyr::rename(score = norm_var)
      
      val = max(dat$score)
  
      # AC per minute. 
    } else if (norm_var == "AC_min") {
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
    
    
    
    # this is the actual plot. 
    p = dat %>%
      ggplot2::ggplot(ggplot2::aes(x = score, fill = group, group = group)) +
      # ggplot2::geom_density(alpha = .5) + # this is below. 
      ggplot2::geom_vline(
        ggplot2::aes(xintercept = vert_line),
        color = "darkred",
        linetype = "dashed",
        size = 1.5
      ) +
      ggplot2::theme_minimal(base_size = basesize) +
      ggplot2::scale_x_continuous(limits = c(0, val),
                                  breaks = seq(0, val, 2)) +
      ggplot2::theme(
        axis.text.y = ggplot2::element_blank(),
        axis.ticks.y = ggplot2::element_blank(),
        legend.position = "none"
      ) +
      ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B")) +
      ggplot2::labs(y = NULL, x = xlabel,
                    #caption = "Dashed red line indicates current score",
                    fill = NULL)
    
    # if kong gets selected, no more density plot, because no norms...
    if (scoring == "dalton_richardson") {
      p = p +
        ggplot2::geom_density(alpha = .5)
      
    }
    
    return(p)
    
  }
