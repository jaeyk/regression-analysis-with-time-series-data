# Import pkgs
pacman::p_load(
  tidyverse,
  here,
  readxl, # import excel files
  data.table
)

# Import files
census <- readxl::read_xlsx(here("raw_data", "Poverty-Rates-by-County-1960-2010.xlsm"),
  sheet = "Data", # Sheet name
  range = ("A2:V3196")
) # Cell range

# Filter data
census <- census[-1, c(2, 3, 4, 5, 6, 11, 12)] # Skip the USA row and select only 1960 and 1970 data

# Pivot longer
census_county <- census %>%
  pivot_longer(
    cols = contains("Poverty"),
    names_to = "poverty_year",
    values_to = "poverty_rate"
  ) %>%
  pivot_longer(
    cols = contains("Population"),
    names_to = "pop_year",
    values_to = "pop_size"
  ) %>%

  # Extract only numbers
  mutate(
    poverty_year = parse_number(poverty_year),
    pop_year = parse_number(pop_year)
  ) %>%

  # Rename col
  rename("year" = "pop_year") %>%

  # Drop col
  select(-c("poverty_year")) %>%

  # Drop state totals
  filter(FIPS != 1) %>%

  # Remove duplicates
  distinct() %>%

  # Reorder cols
  select(FIPS, State, County, year, poverty_rate, pop_size)

# Export the file
write_csv(
  census_county,
  here("processed_data", "historical_census_county.csv")
)
