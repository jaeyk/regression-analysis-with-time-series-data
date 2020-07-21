
stacked_bar_plot <- function(df, var1, var2, var3) {
  df %>%
    group_by({{ var1 }}, {{ var2 }}, {{var3}}) %>%
    summarize(n = n()) %>%
    mutate(
      prop = n / sum(n),
      prop = round(prop, 2)
    ) %>%
    ggplot(aes(
      x = {{ var1 }},
      y = prop,
      group = 1,
      fill = {{ var2 }}
    )) +
    geom_col(position = "fill") +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    theme_pubr() +
    scale_fill_npg()
}
