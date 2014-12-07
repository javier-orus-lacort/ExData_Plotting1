##
## This R code file constructs the Plot 1 performing the following steps:
##      1) Download the file from the URL
##      2) Unzip the file
##      3) Load the dataset into R
##      4) Construct the Plot and save that to the PNG file of 480x480 Pixels 
##         called "plot1.png" 


## Set the Local Time to English to get the week days in English
## This sentence works for RStudio on Windows at least 
Sys.setlocale("LC_TIME", "English")

## Variables setup for downloading/unzipping process.
file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_File <- "./exdata-data-household_power_consumption.zip"
txt_File <- "./household_power_consumption.txt"

## If the file hasn't been downloaded before then it downloads it right now.
if (!file.exists(zip_File)) {
        download.file(file_URL, destfile = zip_File, mode="wb")
}

## If the file hasn't been unziped before then it unzips it right now.
if (!file.exists(txt_File)) {
        unzip(zip_File)
}

## Load the dataset into R
file_read <- read.csv(txt_File, sep = ";", na.strings = "?", 
                        stringsAsFactors = FALSE)

## Select the complete cases and the dates needed for the exercise. Notice that
## with only one "&" and only one "|" we can vectorize the logical expression 
## to be used in the selection.
good <- complete.cases(file_read) & 
                (file_read$Date == "1/2/2007" | file_read$Date == "2/2/2007")
file_HPC <- file_read[good,]

## Concatenate Date and Time in the column Date and convert to POSIXlt
file_HPC$Date <- as.POSIXlt(strptime(paste(file_HPC$Date, file_HPC$Time), 
                                "%e/%m/%Y %H:%M:%S"))

## Open PNG Device
png(filename = "plot1.png", width = 480, height = 480)

## Construct the Plot 1
        hist(file_HPC$Global_active_power, col = "red", 
                main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)")

## Close the PNG Device
dev.off()
