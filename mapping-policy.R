# Import shapefile for counties
county_shapefile <- read_sf("data/cb_2022_us_county_500k/cb_2022_us_county_500k.shp")

# Merge shapefile with policy_data
local_policy_map <- merge(county_shapefile, local_policy_summary, 
                               by.x = "GEOID", by.y = "affected_local_code")

# Define US county map data from library(maps)
us_counties <- map_data()

# Transform local_policy_map to spatial object
local_policy_sf <- st_as_sf(local_policy_map)

# Mapping policy_type without parallel processing
ggplot() +
  geom_polygon(data = us_counties, 
               aes(x = long, y = lat, group = gropu), 
               fill = "white", color = "black", alpha = 0.5) +
  geom_sf(data = local_policy_sf, aes(fill = policy_type)) +
  
  theme_classic() +
  scale_fill_viridis(option = "C") +
  labs(x = "Longitude", y = "Latitude", fill = "Policy Type (transformed)") +
  guides(fill = "none") +
  theme(legend.position = "bottom")

# Animated map with gganimate
numCores <- detectCores()
registerDoParallel()

# Create the base US county map
base_county_map <- ggplot() +
  geom_polygon(data = us_counties, 
aes(x = long, y = lat, group = group), 
fill = "white", color = "black", alpha = 0.5) +
  theme_classic() +
  labs(x = "Longitude", y = "Latitude", fill = "Policy Type (transformed)") +
  guides(fill = "none") +
  theme(legend.position = "bottom")

# Function for generating each animation frame
generate_map_frame <- function(year) {
  filtered_data <- filter(local_policy_sf, year == year)
  
  frame <- base_county_map +
    geom_sf(data = filtered_data, aes(fill = policy_type)) +
    scale_fill_viridis(option = "C") +
    labs(title = paste("Policy Type (transformed) in ", year)) +
    transition_states(year, transition_length = 1, state_length = 1) +
    enter_fade() +
    exit_fade()
  
  return(frame)
}

frames <- foreach(year = unique(local_policy_sf$year), 
                  .packages = c("ggplot2", "gganimate", "dplyr")) %dopar% {
                    generate_map_frame(year)
                  }

animated_map <- animate(frames)

anim_save("figures/animated-mapping/animated_policy_type.gif", animated_map)

stopCluster()
registerDoSEQ()