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
