# Package prep
# This is for running the analysis, not the cleaning.
source("./dep/package-prep-main.R")

# Data prep
# This has several additional packages used for cleaning, not needed to run the app.
df <- read_csv("data/merged_processed_data.csv")