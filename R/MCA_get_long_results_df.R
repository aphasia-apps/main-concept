#'Get long results data
#' 
#' @param concept_accuracy current concept scores
#'
#' @param filtered_concepts data of concepts relevant to the stimulus
#' 
#' @return a long dataframe of results
#'
#' @export
#' 
get_long_results_df <- function(concept_accuracy, filtered_concepts){
  df <- 
    dplyr::bind_rows(concept_accuracy) %>%
    dplyr::left_join(filtered_concepts, by = c('concept', 'component')) %>%
    tidyr::drop_na(element) %>%
    dplyr::group_by(concept) %>%
    dplyr::summarize(absent = sum(as.numeric(rating == "Absent")),
              accurate = sum(as.numeric(rating == "Accurate")),
              inaccurate = sum(as.numeric(rating == "Inaccurate"))) %>%
    dplyr::mutate(
      accuracy = dplyr::case_when(
        inaccurate > 0 ~ "I",
        accurate > 0 ~ "A",
        TRUE ~ "Absent"
      ),
      completeness = dplyr::case_when(
        absent > 0 ~ "I",
        absent == 0 ~ "C",
        TRUE ~ "missed"
      )
    ) %>%
    dplyr::mutate(completeness = ifelse(accuracy == "Absent", "", completeness)) %>%
    tidyr::unite(col = "Result", accuracy, completeness, sep = "", remove = F) %>%
    dplyr::left_join(scoring_mca, by = "Result")
  
  return(df)
}