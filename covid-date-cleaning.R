# Read in the data file
raw_covid <- read_csv("data/combined_covid.csv") 
raw_covid$fips <- sprintf("%05d", as.integer(raw_covid$fips))

# Select years of 2020 and 2021
covid_data <- raw_covid %>% 
  filter(year == 2020 | year == 2021)