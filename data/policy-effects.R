# Fill FIPS code with leading zeros removed
policy_data$affected_local_code <- sprintf("%05d", as.integer(policy_data$affected_local_code))

updated_policy_data <- policy_data

# Convert date columns to Date format
updated_policy_data$start_date <- as.Date(updated_policy_data$start_date)
updated_policy_data$actual_end_date <- as.Date(updated_policy_data$actual_end_date)

# Function to split policies
split_policy <- function(start_date, end_date) {
  if (is.na(start_date) || is.na(end_date)) {
    return(data.frame(policy_year = NA, policy_month = NA))
  }
  
  start_year <- as.character(as.numeric(format(start_date, "%Y")))
  start_month <- as.character(as.numeric(format(start_date, "%m")))
  end_year <- as.character(as.numeric(format(end_date, "%Y")))
  end_month <- as.character(as.numeric(format(end_date, "%m")))
  
  if (is.na(start_year) || is.na(start_month) || is.na(end_year) || is.na(end_month)) {
    return(data.frame(policy_year = NA, policy_month = NA))
  }
  
  if (start_year == end_year && start_month == end_month) {
    return(data.frame(policy_year = start_year, policy_month = start_month))
  } else if (end_date < start_date) {
    return(data.frame(policy_year = NA, policy_month = NA))
  } else {
    months <- seq.Date(start_date, end_date, by = "1 month")
    years <- format(months, "%Y")
    months <- format(months, "%m")
    return(data.frame(policy_year = years, policy_month = months))
  }
}

# Apply the function and unnest the resulting data frame
updated_policy_data <- updated_policy_data %>%
  mutate(policy_years_months = map2(start_date, actual_end_date, split_policy)) %>%
  unnest(policy_years_months)
write.csv(updated_policy_data, 
          file = "data/data-files/raw_policy_data.csv", 
          row.names = FALSE)

# Create a summary dataframe
# Filter the data to include only the relevant policies 
filtered_policy_data <- updated_policy_data %>% 
  filter(policy_type %in% c("Restricting", "Other", "Relaxing", NA) &
           policy_category %in% c("Social distancing", "Face mask"))

# Group the data by policy_year, policy_month, and affected_local_code
# Create the summary dataframe for policy_type and policy_category
summary_policy_data <- filtered_policy_data %>%
  group_by(policy_year, policy_month, affected_local_code) %>%
  summarize(
    type_restricting = sum(policy_type == "Restricting", na.rm = TRUE),
    type_other = sum(policy_type == "Other", na.rm = TRUE),
    type_relaxing = sum(policy_type == "Relaxing", na.rm = TRUE),
    type_NA = sum(is.na(policy_type)),
    category_social_distancing = sum(policy_category == "Social distancing", na.rm = TRUE),
    category_face_mask = sum(policy_category == "Face mask", na.rm = TRUE)
  ) %>%
  ungroup()

# Remove policies with unknown affected_local_code
summary_policy_data <- summary_policy_data %>% 
  filter(!is.na(affected_local_code), 
         !grepl("NA", affected_local_code, fixed = TRUE))