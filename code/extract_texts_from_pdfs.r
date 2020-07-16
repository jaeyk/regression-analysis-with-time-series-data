# For Ubuntu installation, type this `sudo apt-get install libpoppler-cpp-dev` in the terminal 

# Import pkgs 
pacman::p_load(pdftools, 
               here,
               tidyverse,
               purrr,
               tm, 
               textclean,
               data.table)

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

# Clean the text 
df$text <- df$text %>%  
    stringr::str_replace_all("[^[:alnum:]]", "") %>% # Remove special characters 
    stringr::str_replace_all("[\\n]" , "") %>% # Remove line breaks 
    stringr::str_squish() # Remove extra white space 

# Save the df 
fwrite(df, here("processed_data", "nclr_text.csv"))