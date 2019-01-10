
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

# Plot 1

png(file = "./plot1.png")
hist((as.numeric(data$Global_active_power)/1000), xlab = "Global Active Power (kilowatts)", 
     col = "red", main = "Global Active Power")
dev.off()

# Plot 2

png(file = "./plot2.png")
plot(data$DateTime, (as.numeric(data$Global_active_power)/1000), type = "n", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(data$DateTime, (as.numeric(data$Global_active_power)/1000), type = "l")
dev.off()

# Plot 3

png(file = "./plot3.png")
with(data, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(data, lines(data$DateTime, Sub_metering_1, col = "black"))
with(data, lines(data$DateTime, Sub_metering_2, col = "red"))
with(data, lines(data$DateTime, Sub_metering_3, col = "blue"))
legend("topright", pch = 95, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



# Plot 4

png(file = "./plot4.png")
par(mfcol = c(2,2))

plot(data$DateTime, (as.numeric(data$Global_active_power)/1000), type = "n", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(data$DateTime, (as.numeric(data$Global_active_power)/1000), type = "l")

with(data, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(data, lines(data$DateTime, Sub_metering_1, col = "black"))
with(data, lines(data$DateTime, Sub_metering_2, col = "red"))
with(data, lines(data$DateTime, Sub_metering_3, col = "blue"))
legend("topright", pch = 95, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data, plot(DateTime, Voltage, type = "n"))
with(data, lines(DateTime, Voltage))

with(data, plot(DateTime, Global_reactive_power, type = "n"))
with(data, lines(DateTime, Global_reactive_power))
dev.off()

