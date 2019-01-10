
# Download Houshold Power Consumption data set and read into R

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")
energy_data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

# Convert dates to Datetime class and subset just the data from February 1, 2007
# and February 2, 2007

library(lubridate)

energy_data$DateTime <- strptime(paste(as.character(energy_data$Date), as.character(energy_data$Time)),
                                 format = "%d/%m/%Y %H:%M:%S")
data <- energy_data[(months(energy_data$DateTime) == "February")
                    & (year(energy_data$DateTime) == 2007),]
data <- data[((day(data$DateTime) == 01) | (day(data$DateTime) == 02)),]

# Plot 3

png(file = "./plot3.png")
with(data, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(data, lines(data$DateTime, Sub_metering_1, col = "black"))
with(data, lines(data$DateTime, Sub_metering_2, col = "red"))
with(data, lines(data$DateTime, Sub_metering_3, col = "blue"))
legend("topright", pch = 95, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
