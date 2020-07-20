# Import pkgs
pacman::p_load(
  tidyverse,
  here,
  data.table,
  foreign,
  readstata13
) # to import stata v.13

# Import files
cap <- read.dta13(here("raw_data", "cap.dta"))
census_conunty <- read_csv(here("processed_data", "historical_census_county.csv"))

# Add foreign key
cap$FIPS <- paste0(cap$stfips_f, cap$cofips_f) %>% as.numeric()

# Left join
cap_census <- left_join(cap, census_conunty) %>%
  select(-contains("fips_f")) %>%
  filter(!is.na(State)) %>%
  rename(EOA_fund = starts_with("fed"))

# Export
write_csv(cap_census, here("processed_data", "cap_census.csv"))
