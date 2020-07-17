# Import pkgs 
pacman::p_load(tidyverse,
              here,
              readxl, # import excel files
              xlsx, # import excel files
              data.table)

# Import files
filename <- list.files("/home/jae/analyzing-asian-american-latino-civic-infrastructure/raw_data",
                     pattern = '??tab.xls',
                     full.names = TRUE)

# Parsing function

excel2df <- function(filename){

    census <- readxl::read_xls(filename,
                           sheet = 1,
                           .name_repair = "unique")[,c(1,6,7,10,11,12,13,14,15)]

    # 6,7: Black 
    # 10,11: Asian 
    # 12,13: Other 
    # 14,15: Hispanic origin (of any race)

    # Save objs 

    # Extract city names  
    colnames(census)[1] <- "Index"

    census$Index <- census$Index %>%
        str_replace_all("\\(|\\)", "") 

    city_names <- census %>%
        filter(!str_detect(Index, "[0-9]|[:punct:]")) %>%
        select(Index)
    
    city_names <- city_names$Index %>% as.character()

    message(paste("The number of cities in the State:", length(city_names)))
    
    # Identify p (each parameter in the sep() function)
    Index <- census$Index[-c(1:12)] %>% as.character()

    # Use NA as a breaker between each city info 
    na_index <- which(is.na(Index))

    # p (each parameter) for the first city on the list 
    var1 <- Index[1: na_index[1]]
    
    p1 <- sum(str_detect(var1, "1960"), na.rm = TRUE) + sum(str_detect(var1, "1970"), na.rm = TRUE)
    
    # Most of the city names 
    var2 <- list()
    
    p2 <- list()
    
    for (i in 1:((length(na_index))- 1)){
    
        message(paste(i))
        
        var2[[i]] <- Index[1 + na_index[i] : na_index[i+1]]
    
        p2[[i]] <- sum(str_detect(var2[[i]], "1960"), na.rm = TRUE) + sum(str_detect(var2[[i]], "1970"), na.rm = TRUE)
    
        }
    
    p2 <- map_df(p2, enframe)[,2]$value %>% as.integer()
    
    # The last city names 
    
    var3 <- Index[na_index[length(na_index)]+1:length(Index)]
    
    p3 <- sum(str_detect(var3, "1960"), na.rm = TRUE) + sum(str_detect(var3, "1970"), na.rm = TRUE)

    p_list <- c(p1, p2, p3)[!(c(p1, p2, p3) == 0)]
    
    # Replication
    City <- list()
    
    for (i in 1:length(p_list)){
    
      City[[i]] <- rep(city_names[i], times = p_list[i])
                
    }
    
    City <- City %>% map_df(~tibble(.)) 
    
    City <- City$. %>% as.character()
    
    # Rename cols 
    colnames(census)[1:9] <- c("Year", "black_num", "black_per", "asian_num", "asian_per",
                               "other_num", "other_per", "latino_num", "latino_per")
  
    # Add cols and filter  
    census <- census %>% 
        mutate(State = stringr::str_sub(filename, -9, -8) %>% toupper()) %>%
        # Filter 
        dplyr::filter(str_detect(Year, "1960|1970")) %>%
        mutate(Year = parse_number(Year)) 

    census <- census %>% add_column(City)
    
    message(paste("Parsing", unique(census$State)))
    
    # Replace (NA) with NA 
    census[census == "(NA)"] <- NA
    
    # Output
    census

}

# Apply the function to the list
out <- list(filename) %>%
    pmap(~excel2df(.)) 

df <- out %>% map_df(~tibble(.)) 

# Export the file 
write_csv(df, 
          here("processed_data", "historical_asian_latino_pop.csv"))
