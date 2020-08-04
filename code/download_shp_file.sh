#!/bin/bash

# Change directory
cd ~/analyzing-asian-american-latino-civic-infrastructur
e/raw_data

# Download the shape file
wget http://spatial.lib.berkeley.edu/public/ark28722-s7hs4j/data.zip | unzip

# Remove the file
rm data.zip
