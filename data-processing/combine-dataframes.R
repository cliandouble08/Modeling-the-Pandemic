# Combined dataframes: 

# COVID cases/deaths & Policy
merged_df <- merge(covid_data, summary_policy_data, 
                   by.x = c("year", "month", "fips"), 
                   by.y = c("policy_year", "policy_month", "affected_local_code"))

# Merged & Education
merged_df <- merge(merged_df, education_df, 
                   by.x = "fips", 
                   by.y = "GEOID")

# Merged & Economics
merged_df <- merge(merged_df, econ_char_data, 
                   by.x = c("year", "fips"), 
                   by.y = c("year", "geography"))

# Export merged_df into a csv file
write.csv(merged_df, 
          file = "merged_processed_data.csv", 
          row.names = FALSE)