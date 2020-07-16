#!/bin/bash 

# change directory the directory where I downloaded the zipped file for scanned documents 

# cd Downloads/

# copy the file to ~project_directory/raw_data/nclr (retain the original file just in case)

#cp NCLR-selected.zip ~/analyzing-asian-american-latino-civic-infrastructure/raw_data |

# cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data | mkdir nclr | mv NCLR-selected nclr 

# unzip the file 

# sudo apt-get install unzip 

# unzip NCLR-selected.zip | rm NCLR-selected.zip

# Split the files 
# sudo apt-get install pdftk 


## 1971 - 1973
cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr/'Agenda (SCLR) June 1971-April 1973'/ 

### First 
pdftk First.pdf cat 2-12 output nclr_197106 
pdftk First.pdf cat 9-12 output nclr_197107 
pdftk First.pdf cat 13-18 output nclr_197108 
pdftk First.pdf cat 19-24 output nclr_197109 
pdftk First.pdf cat 25-29 output nclr_197110

### Second 
pdftk Second.pdf cat 2-30 output nclr_197206 
pdftk Second.pdf cat 31-64 output nclr_197208 
pdftk Second.pdf cat 65-100 output nclr_197210 

### Third 
pdftk Third.pdf cat 1-14 output nclr_197212 
pdftk Third.pdf cat 15-40 output nclr_19720501 

### Fourth 
pdftk Fourth.pdf cat 1-9 output nclr_19720502 

### Last
pdftk Last.pdf cat 1-6 output nclr_19720503 
pdftk Last.pdf cat 8-11 output nclr_19730501 
pdftk Last.pdf cat 12-12 output nclr_197304 

# Copy these files to the parent directory 

mv nclr* ..

## 1973 - 1976
cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr/'Agenda_ A Monthly Newsletter (NCLR) May 1973- December 1976'/ 

### First 
pdftk First.pdf cat 2-7 output nclr_19730502 
pdftk First.pdf cat 8-11 output nclr_197306 
pdftk First.pdf cat 12-15 output nclr_197307 
pdftk First.pdf cat 16-19 output nclr_197308 
pdftk First.pdf cat 20-23 output nclr_197309 
pdftk First.pdf cat 24-27 output nclr_197310 
pdftk First.pdf cat 28-31 output nclr_197311 
pdftk First.pdf cat 32-37 output nclr_197312 
pdftk First.pdf cat 38-41 output nclr_197401 
pdftk First.pdf cat 42-45 output nclr_197402 
pdftk First.pdf cat 46-49 output nclr_197403 
pdftk First.pdf cat 50-53 output nclr_197404 
pdftk First.pdf cat 54-59 output nclr_197405 
pdftk First.pdf cat 60-65 output nclr_197406 
pdftk First.pdf cat 66-71 output nclr_197407 
pdftk First.pdf cat 72-77 output nclr_197408 
pdftk First.pdf cat 78-83 output nclr_197409 
pdftk First.pdf cat 84-89 output nclr_197410 
pdftk First.pdf cat 90-95 output nclr_197411 
pdftk First.pdf cat 96-100 output nclr_197412 

### Second 
pdftk Second.pdf cat 1-6 output nclr_197501 
pdftk Second.pdf cat 7-12 output nclr_197502  
pdftk Second.pdf cat 13-18 output nclr_197503 
pdftk Second.pdf cat 19-24 output nclr_19750401 

### Third 
pdftk Third.pdf cat 1-1 output nclr_19750402 
pdftk Third.pdf cat 2-7 output nclr_197505 
pdftk Third.pdf cat 8-13 output nclr_197506 
pdftk Third.pdf cat 14-19 output nclr_197507 
pdftk Third.pdf cat 20-25 output nclr_197508 
pdftk Third.pdf cat 26-31 output nclr_197509 
pdftk Third.pdf cat 32-37 output nclr_197510 
pdftk Third.pdf cat 38-47 output nclr_197511 
pdftk Third.pdf cat 48-53 output nclr_197601 
pdftk Third.pdf cat 54-59 output nclr_197602 
pdftk Third.pdf cat 60-65 output nclr_197603 
pdftk Third.pdf cat 66-71 output nclr_197604 
pdftk Third.pdf cat 72-77 output nclr_197605 
pdftk Third.pdf cat 78-85 output nclr_197606 
pdftk Third.pdf cat 86-91 output nclr_197607 
pdftk Third.pdf cat 92-97 output nclr_197608 
pdftk Third.pdf cat 98-100 output nclr_19760901 

