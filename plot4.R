
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./exdata_data_household_power_consumption.zip")
# Read the zip file 
# Unzip only single file as CSV file with column separator = ';', column classes as Date, time (string), 7 numeric fields 
# Set the missing values 'NA' as '?'
dat <- read.table(unz('exdata_data_household_power_consumption.zip', 'household_power_consumption.txt'), header=T, sep = ';', colClasses = c("factor","factor",rep("numeric", 7)), na.strings = '?')

dat$DateNew <- strptime(dat$Date, format= "%d/%m/%Y")
limitedData <- subset(dat, DateNew=='2007-02-01' | DateNew=='2007-02-02')
limitedData$DateTimeNew <- paste(limitedData$Date, limitedData$Time)
limitedData$DateTimeNew <- strptime(limitedData$DateTimeNew, format= "%d/%m/%Y %H:%M:%S")

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
# Plot 1- Global Active Power 
plot(limitedData$DateTimeNew, limitedData$Global_active_power, type = "l", lty =1,ylab = "Global Active Power", xlab = "",)

# Plot 2- Voltage
plot(limitedData$DateTimeNew, limitedData$Voltage, type = "l", lty =1,ylab = "Voltage", xlab = "datetime")

# Plot 3- Energy Sub Metering
plot(limitedData$DateTimeNew, limitedData$Sub_metering_1, type = "l", lty =1,ylab = "Energy sub metering", xlab = "",)
points(limitedData$DateTimeNew, limitedData$Sub_metering_2, col ="red", type = "l", lty =1)
points(limitedData$DateTimeNew, limitedData$Sub_metering_3, col ="blue", type = "l", lty =1)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'), lty = c(1,1,1))

# Plot 4- Global reactive Power 
plot(limitedData$DateTimeNew, limitedData$Global_reactive_power, type = "l", lty =1,ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
