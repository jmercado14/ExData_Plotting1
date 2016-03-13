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
# For plot 1, plot histogram of global active power
rm(feb1, feb2)
str(feb)
feb$convGAP <- as.double(as.character(feb$Global_active_power))
with(feb, hist(convGAP, xlab = "Global Active Power (kilowatts)", main = "Global Active Power",
               col = "red"))

# Name each of the plot files as plot1.png, plot2.png, etc.
png("Plot1.png")
with(feb, hist(convGAP, xlab = "Global Active Power (kilowatts)", main = "Global Active Power",
               col = "red"))
dev.off()
