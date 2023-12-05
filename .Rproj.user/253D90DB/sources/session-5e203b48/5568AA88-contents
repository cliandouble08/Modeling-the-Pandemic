# List of required packages
required_packages <- c("broom", "ggplot2", "leaflet", "dplyr", "readr",  
                       "stringr", "tmaptools", "tmap", "sf", "lubridate", "maps", 
                       "gtable", "fastDummies", "purrr", "tidyr", 
                       "reshape2", "mosaic", "shiny", "leaflet", "doParallel", "gganimate", 
                       "purrr", "viridis", "transformr", "tigris")

# Function to install missing packages
install_missing_packages <- function(packages) {
  installed <- rownames(installed.packages())
  for (package in packages) {
    if (!package %in% installed) {
      install.packages(package)
    }
  }
}

# Install any missing packages
install_missing_packages(required_packages)

# Load the packages into the environment
for (package in required_packages) {
  library(package, character.only = TRUE, 
          quietly = TRUE)
}