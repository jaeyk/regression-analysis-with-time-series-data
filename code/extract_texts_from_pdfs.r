# For Ubuntu installation, type this `sudo apt-get install libpoppler-cpp-dev` in the terminal 

# Import pkgs 
pacman::p_load(pdftools, 
               tidyverse,
               purrr,
               tm)

# File name list 
filename <- list.files("/home/jae/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr", 
                       pattern = 'nclr*', 
                       full.names = TRUE)

# Reformat filename 
date_list <- gsub(".*_", "", filename)

# Extract texts from the PDF
text_list <- list(filename) %>%
  pmap(~pdf_text(.)) 

# List into a data frame 
df <- text_list %>% 
  map_df(enframe, .id = 'ListElement') 

# for loop 

for (i in seq(1:length(date_list))){ 
  
  df$ListElement[df$ListElement == paste(i)] <- date_list[i]
  
}

# Rename and mutate
df <- df %>%
  rename("date" = "ListElement",
         "page_number" = "name")

# Save the df 
write_rds(df, "/home/jae/analyzing-asian-american-latino-civic-infrastructure/processed_data/nclr_text.rds")