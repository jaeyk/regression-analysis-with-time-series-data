#!/bin/bash 

# Download ACS data 
wget https://www2.census.gov/library/visualizations/time-series/demo/Poverty-Rates-by-County-1960-2010.xlsm

# Move EOA data 
cp gomf6571.dta.zip cap.dta ~/analyzing-asian-american-latino-civic-infrastructure/raw_data
cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data | unzip gomf6571.dta.zip
