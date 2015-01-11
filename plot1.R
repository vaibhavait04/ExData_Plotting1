download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./exdata_data_household_power_consumption.zip")
# Read the zip file 
# Unzip only single file as CSV file with column separator = ';', column classes as Date, time (string), 7 numeric fields 
# Set the missing values 'NA' as '?'
dat <- read.table(unz('exdata_data_household_power_consumption.zip', 'household_power_consumption.txt'), header=T, sep = ';', colClasses = c("factor","factor",rep("numeric", 7)), na.strings = '?')

dat$DateNew <- strptime(dat$Date, format= "%d/%m/%Y")
limitedData <- subset(dat, DateNew=='2007-02-01' | DateNew=='2007-02-02')

png(file = "plot1.png", width = 480, height = 480)
hist(limitedData$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red", xlim = c(0,6), ylim = c(0,1200))
dev.off()
