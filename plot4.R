#----------------------------------------------------
# Exploratory Data Analysis
# Course project 1
# * PLOT 4
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
# Sample all data for 02-Feb (for X axis labels)
feb.2 <- which(DT$Date == as.Date('2007-02-02'))
at.custom <- c(1, feb.2[1], feb.2[length(feb.2)])

# Open png device
png(filename = 'plot4.png', width = 480, height = 480)

# Split plot panel
par(mfrow = c(2, 2))
#.......................................................
# 1st plot
# Create time series plot without X axis labels
with(DT, plot(Global_active_power,
              type = 'l', xlab = '', xaxt = 'n',
              ylab = 'Global Active Power'))
# Add points
with(DT, points(Global_active_power, pch = '.'))

# Add X axis with labels
axis(1, labels = c('Thu', 'Fri', 'Sat'), at = at.custom)
#.......................................................
# 2nd plot
# Create time series plot without X axis labels
with(DT, plot(Voltage,
              type = 'l', xaxt = 'n', xlab = 'datetime'))
# Add points
with(DT, points(Voltage, pch = '.'))

# Add X axis with labels
axis(1, labels = c('Thu', 'Fri', 'Sat'), at = at.custom)
#.......................................................
# 3rd plot
# Create time series plot without X axis labels
with(DT, plot(Sub_metering_1,
              type = 'l', xlab = '', xaxt = 'n', 
              col = 'black',
              ylab = 'Energy sub metering'))
# Add points
points(DT$Sub_metering_1, pch = '.', col = 'black')

# Add 2nd time series
with(DT, lines(Sub_metering_2, col = 'red'))
# Add points
points(DT$Sub_metering_2, pch = '.', col = 'red')

# Add 3rd time series
with(DT, lines(Sub_metering_3, col = 'blue'))
# Add points
points(DT$Sub_metering_3, pch = '.', col = 'blue')

# Add legend
legend('topright', legend = names(DT)[7:9],
       col = c('black', 'red', 'blue'), lty = 1,
       box.lwd = 0, bg = 'transparent')

# Add X axis with labels
axis(1, labels = c('Thu', 'Fri', 'Sat'), at = at.custom)
#.......................................................
# 4th plot
# Create time series plot without X axis labels
with(DT, plot(Global_reactive_power,
              type = 'l', xaxt = 'n', xlab = 'datetime'))
# Add points
with(DT, points(Global_reactive_power, pch = '.'))

# Add X axis with labels
axis(1, labels = c('Thu', 'Fri', 'Sat'), at = at.custom)

# Close png device
dev.off()

# Set plot panel to default
par(mfrow = c(1, 1))
#----------------------------------------------------