# Import pkgs
pacman::p_load(
  tidyverse,
  tidygeocoder,
  here
)

# Import data
org_address <- read_csv(here("processed_data", "org_address.csv"))

# Geocode the address
org_lat_logs <- org_address %>%
  tidygeocoder::geocode(Address,
    country = "United States",
    method = "cascade", # Mix of geo methods
    lat = latitude,
    long = longtitude
  )

# Count failed geocoding cases
sum(is.na(org_lat_logs$latitude))

write_csv(org_lat_logs, here("processed_data", "org_lat_logs.csv"))
