#----------------------------------------------------
# Exploratory Data Analysis
# Course project 1
# * PLOT 1
#----------------------------------------------------
# Load packages
library('data.table')  # in order to process data faster

# Code for loading data from web
fileURL = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileURL, destfile = 'household_power_consumption.zip', method = 'curl')

# unzip data
unzip('household_power_consumption.zip', overwrite = TRUE)

# Read data using data.table format
DT <- data.table(read.table(file = 'household_power_consumption.txt', 
                            sep = ';', header = T,
                            na.strings = '?', as.is = T))
# Deal with dates
DT <- subset(DT, Date == '1/2/2007' | Date == '2/2/2007')
DT$Date <- as.Date(strptime(DT$Date, format = '%d/%m/%Y'))
DT$Time <- as.ITime(strptime(DT$Time, format = '%H:%M:%S'))

# Global plot parameters
par(bg = 'transparent')

#----------------------------------------------------
# Open png device
png(filename = 'plot1.png', width = 480, height = 480)

# Create histogram
hist(DT$Global_active_power, col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')

# Close png device
dev.off()
#----------------------------------------------------