
plot_us_heatmap <- function(df){
  
    plot_usmap(data = df, values = "n", labels = TRUE,
               exclude = c("Alaska", "Hawaii")) + 
  
    labs(fill = 'Count of organizations (1981)') +
  
    scale_fill_gradientn(colours = rev(heat.colors(10)),
                         na.value = "grey90",
                         guide = guide_colourbar(
                            barwidth = 25,
                            barheight = 0.4,
                            title.position = "top")) +

  
    # Adjust legend 
    theme(legend.position = "bottom",
          legend.title = element_text(size = 15),  # font size 
          legend.text = element_text(size = 15),
          axis.title.x = element_blank(), # remove axis, title, ticks
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.line = element_blank())
  
}