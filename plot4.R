##
## This R code file constructs the Plot 4 performing the following steps:
##      1) Download the file from the URL
##      2) Unzip the file
##      3) Load the dataset into R
##      4) Construct the Plot and save that to the PNG file of 480x480 Pixels 
##         called "plot4.png"    


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
png(filename = "plot4.png", width = 480, height = 480)

## Construct the Plot 4
        par(mfcol = c(2, 2))

        with(file_HPC, {
                plot(Date, Global_active_power, type="l",  
                                ylab = "Global Active Power",
                                xlab = "")
        
                plot(Date, Sub_metering_1, type = "l",  
                     ylab = "Energy sub metering",
                     xlab = "")
                
                        with(file_HPC, points(Date, Sub_metering_2, type = "l", 
                                              col = "red", ylab = "", xlab = ""))
                
                        with(file_HPC, points(Date, Sub_metering_3, type = "l", 
                                              col = "blue", ylab = "", xlab = ""))
                
                        legend("topright", lty = 1, 
                                                col = c("black", "red", "blue"),
                                                legend = c("Sub_metering_1", 
                                                        "Sub_metering_2",
                                                        "Sub_metering_3"),
                                                y.intersp = 1, 
                                                xjust = 1,
                                                yjust = 0,
                                                bty = "n",
                                                cex =0.95)
                
                
                plot(Date, Voltage, type="l",  
                     ylab = "Voltage",
                     xlab = "datetime")
                
                plot(Date, Global_reactive_power, type="l",  
                     ylab = "Global_reactive_power",
                     xlab = "datetime")
        })

## Close the PNG Device
dev.off()
