library(tidyverse)

add_decade <- function(df, year){

df <- df %>%
  mutate(decade = case_when(
    {{year}} %in% 1960:1969 ~"1960s",
    {{year}} %in% 1970:1979 ~"1970s",
    {{year}} %in% 1980:1989 ~"1980s",
    {{year}} %in% 1990:1999 ~"1990s",
    {{year}} %in% 2000:2010 ~"2000s",
    {{year}} %in% 2010:2020 ~"2010s"
  ),
  decade = factor(decade),
  decade = fct_relevel(decade, c("1960s", "1970s", "1980s", "1990s", "2000s", "2010s")))

df
  }