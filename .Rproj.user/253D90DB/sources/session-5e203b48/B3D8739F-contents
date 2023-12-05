# This script combines all processed dataframes into one combined for better analysis and modeling
merged_data <- merge(covid_data, econ_char_data, by.x = c("year", "fips"), by.y = c("year", "geography"), all.x = TRUE)
