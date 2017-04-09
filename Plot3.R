if(!file.exists("Data2/data.zip")){
        dir.create("Data")
        # Download and extract zipped data file
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile="Data2/data.zip")
        unzip(zipfile="Data2/data.zip", exdir="Data2")
}

# File unzipped as "household_power_consumption.txt" textfile
# Read a subset of the datafile
filePath <- "Data2/household_power_consumption.txt"
data <- read.csv(filePath, skip=66637, nrows=2880, na.strings = "?", header=FALSE, sep=";")

# Read the variable names
names(data) <- names(read.csv(filePath, nrows=1, sep=";"))

## Add a new column that combines and converts data$Date and data$Time as follows: 
# data$Date <- as.Date(data$Date, format="%d/%m/%y") and
# data$Time <- strptime(data$Time, format="%H:%M:%S")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Generate Plot 3
plot(data$DateTime, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering", main="")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", lwd=1, lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving "Plot3.png" to file
dev.copy(png, file="Data2/plot3.png", height=480, width=480)
dev.off() 
