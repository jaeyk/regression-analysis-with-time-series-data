# Import pkgs 
pacman::p_load(tidyverse,
               here,
               readxl, # import excel files
               xlsx, # import excel files 
               data.table)

# Import files
filename <- list.files() ... 

# Functionalize ... 
census <- readxl::read_xls(here("raw_data", "aktab.xls"),
                           sheet = 1,
                           .name_repair = "unique")[,c(1,6,7,10,11,12,13,14,15)]

# 6,7: Black 
# 10,11: Asian 
# 12,13: Other 
# 14,15: Hispanic origin (of any race)

# Save objs 
filename <- "aktab.xls"

colnames(census)[1] <- "Index"

# Create City name vector 
City <- census %>%
    filter(!str_detect(Index, "[0-9]|[:punct:]")) %>%
    select(Index)

City <- City$Index %>% as.character()

# Rename cols 
colnames(census)[1:9] <- c("Year", "black_num", "black_per", "asian_num", "asian_per",
                            "other_num", "other_per", "latino_num", "latino_per")

# Add cols and filter  
census <- census %>% 
    mutate(State = substr(filename, 1, 2) %>% toupper()) %>%
    # Filter 
    filter(str_detect(Year, "1960|1970")) %>%
    mutate(City = rep(City, each = 2)) %>%
    mutate(Year = parse_number(Year))

# Replace NAs 
census[census == "(NA)"] <- NA

# Export the file 
write_csv(census, 
          here("processed_data", "historical_asian_latino_pop.csv"))

View(census)