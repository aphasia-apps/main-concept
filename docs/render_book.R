library(here)
setwd(here("docs"))
bookdown::render_book("index.Rmd", output_dir = here("docs"))
