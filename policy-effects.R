library(dplyr)
library(lubridate)

# Assuming policy_data is already loaded

# Standardize affected_local_code format
policy_data$affected_local_code <- sprintf("%05d", as.integer(policy_data$affected_local_code))

# Filter data for analysis
local_policy <- policy_data %>% 
  filter(policy_category %in% c("Social distancing", "Face mask"), 
         nchar(as.character(affected_local_code)) == 5, 
         affected_level_gov == "Local")

# Check if local_policy is not empty
if (nrow(local_policy) == 0) {
  stop("No rows in local_policy. Check filter conditions.")
}

# Date formatting
local_policy$issued_date <- ymd(local_policy$issued_date)
local_policy$start_date <- ymd(local_policy$start_date)
local_policy$actual_end_date <- ymd(local_policy$actual_end_date)
local_policy$anticipated_end_date <- ymd(local_policy$anticipated_end_date)

# Create a summary dataframe for policy
years <- c(2020, 2021, 2022, 2023)
months <- 1:12
date_grid <- expand.grid(year = years, month = months)
unique_local_codes <- unique(local_policy$affected_local_code)
local_codes_df <- data.frame(affected_local_code = unique_local_codes)
expanded_date_grid <- full_join(date_grid, local_codes_df, by = character(0))

# Initialize columns for policy effect, type and category counts
expanded_date_grid$Restricting <- 0
expanded_date_grid$Other <- 0
expanded_date_grid$Relaxing <- 0
expanded_date_grid$NA_Type <- 0
expanded_date_grid$Social_Distancing <- 0
expanded_date_grid$Face_Mask <- 0

# Loop through each row in local_policy
for (i in 1:nrow(local_policy)) {
  policy_row <- local_policy[i, ]
  start_date <- policy_row$start_date
  end_date <- policy_row$actual_end_date
  local_code <- policy_row$affected_local_code
  policy_type <- policy_row$policy_type
  policy_category <- policy_row$policy_category
  
  for (j in 1:nrow(expanded_date_grid)) {
    date_row <- expanded_date_grid[j, ]
    year_month_start <- as.Date(paste(date_row$year, date_row$month, "01", sep = "-"))
    year_month_end <- ceiling_date(year_month_start, "month") - days(1)
    
    if (!is.na(end_date) && !is.na(start_date) && !(end_date < year_month_start || start_date > year_month_end)) {
      summary_index <- which(expanded_date_grid$affected_local_code == local_code & 
                               expanded_date_grid$year == date_row$year & 
                               expanded_date_grid$month == date_row$month)
      
      if (length(summary_index) == 1) {
        if(policy_type == "Relaxing") {
          expanded_date_grid[summary_index, "Relaxing"] <- expanded_date_grid[summary_index, "Relaxing"] + 1
        } else if(policy_type == "Restricting") {
          expanded_date_grid[summary_index, "Restricting"] <- expanded_date_grid[summary_index, "Restricting"] + 1
        } else if(is.na(policy_type)) {
          expanded_date_grid[summary_index, "NA_Type"] <- expanded_date_grid[summary_index, "NA_Type"] + 1
        } else {
          expanded_date_grid[summary_index, "Other"] <- expanded_date_grid[summary_index, "Other"] + 1
        }
        
        if(policy_category == "Face mask") {
          expanded_date_grid[summary_index, "Face_Mask"] <- expanded_date_grid[summary_index, "Face_Mask"] + 1
        } else if(policy_category == "Social distancing") {
          expanded_date_grid[summary_index, "Social_Distancing"] <- expanded_date_grid[summary_index, "Social_Distancing"] + 1
        }
      }
    }
  }
}

# Final summary dataframe
local_policy_summary <- expanded_date_grid
