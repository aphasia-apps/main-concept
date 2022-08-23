
#' Footer function
#' @description Function to return the footer. Buttons hidden unless scoring. 
#' @return
#' @export
footer_div <- function() {
  tagList(
    shinyjs::hidden(
      column(
        12,
        align = "center",
        style = "background-color: white; padding-bottom: 15px;",
        id = "footer_buttons",
        actionButton(
          "prev",
          label = "Previous",
          icon = icon('arrow-left'),
          width = "20%"
        ),
        actionButton(
          "nxt",
          label = "Next",
          icon = icon('arrow-right'),
          width = "20%"
        )
      )
    )
  )
}
