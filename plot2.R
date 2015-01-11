download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./exdata_data_household_power_consumption.zip")
# Read the zip file 
# Unzip only single file as CSV file with column separator = ';', column classes as Date, time (string), 7 numeric fields 
# Set the missing values 'NA' as '?'
dat <- read.table(unz('exdata_data_household_power_consumption.zip', 'household_power_consumption.txt'), header=T, sep = ';', colClasses = c("factor","factor",rep("numeric", 7)), na.strings = '?')

dat$DateNew <- strptime(dat$Date, format= "%d/%m/%Y")

png(file = "plot2.png", width = 480, height = 480)
limitedData <- subset(dat, DateNew=='2007-02-01' | DateNew=='2007-02-02')
limitedData$DateTimeNew <- paste(limitedData$Date, limitedData$Time)
limitedData$DateTimeNew <- strptime(limitedData$DateTimeNew, format= "%d/%m/%Y %H:%M:%S")
plot(limitedData$DateTimeNew, limitedData$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", main ="")
dev.off()
