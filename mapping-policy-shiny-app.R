# Import shapefile for counties
county_shapefile <- read_sf("data/cb_2022_us_county_500k/cb_2022_us_county_500k.shp")

# Merge shapefile with policy_data
policy_data_sf <- merge(county_shapefile, policy_data, 
                        by.x = "GEOID", by.y = "affected_local_code", all.x = TRUE)