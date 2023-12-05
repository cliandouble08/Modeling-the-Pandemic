education_df$GEOID <- sprintf("%05d", as.integer(education_df$GEOID))

working_combined <- education_df %>% 
  left_join(working_covid, by = c("GEOID" = "fips")) %>% 
  select_if(is.numeric)

working_lm <- lm(max_cfr ~ ., data = working_combined)
working_stepwise <- step(working_lm)
