# # make answers to training modules
# load("~/Documents/github-repos/mainConcept/R/sysdata.rda")
# 
# # elements <- main_concepts %>% dplyr::select(task:e3, id) %>% tidyr::pivot_longer(cols = 2:4, names_to = "component", values_to = "Element") %>% dplyr::mutate(component = as.numeric(str_remove(component, "e"))) %>% dplyr::rename(concept = id)
# 
# 
# training_transcript1 <- "Okay. I’ve done this before. He kicked the ball. It went and went through the glass. It’s his dad sitting in the the couch. It’s not good."
# 
# txt = stringr::str_trim(unlist(strsplit(training_transcript1, "(?<=\\.)", perl = T)))
# 
# key1 <- c("none", txt[3], txt[4], txt[5], "none", "none", "none", "none")
# 
# training_transcript2 <- "Okay. He kicking ball. And the lamp it hits. Man yelled."
# 
# txt = stringr::str_trim(unlist(strsplit(training_transcript2, "(?<=\\.)", perl = T)))
# 
# key2 <- c("none", txt[2], "none", "none", "none", txt[3], "none", txt[4])
# 
# training_transcript3 <- "Looks like the problem is the cat is stuck up in a tree. Father is out on the and. he's kind of stuck himself I think. The little girl is crying for the cat. She's got an umbrella. There's a guy up in the or. a dog barking up the tree. And the fire department is coming. A little girl was trying to reach him I guess. I don't know if she was trying to get this ladder or not. I have no idea about that. But anyway the firemen are coming. The fire truck is there. And they're coming out with a ladder apparently to help get the cat and father out of the tree."
# 
# txt = stringr::str_trim(unlist(strsplit(training_transcript3, "(?<=\\.)", perl = T)))
# 
# key3 <- c("none", txt[1], txt[7], "none", "none", "none", txt[3], "none", txt[14], txt[14])
# 
# keys <- list(key1, key2, key3)
# 
# 
# #
# # usethis::use_data(internal = T, overwrite = T, answers, eff_norms, main_concepts,
# #                   mc_reference, scoring_mca, acc_norms, sty, transcriptDefault, elements, keys,
# #                   training_transcript1, training_transcript2, training_transcript3)
