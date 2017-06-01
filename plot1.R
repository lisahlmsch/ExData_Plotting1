# PLOT 1

# STEP 1: reading the data

# Dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Missing values are coded as ?.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
unzip(temp, "household_power_consumption.txt")
data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
unlink(temp)

names(data)

# STEP 2: Optimize and subset dataset
# Convert the Date and Time variables to Date/Time classes in R using the 𝚜𝚝𝚛𝚙𝚝𝚒𝚖𝚎()  and 𝚊𝚜.𝙳𝚊𝚝𝚎()functions.

data$Date <- as.Date(data$Date, "%d/%m/%Y")

data$Time <- strptime(data$Time, "%H:%M:%S")
# data$Time <- sub(".* ", "", data$Time)
# head(data)
# class(data$Time)

# Use only data from the dates 2007-02-01 and 2007-02-02. 
data.02.07 <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

# STEP 3: Create plot
# Create PNG file with a width of 480 pixels and a height of 480 pixels
# Name each of the plot files as plot1.png, plot2.png, etc.
dev.copy(png,'plot1.png',  width = 480, height = 480)

# Histogram: Frequency ~ Global Active Power (kilowatts), col = red. "Global Active Power"
par(mfrow = c(1,1))
hist(data.02.07$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()