
get_norms <- function(stimulus){

# links to google sheets for norms:
refused_umbrella = "1oYiwnUdO0dOsFVTmdZBCxkAQc5Ui-71GhUSchK_YY44"
broken_window = "12SAkAG8VCAkhCFv4ceJiqgRZ7U9-P9bEcet--hDeW2s"
cinderella = "1fpDq7aTrKVkfjdv8ka7BS5_iHEJ8HHI-q9nJI6wDAEA"
sandwich = "1o29bBQbyNlmtL05kkTuLV6z5auz1msDeLSxIO1p_3EA"
cat_rescue = "1sTvSX0Ws0kPTw-5HHyY8JO2CubqWVgEzDvE5BuGSefc"

# go into deauth mode
gs4_deauth()

norms = read_sheet(ss = get(stimulus))
#norms <- read_csv(here("data", "test_norms.csv"))
return(norms)

}