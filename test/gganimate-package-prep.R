# List of required packages
required_packages <- c("readr", "ggplot2", "tigris", "viridis", "dplyr")

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