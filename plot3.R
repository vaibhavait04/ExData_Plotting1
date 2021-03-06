download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./exdata_data_household_power_consumption.zip")
# Read the zip file 
# Unzip only single file as CSV file with column separator = ';', column classes as Date, time (string), 7 numeric fields 
# Set the missing values 'NA' as '?'
dat <- read.table(unz('exdata_data_household_power_consumption.zip', 'household_power_consumption.txt'), header=T, sep = ';', colClasses = c("factor","factor",rep("numeric", 7)), na.strings = '?')

dat$DateNew <- strptime(dat$Date, format= "%d/%m/%Y")
limitedData <- subset(dat, DateNew=='2007-02-01' | DateNew=='2007-02-02')

png(file = "plot3.png", width = 480, height = 480)
limitedData$DateTimeNew <- paste(limitedData$Date, limitedData$Time)
limitedData$DateTimeNew <- strptime(limitedData$DateTimeNew, format= "%d/%m/%Y %H:%M:%S")
plot(limitedData$DateTimeNew, limitedData$Sub_metering_1, ylab = "Energy Sub Metering", xlab = "", main ="")
points(limitedData$DateTimeNew, limitedData$Sub_metering_2, col ="red", type = "l", lty =1)
points(limitedData$DateTimeNew, limitedData$Sub_metering_3, col ="blue", type = "l", lty =1)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'), lty = c(1,1,1))
dev.off()
