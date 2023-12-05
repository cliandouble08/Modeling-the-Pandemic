# Select rows that have 5 digits in affected_area_code column (counties)
county_policy <- policy_data %>% 
  filter(nchar(as.character(affected_local_code)) == 5)
