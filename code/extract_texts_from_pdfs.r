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
  
# Put them together as a dataframe 
df <- data.frame(date = date_list,
                 text = text_list %>% unlist() %>% paste(collapse = ""))

# Save the df 
write_rds(df, "/home/jae/analyzing-asian-american-latino-civic-infrastructure/processed_data/nclr_text.rds")
