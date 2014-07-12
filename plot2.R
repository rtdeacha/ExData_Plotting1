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
png(file = "plot2.png", width = 480, height = 480, units = "px")

with(data, plot(DateTime, Global_active_power, type="l", xlab ="", ylab = "Global Active Power (kilowatts)"))

## Close the graphic device
## With dev.off() I was getting a null device 1 output
## graphics.off() calls dev.off() and doesn't return the message.
graphics.off()