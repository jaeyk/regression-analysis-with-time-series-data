
# Import pkgs 

# if (!require("pacman")) install.packages("pacman")
pacman::p_load(
        tidyverse, # for the tidyverse framework
        data.table, 
        here, # for reproducibility 
        tidygeocoder,
        ggmap)

# devtools::install_github("jaeyk/makereproducible")
library(makereproducible)

# Import files 

asian_org <- read_csv(make_here("/home/jae/analyzing-asian-american-latino-civic-infrastructure/raw_data/asian_orgs.csv"))

latino_org <- read_csv(make_here("/home/jae/analyzing-asian-american-latino-civic-infrastructure/raw_data/latino_orgs.csv"))

# Subset data 
## Asian 
asian_org_dt <- data.table(asian_org)

asian_address <- asian_org_dt[F.year <= 1981, .(Address, F.year), ] %>% as.data.frame()

## Latino 
latino_org_dt <- data.table(latino_org) 

latino_address <- asian_org_dt[F.year <= 1981, .(Address, F.year, States,), ] %>% as.data.frame()

asian_org_dt
# Geocode the address 
asian_lat_longs <- asian_address %>% 
        tidygeocoder::geocode(address = Address,
                              method = "cascade", # Mix of geo methods 
                              lat = latitude, 
                              long = longtitude)

latino_lat_longs <- latino_address %>% 
        tidygeocoder::geocode(Address, 
                              method = "cascade", # Mix of geo methods 
                              lat = latitude, 
                              long = longtitude)

# Combine 
df <- bind_rows(mutate(asian_lat_longs, group = "Asian"),
                mutate(latino_lat_longs, group = "Latino"))

# Fix problematic addrs 
addrs <- df$Address[which(is.na(df$latitude))]

addrs

# Export 
write_csv(df, here("processed_data", "org_lat_logs.csv"))
