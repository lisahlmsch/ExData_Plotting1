# PLOT 3

# STEP 1: reading the data

# Dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Missing values are coded as ?.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
unzip(temp, "household_power_consumption.txt")
data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
unlink(temp)

# STEP 2: Optimize and subset dataset
# Convert the Date and Time variables to Date/Time classes in R using the 𝚜𝚝𝚛𝚙𝚝𝚒𝚖𝚎()  and 𝚊𝚜.𝙳𝚊𝚝𝚎()functions.
# Use only data from the dates 2007-02-01 and 2007-02-02. 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(data$Time, format="%H:%M:%S")

data.02.07 <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

data.02.07[1:1440,"Time"] <- format(data.02.07[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data.02.07[1441:2880,"Time"] <- format(data.02.07[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# STEP 3: Create plot

# Create PNG file with a width of 480 pixels and a height of 480 pixels
# Name each of the plot files as plot1.png, plot2.png, etc.
dev.copy(png,'plot3.png',  width = 480, height = 480)

# Lineplot: Energy sub metering ~ Days of the Week. 
# Legend in top right: black = Sub_metering_1, red = Sub_metering_2, blue = Sub_metering_3
par(mfrow = c(1,1))
plot(data.02.07$Sub_metering_1 ~ data.02.07$Time, type = "l", xlab="", ylab="Energy sub metering)")
lines(data.02.07$Sub_metering_2 ~ data.02.07$Time, , type = "l", col = "red")
lines(data.02.07$Sub_metering_3 ~ data.02.07$Time, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))     

dev.off()