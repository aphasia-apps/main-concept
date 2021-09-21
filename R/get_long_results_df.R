#'Get long results data
#'
#' gets long results for calculating stuff and for downloading data.
#' THIS IS A HUGELY IMPORTANT FUNCTION FOR CALCULATING THE RESULTS!!! 
#' 
#' @param concept_accuracy current concept scores
#' @param filtered_concepts data of concepts relevant to the stimulus
#' 
#' @return a long dataframe of results
#'
#' @export
#' 
get_long_results_df <- function(concept_accuracy, filtered_concepts){
  df <- 
    # start with concept_accuracy table
    dplyr::bind_rows(concept_accuracy) %>%
    dplyr::left_join(filtered_concepts, by = c('concept', 'component')) %>%
    tidyr::drop_na(element) %>%
    dplyr::group_by(concept) %>%
    # this counts up the numberof codes into the three main buckets. 
    dplyr::summarize(absent = sum(as.numeric(rating == "Absent")),
              accurate = sum(as.numeric(rating == "Accurate")),
              inaccurate = sum(as.numeric(rating == "Inaccurate"))) %>%
    # this is a super important bit
    # calculating accuracy goes like this
    # if there are at least one inaccurate rating for a concept, then give an I
    # if not, and there are at least 1 accurate for a concept, given an A
    # if neither of those conditions are met. then its absent. 
    dplyr::mutate(
      accuracy = dplyr::case_when(
        inaccurate > 0 ~ "I",
        accurate > 0 ~ "A",
        TRUE ~ "Absent"
      ),
      # for completeness, 
      # if there are any absent codes, then its incomplete
      # if there are none, then it is complete. 
      completeness = dplyr::case_when(
        absent > 0 ~ "I",
        absent == 0 ~ "C",
        TRUE ~ "missed"
      )
    ) %>%
    # converts completeness to nothing if the entire concept is absent
    dplyr::mutate(completeness = ifelse(accuracy == "Absent", "", completeness)) %>%
    # combines accuracy and completeness. 
    tidyr::unite(col = "Result", accuracy, completeness, sep = "", remove = F) %>%
    # combines with the static, imported scoring_ma file to finish off the table. 
    dplyr::left_join(scoring_mca, by = "Result")
  
  return(df)
}