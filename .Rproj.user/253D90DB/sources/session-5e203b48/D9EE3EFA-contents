merged_df <- read_csv("merged_processed_data.csv")
us_counties <- counties(year = 2020)

# Create a unique identifier for each row in both dataframes
us_counties$unique_id <- 1:nrow(us_counties)
merged_df$unique_id <- 1:nrow(merged_df)

merged_geo_df <- merge(merged_df, us_counties, by.x = "fips", by.y = "GEOID")

# Create a ggplot object with Viridis palette
p <- ggplot() +
  geom_sf(data = merged_geo_df, aes(geometry = geometry, fill = factor(fips))) +
  scale_fill_viridis(discrete = TRUE) +  # Use Viridis palette for discrete values
  labs(title = "COVID-19 FIPS by County", fill = "FIPS Value") +
  transition_states(year, transition_length = 1, state_length = 1) +
  enter_fade() +
  exit_fade() +
  ease_aes("linear")

# Animate the plot
anim <- animate(p, nframes = 100, fps = 10)

# Display the animation
anim