# Import pkgs
pacman::p_load(
  tidyverse,
  here,
  readxl # import excel files
)

# Import files
census <- readxl::read_xlsx(here("raw_data", "Poverty-Rates-by-County-1960-2010.xlsm"),
  sheet = "Data", # Sheet name
  range = ("A2:V3196")
) # Cell range

# Filter data
census <- census[-1, c(2, 3, 4, # FIPS, State, County
                       5, 6, 7, # Poverty rate 1960, 1970, 1980
                       11, 12, 13)] # Pop size 1960, 1970, 1980

# No states!
census <- census %>% filter(!(length(FIPS) == 1))

# Pivot longer
census_county1 <- census %>%
  pivot_longer(
    cols = contains("Poverty"),
    names_to = "year",
    values_to = "poverty_rate"
  ) 

census_county2 <- census %>%
  pivot_longer(
    cols = contains("Population"),
    names_to = "year",
    values_to = "pop_size"
  ) 

census_county <- census_county1 %>%
  mutate(pop_size = census_county2$pop_size)

census_county <- census_county %>%
  # Extract only numbers
  mutate(
    year = parse_number(year)
  )

census_county <- census_county[,-c(4:6)]

# Export the file
write_csv(
  census_county,
  here("processed_data", "historical_census_county.csv")
)
