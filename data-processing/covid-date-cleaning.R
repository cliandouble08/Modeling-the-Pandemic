# Read in the data file
raw_covid <- read_csv("data/combined_covid.csv") 
raw_covid$fips <- sprintf("%05d", as.integer(raw_covid$fips))

# Select years of 2020 and 2021
covid_data <- raw_covid %>% 
  mutate(cfr = deaths / cases) %>% 
  separate(month_day, into = c("month", "day"), 
           sep = "-", remove = FALSE)
  # filter(year == 2020 | year == 2021)

# Create a new dataframe for demographic variable selection
working_covid <- covid_data %>% 
  filter(year == 2021) %>% 
  group_by(fips) %>% 
  summarize(max_cfr = max(cfr))
