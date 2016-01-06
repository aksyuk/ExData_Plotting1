#----------------------------------------------------
# Exploratory Data Analysis
# Course project 1
# * PLOT 2
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
png(filename = 'plot2.png', width = 480, height = 480)

# Create time series plot without X axis labels
with(DT, plot(Global_active_power,
              type = 'l', xlab = '', xaxt = 'n',
              ylab = 'Global Active Power (kilowatts)'))

# Sample all data for 02-Feb
feb.2 <- which(DT$Date == as.Date('2007-02-02'))

# Add X axis with labels
axis(1, labels = c('Thu', 'Fri', 'Sat'),
     at = c(1, feb.2[1], feb.2[length(feb.2)]))

# Close png device
dev.off()
#----------------------------------------------------