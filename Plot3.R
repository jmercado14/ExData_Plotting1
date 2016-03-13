# Load data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, mode="wb")
unzip(temp)
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
names(data)
str(data)
head(data)
data$convDate = as.Date(data$Date, "%d/%m/%Y")
feb1 <- data[data$convDate==as.Date("01/02/2007", "%d/%m/%Y"),]
feb2 <- data[data$convDate==as.Date("02/02/2007", "%d/%m/%Y"),]
feb <- rbind(feb1, feb2)
rm(data)

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# For plot 2, plot graph of date/time vs global active power
rm(feb1, feb2)
str(feb)
feb$convGAP <- as.double(as.character(feb$Global_active_power))
feb$DateTime <- paste(feb$Date, feb$Time, sep=" ")
feb$convDateTime <- strptime(feb$DateTime, format="%d/%m/%Y %H:%M:%S")
head(feb)

with(feb, plot(convDateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(feb, points(convDateTime, Sub_metering_1, type="l", col="black"))
with(feb, points(convDateTime, Sub_metering_2, type="l", col="red"))
with(feb, points(convDateTime, Sub_metering_3, type="l", col="blue"))
with(feb, legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="solid", col=c("black", "red", "blue")))

# Name each of the plot files as plot1.png, plot2.png, etc.
png("Plot3.png")
with(feb, plot(convDateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(feb, points(convDateTime, Sub_metering_1, type="l", col="black"))
with(feb, points(convDateTime, Sub_metering_2, type="l", col="red"))
with(feb, points(convDateTime, Sub_metering_3, type="l", col="blue"))
with(feb, legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="solid", col=c("black", "red", "blue")))
dev.off()
