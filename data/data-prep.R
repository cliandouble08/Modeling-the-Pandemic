# Import packages from package-prep.R
source("dep/package-prep.R")

# Import data file
Sys.setenv(VROOM_CONNECTION_SIZE = 256000)

## Policy mapping
raw_policy <- read_csv("data/data-files/COVID Analysis and Mapping of Policies Data.csv", 
                       col_types = cols(
                         `Unique ID` = col_character(), 
                         `Authorizing local area (e.g., county, city) code` = col_character(), 
                         `Affected local area (e.g., county, city) code` = col_character(), 
                         .default = col_guess() # Guess the type for all other columns
                       ))
## COVID-19 cases/deaths
raw_covid <- read_csv("data/data-files/combined_covid.csv")

## Political PVI
raw_political_pvi <- read_csv("data/data-files/Cook PVI (116th Congressional Districts) by County.csv")

## Demographic data files
raw_children_characteristics <- read_csv("data/data-files/demographic/Children Characteristics 2020-21.csv")
raw_housing_estimatess <- read_csv("data/data-files/demographic/Demographic and Housing Estimates 2020-21.csv")
raw_economic_characteristics_2020 <- read_csv("data/data-files/demographic/economic-characteristics-2020.csv")
raw_economic_characteristics_2021 <- read_csv("data/data-files/demographic/economic-characteristics-2021.csv")
raw_education <- read_csv("data/data-files/demographic/Education Attainments 2020-21.csv")
raw_hpi <- read_csv("data/data-files/demographic/Housing Price Index (HPI) 2020-21.csv")
