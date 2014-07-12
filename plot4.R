## lOADING DATA
file <- "household_power_consumption.txt"

## load the dataset
data <- read.table(file, header = T, sep =";", dec=".", na.strings= '?', 
                   colClasses=c(rep("character",2), rep("numeric",7)))
## SUBSETTING DATES
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

## Fix data types of Date & Time and Add a new variable
data$DateTime<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

## Open graphic device
png(file = "plot4.png", width = 480, height = 480, units = "px")

## rearrange a 2 x 2 plot canvas
par(mfrow = c(2,2))

## PLOT 1

with(data, plot(DateTime, Global_active_power, type="l", xlab ="", ylab = "Global Active Power"))

## PLOT 2

with(data, plot(DateTime, Voltage, type="l", xlab ="datetime", ylab = "Voltage"))

## PLOT 3

plot(data$DateTime, data$Sub_metering_1, type="n", xlab ="", ylab = "Energy sub metering")
points(data$DateTime, data$Sub_metering_1, type = "l")
points(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
points(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch= "_", col = c("black", "red", "blue"), bty ="n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## PLOT 4

with(data, plot(DateTime, Global_reactive_power, type="l", xlab ="datetime", 
                ylab = "Global_reactive_power"))

## Close the graphic device
## With dev.off() I was getting a null device 1 output
## graphics.off() calls dev.off() and doesn't return the message.
graphics.off()