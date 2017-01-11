if(!file.exists("./Data/data.zip")){
        dir.create("Data")
        # Download and extract zipped data file
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile="./Data/data.zip")
        unzip(zipfile="./Data/data.zip", exdir="./Data")
}

filePath <- "./Data/household_power_consumption.txt"
data <- read.csv(filePath, skip=66637, nrows=2880, na.strings = "?", header=FALSE, sep=";")

# Read the variable names
names(data) <- names(read.csv(filePath, nrows=1, sep=";"))

#Add a new column that combines and converts data$Date and data$Time as follows: 
#data$Date <- as.Date(data$Date, format="%d/%m/%y") and
#data$Time <- strptime(data$Time, format="%H:%M:%S")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Generate Plot 1
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving "Plot1.png" to file
dev.copy(png, file="./ExData_Plotting1/plot1a.png", height=480, width=480)
dev.off()