# Package prep
# This is for running the analysis, not the cleaning.
source("./dep/package-prep-main.R")

# Data prep
df <- read_csv("data/data-files/merged_processed_data.csv") %>% 
  mutate(fips = as.character(fips))

county_census_updated <- county_census %>% 
  select(FIPS, POPESTIMATE2019) %>% 
  mutate(FIPS = as.character(FIPS))

df_updated <- merge(x = county_census_updated, 
                    y = df, 
                    by.x = "FIPS", 
                    by.y = "fips")

df_use <- df_updated %>% 
  select(-c(county, state, month_day)) %>% 
  mutate(
    deaths_per_1e6 = deaths / POPESTIMATE2019
      ) %>% 
  rename(
    case_fatality_rate = cfr
  )