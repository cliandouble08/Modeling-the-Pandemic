# Clean variable names
policy_data <- raw_policy %>%
  rename(
    id = `Unique ID`,
    auth_level_gov = `Authorizing level of government`,
    auth_country = `Authorizing country name`,
    auth_country_iso = `Authorizing country ISO`,
    auth_state_province = `Authorizing state/province, if applicable`,
    auth_local_area = `Authorizing local area (e.g., county, city)`,
    auth_local_code = `Authorizing local area (e.g., county, city) code`,
    auth_role = `Authorizing role (e.g., official with authority)`,
    auth_body = `Authorizing body (e.g., agency, office)`,
    official_name = `Name of official, if relevant`,
    affected_level_gov = `Affected level of government`,
    affected_country = `Affected country name`,
    affected_country_iso = `Affected country ISO`,
    affected_state_province = `Affected state/province (intermediate area)`,
    affected_local_area = `Affected local area (e.g., county, city)`,
    affected_local_code = `Affected local area (e.g., county, city) code`,
    policy_type = `Policy relaxing or restricting`,
    policy_category = `Policy category`,
    policy_subcategory = `Policy subcategory`,
    policy_target = `Policy target`,
    policy_description = `Policy description`,
    issued_date = `Issued date`,
    start_date = `Effective start date`,
    anticipated_end_date = `Anticipated end date`,
    actual_end_date = `Actual end date`,
    intended_duration = `Intended duration`,
    prior_row_id = `Prior row ID linked to this entry`,
    policy_announcement_source = `Data source for policy announcement`,
    policy_law_name = `Policy/law name`,
    policy_law_type = `Policy/law type`,
    law_policy_source = `Data source for law/policy`,
    pdf_name = `PDF file name of law/policy`,
    policy_attachment = `Attachment for policy`,
    policy_number = `Policy number`,
    auth_entity_authority = `Authorizing entity has authority?`,
    relevant_authority = `Relevant authority (e.g., statute) to make the law/policy`,
    authority_source = `Data source for authority to make the law/policy`,
    home_rule_state = `Home rule state?`,
    dillon_rule_state = `Dillon's Rule State`
  ) %>%  
  subset(auth_country_iso == "USA") %>% 
  select(id, auth_level_gov, auth_state_province, auth_local_area, auth_local_code, 
         affected_level_gov, affected_state_province, affected_local_area, affected_local_code, 
         policy_type, policy_category, policy_subcategory, policy_target, policy_description, 
         issued_date, start_date, anticipated_end_date, actual_end_date, 
         policy_announcement_source, policy_law_name, law_policy_source, 
         home_rule_state, dillon_rule_state) %>% 
  filter(
    !(auth_state_province == "Alaska" | affected_state_province == "Alaska" |
        auth_state_province == "Hawaii" | affected_state_province == "Hawaii")
  ) 

# Split rows with multiple affected local areas/codes
policy_data <- policy_data %>% 
  separate_rows(affected_local_area, affected_local_code, 
                sep = ";\\s*")

# Split rows with multiple authorizing/affected state and province
policy_data <- policy_data %>% 
  separate_rows(affected_state_province, auth_state_province,
                sep = ";\\s*")

# Fill county fips with leading zeros
policy_data$auth_local_code <- sprintf("%05d", as.integer(policy_data$auth_local_code))
policy_data$affected_local_code <- sprintf("%05d", as.integer(policy_data$affected_local_code))

# Fill state fips for state policies
policy_data$auth_state_province <- tolower(policy_data$auth_state_province)
policy_data$affected_state_province <- tolower(policy_data$affected_state_province)

## Authorizing state/province
policy_data$auth_local_area <- ifelse(policy_data$auth_level_gov == "State / Province" & policy_data$auth_local_area == "N/A", 
                                      policy_data$auth_state_province, 
                                      policy_data$auth_local_area)
policy_data <- merge(policy_data, state.fips, by.x = "auth_state_province", by.y = "polyname", all.x = TRUE)
policy_data$auth_local_code <- ifelse(policy_data$auth_level_gov == "State / Province" & policy_data$auth_local_code == "000NA", 
                                      policy_data$fips, 
                                      policy_data$auth_local_code)
### Remove merged columns from state.fips
policy_data <- subset(policy_data, 
                      select = -c(fips, ssa, region, division, abb))

## Affected state/province
policy_data$affected_local_area <- ifelse(policy_data$affected_level_gov == "State / Province" & policy_data$affected_local_area == "N/A", 
                                          policy_data$affected_state_province, 
                                          policy_data$affected_local_area)
policy_data <- merge(policy_data, state.fips, by.x = "affected_state_province", by.y = "polyname", all.x = TRUE)
policy_data$affected_local_code <- ifelse(policy_data$affected_level_gov == "State / Province" & policy_data$affected_local_code == "000NA", 
                                          policy_data$fips, 
                                          policy_data$affected_local_code)
### Remove merged columns from state.fips
policy_data <- subset(policy_data, 
                      select = -c(fips, ssa, region, division, abb))

# Remove rows with NA authorizing and affecting government level
policy_data <- policy_data[!(policy_data$affected_state_province == "n/a" & 
                               policy_data$auth_state_province == "n/a"), ]

# Fill state fips code with leading zeros
policy_data$auth_local_code <- sprintf("%02d", as.integer(policy_data$auth_local_code))
policy_data$affected_local_code <- sprintf("%02d", as.integer(policy_data$affected_local_code))

# Convert selective columns to dummy variables 
cols_to_dummy <- c("policy_type", "policy_category", "policy_subcategory", "policy_target")

for (col in cols_to_dummy) {
  # Create and export dummy reference list
  levels <- unique(policy_data[[col]])
  dummies <- 1:length(levels)
  ref_table <- data.frame(dummy = dummies, 
                          level = levels)
  assign(paste0("policy-", col, "-reference"), 
         ref_table, envir = .GlobalEnv)
  
  export_path <- "dummy-reference-list/"
  file_name <- paste0("policy-", col, "-reference.csv")
  write.csv(ref_table, file.path(export_path, file_name), 
            row.names = FALSE)
  
  policy_data[[paste0(col, "_dummy")]] <- as.integer(as.factor(policy_data[[col]]))
}

# Convert dates columns into date class
date_cols <- c("issued_date", "start_date", "anticipated_end_date", "actual_end_date")

for (col in date_cols) {
  policy_data[[col]] <- mdy(policy_data[[col]])
}