### Last 
pdftk Last.pdf cat 1-5 output nclr_19760902 
pdftk Last.pdf cat 6-13 output nclr_19761001

# Copy these files to the parent directory 

mv nclr* ..

## 1976 - 1979

#cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr/'Agenda- A Monthly Newsletter May 1973 - Dec 1976'/ 

### First 
#rm 'First from Agenda A Monthly Newsletter May 1973-Dec 1976_2.pdf' # duplicate 
 
### Second 
#rm 'Second from Agenda A Monthly Newsletter May 1973-Dec 1976_3.pdf' # duplicate 

### Third 
#rm 'Last from Agenda A Monthly Newsletter May 1973-Dec 1976_4.pdf' # duplicate 


## 1973 - 1976 Summer 

cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr/'Agenda- 1973 (NCLR)Summer 1973-Summer 1976'/ # Quaterly 

### First 

pdftk First.pdf cat 1-8 output nclr_1973summer 
pdftk First.pdf cat 9-32 output nclr_1973spring 
pdftk First.pdf cat 33-64 output nclr_1973fall 
pdftk First.pdf cat 66-96 output nclr_1973winter

### Second 

pdftk Second.pdf cat 1-36 output nclr_1974spring 
pdftk Second.pdf cat 37-76 output nclr_1974summer  
pdftk Second.pdf cat 77-100 output nclr_1974fall 

### Last 

pdftk Last.pdf cat 1-8 output nclr_1976spring 
pdftk Last.pdf cat 10-45 output nclr_1976summer 

# Copy these files to the parent directory 

mv nclr* ..

## 1979 - 1980

cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr/'Agenda- A Journal of Hispanic Issues (NCRL) 1979-1980'/ 

### First 

pdftk First.pdf cat 1-38 output nclr_197901
pdftk First.pdf cat 39-62 output nclr_19790301

### Second 

pdftk Second.pdf cat 1-18 output nclr_19790302
pdftk Second.pdf cat 20-56 output nclr_197905
pdftk Second.pdf cat 58-97 output nclr_197907
pdftk Second.pdf cat 99-97 output nclr_19790901

### Fourth 

pdftk Fourth.pdf cat 1-17 output nclr_19790902
pdftk Fourth.pdf cat 19-68 output nclr_198003
pdftk Fourth.pdf cat 70-100 output nclr_19800501

### Fifth 

pdftk Fifth.pdf cat 1-26 output nclr_19800502
pdftk Fifth.pdf cat 29-67 output nclr_198007
pdftk Fifth.pdf cat 69-100 output nclr_19801101

### Last 
pdftk Last.pdf cat 1-4 output nclr_19801102

# Copy these files to the parent directory 

mv nclr* ..

## 1981 

cd ~/analyzing-asian-american-latino-civic-infrastructure/raw_data/nclr/'Agenda- A Journal of Hispanic Issues (NCLR) 1981'/ 

### First 

pdftk 'First from A Journal of Hispanic Issues 1981.pdf' cat 1-38 output nclr_198101 

pdftk 'First from A Journal of Hispanic Issues 1981.pdf' cat 40-85 output nclr_198103 

pdftk 'First from A Journal of Hispanic Issues 1981.pdf' cat 87-100 output nclr_19810501 

### Second 

pdftk 'Second from A Journal of Hispanic Issues 1981.pdf' cat 1-47 output nclr_19810502 

pdftk 'Second from A Journal of Hispanic Issues 1981.pdf' cat 49-100 output nclr_19810901

### Third 

pdftk 'Last from A Journal of Hispanic Issues 1981.pdf' cat 1-15 output nclr_19810902

# Copy these files to the parent directory 

mv nclr* ..

# Agenda became inactive during 1982-1988 and publication resumed 1989 


