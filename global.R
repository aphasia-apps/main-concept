library(shiny)
library(here)
library(shinyjs)
library(bslib)
library(tidyverse)
library(tokenizers)
library(shinyWidgets)
library(shinipsum)
library(googlesheets4)
library(openxlsx)

scoring_mca = tibble(
  Result = c("AC", "AI", "IC", "II", "Absent"),
  score = c(3, 2, 2, 1, 0)
)

mc_reference = tibble(
  num = c(8, 10, 10, 10, 34),
  prefix = c('bw', 'cr', 'u', 's', 'c'),
  name = c("broken_window", "cat_rescue", "refused_umbrella", "sandwich", "cinderella")
)

transcriptDefault <- "Young boy is practicing playing soccer. Kicking the ball up and keeping it in the air. He miskicks. It fall goes and breaks the window of his house. Of the living room actually. And bounces into the living room knocking a lamp over where his father is sitting. The father picks up the soccer ball. Looks out the window. And calls for the little boy to come and explain."

# broken window main concepts:
main_concepts <- read_csv("www/main_concepts.csv") %>%
  select(task:e4) %>%
  group_by(task) %>% mutate(id = row_number())

main_concepts$concept_length = 4-rowSums(is.na(main_concepts))

# global variable for styling html scoring info
sty = "background-color: #e9ecef; padding: 5px; margin-bottom: 5px; border-radius: 5px;font-size:1.25rem;"
#line-height: 160%;font-size:1.25rem; 

ecdf_fun <- function(x,perc) scales::label_percent()(ecdf(x)(perc))
