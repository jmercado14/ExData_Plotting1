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
# For plot 4, plot graph of date/time vs global reactive power (and previous three graphs)
rm(feb1, feb2)
str(feb)
feb$convGAP <- as.double(as.character(feb$Global_active_power))
feb$convGRP <- as.double(as.character(feb$Global_reactive_power))
feb$DateTime <- paste(feb$Date, feb$Time, sep=" ")
feb$convDateTime <- strptime(feb$DateTime, format="%d/%m/%Y %H:%M:%S")
head(feb)

# prep for plotting four plots
par(mfrow=c(2,2))

# plot 2
with(feb, plot(convDateTime, convGAP, type="l", xlab="", ylab="Global Active Power (kilowatts)"))


# new plot (datetime by voltage)
with(feb, plot(convDateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# plot 3
with(feb, plot(convDateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(feb, points(convDateTime, Sub_metering_1, type="l", col="black"))
with(feb, points(convDateTime, Sub_metering_2, type="l", col="red"))
with(feb, points(convDateTime, Sub_metering_3, type="l", col="blue"))
with(feb, legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=.7, bty="n", lty="solid", col=c("black", "red", "blue")))

# plot 4
with(feb, plot(convDateTime, convGRP, type="l",xlab="datetime", ylab="Global_reactive_power"))

# Name each of the plot files as plot1.png, plot2.png, etc.
png("Plot4.png")
# prep for plotting four plots
par(mfrow=c(2,2))

# plot 2
with(feb, plot(convDateTime, convGAP, type="l", xlab="", ylab="Global Active Power (kilowatts)"))


# new plot (datetime by voltage)
with(feb, plot(convDateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# plot 3
with(feb, plot(convDateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(feb, points(convDateTime, Sub_metering_1, type="l", col="black"))
with(feb, points(convDateTime, Sub_metering_2, type="l", col="red"))
with(feb, points(convDateTime, Sub_metering_3, type="l", col="blue"))
with(feb, legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=.7, bty="n", lty="solid", col=c("black", "red", "blue")))

# plot 4
with(feb, plot(convDateTime, convGRP, type="l",xlab="datetime", ylab="Global_reactive_power"))
dev.off()
