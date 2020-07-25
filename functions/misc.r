
merge_by_group <- function(x, y) {
  bind_rows(
    mutate(x, category = "Asian"),
    mutate(y, category = "Latino")
  )
}

# The function below comes from Ben G
# https://stackoverflow.com/questions/5411979/state-name-to-abbreviation

add_state_abb <- function(df){

  st_crosswalk <- tibble(State = state.name) %>%
  bind_cols(tibble(State_abb = state.abb)) %>% 
  bind_rows(tibble(State = "District of Columbia", abb = "DC"))


  left_join(df, st_crosswalk, by = "State")

}

merge_by_group_extended <- function(x, y) {
  bind_rows(
    mutate(x, category = "Chinese"),
    mutate(y, category = "Mexican")
  )
}

org_to_ts <- function(data) {

  # Create the year sequence

  all_years <- seq(min(data$F.year), max(data$F.year))

  # Turn it into a dataframe

  all_years <- data.frame(F.year = all_years)

  # Count by year and type

  data_year <- data %>%
    count(F.year, States, Type) %>%
    rename(Freq = n) %>%
    right_join(all_years, by = "F.year")

  # Replace NA Freq with 0s

  data_year$Freq[is.na(data_year$Freq)] <- 0

  # Replace NA Type with unique Type

  data_year$Type[is.na(data_year$Type)] <- unique(data_year$Type[!is.na(data_year$Type)])

  data_year
}
