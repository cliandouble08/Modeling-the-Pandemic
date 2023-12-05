# Two raw dataframes: raw_economic_characteristics_2020/2021

new_names <- c(
  "geography", "area_name", "pop_16_over", "pop_16_over_in_labor",
  "pop_16_over_civilian_labor", "pop_16_over_civilian_employed",
  "pop_16_over_civilian_unemployed", "pop_16_over_armed_forces",
  "pop_16_over_not_in_labor", "civilian_labor_force", "unemployment_rate",
  "females_16_over", "females_16_over_in_labor", "females_16_over_civilian_labor",
  "females_16_over_civilian_employed", "children_under_6", "children_under_6_all_parents_working",
  "children_6_to_17", "children_6_to_17_all_parents_working", "workers_16_over",
  "workers_16_over_drive_alone", "workers_16_over_carpooled", "workers_16_over_public_trans",
  "workers_16_over_walked", "workers_16_over_other_means", "workers_16_over_home",
  "mean_travel_time", "employed_16_over", "employed_16_over_management_occupations",
  "employed_16_over_service_occupations", "employed_16_over_sales_office",
  "employed_16_over_resources_construction_maintenance", "employed_16_over_production_transportation",
  "employed_16_over_industry", "employed_16_over_agriculture_forestry_fishing_mining",
  "employed_16_over_construction", "employed_16_over_manufacturing", "employed_16_over_wholesale_trade",
  "employed_16_over_retail_trade", "employed_16_over_transportation_warehousing_utilities",
  "employed_16_over_information", "employed_16_over_finance_insurance_real_estate",
  "employed_16_over_professional_scientific_management", "employed_16_over_education_health_social",
  "employed_16_over_arts_entertainment_food", "employed_16_over_other_services",
  "employed_16_over_public_administration", "class_worker_civilian_employed_16_over",
  "class_worker_private_wage_salary", "class_worker_government_workers", 
  "class_worker_self_employed", "class_worker_unpaid_family", "total_households",
  "households_income_less_10k", "households_income_10k_15k", "households_income_15k_25k",
  "households_income_25k_35k", "households_income_35k_50k", "households_income_50k_75k",
  "households_income_75k_100k", "households_income_100k_150k", "households_income_150k_200k",
  "households_income_200k_more", "median_household_income", "mean_household_income",
  "households_with_earnings", "households_with_earnings_mean", "households_with_social_security",
  "households_with_social_security_mean", "households_with_retirement_income",
  "households_with_retirement_income_mean", "households_with_ssi", "households_with_ssi_mean",
  "households_with_public_assistance", "households_with_public_assistance_mean",
  "households_with_snap", "families", "families_income_less_10k", "families_income_10k_15k",
  "families_income_15k_25k", "families_income_25k_35k", "families_income_35k_50k",
  "families_income_50k_75k", "families_income_75k_100k", "families_income_100k_150k",
  "families_income_150k_200k", "families_income_200k_more", "median_family_income",
  "mean_family_income", "per_capita_income", "nonfamily_households", "median_nonfamily_income",
  "mean_nonfamily_income", "median_earnings_workers", "median_earnings_male_fulltime",
  "median_earnings_female_fulltime", "civilian_noninst_population", "civilian_noninst_with_health_ins",
  "civilian_noninst_with_private_ins", "civilian_noninst_with_public_ins", "civilian_noninst_no_health_ins",
  "civilian_noninst_under_19", "civilian_noninst_under_19_no_ins", "civilian_noninst_19_to_64",
  "civilian_noninst_19_to_64_in_labor", "civilian_noninst_19_to_64_employed",
  "civilian_noninst_19_to_64_employed_with_ins", "civilian_noninst_19_to_64_employed_with_private_ins",
  "civilian_noninst_19_to_64_employed_with_public_ins", "civilian_noninst_19_to_64_employed_no_ins",
  "civilian_noninst_19_to_64_unemployed", "civilian_noninst_19_to_64_unemployed_with_ins",
  "civilian_noninst_19_to_64_unemployed_with_private_ins", "civilian_noninst_19_to_64_unemployed_with_public_ins",
  "civilian_noninst_19_to_64_unemployed_no_ins", "civilian_noninst_19_to_64_not_in_labor",
  "civilian_noninst_19_to_64_not_in_labor_with_ins", "civilian_noninst_19_to_64_not_in_labor_with_private_ins",
  "civilian_noninst_19_to_64_not_in_labor_with_public_ins", "civilian_noninst_19_to_64_not_in_labor_no_ins"
)

## For 2020 dataframe
updated_raw_economic_characteristics_2020 <- raw_economic_characteristics_2020 %>%
  select(-contains("Margin of Error"), -contains("Annotation of Margin of Error"), 
         -contains("Percent"), -contains("Annotation of Percent"), 
         -contains("Annotation of Estimate"))

names(updated_raw_economic_characteristics_2020) <- new_names

updated_raw_economic_characteristics_2020 <- updated_raw_economic_characteristics_2020 %>% 
  mutate(year = 2020)

## For 2021 dataframe
updated_raw_economic_characteristics_2021 <- raw_economic_characteristics_2021 %>%
  select(-contains("Margin of Error"), -contains("Annotation of Margin of Error"), 
         -contains("Percent"), -contains("Annotation of Percent"), 
         -contains("Annotation of Estimate"))

names(updated_raw_economic_characteristics_2021) <- new_names

updated_raw_economic_characteristics_2021 <- updated_raw_economic_characteristics_2021 %>% 
  mutate(year = 2021)

# Merge the two dataframe from both years
econ_char_data <- rbind(updated_raw_economic_characteristics_2020, 
                        updated_raw_economic_characteristics_2021)

# Convert geography codes into county FIPS codes
econ_char_data <- econ_char_data %>% 
  mutate(geography = as.character(geography)) %>% 
  mutate(geography = substr(geography, nchar(geography) - 4, nchar(geography)))