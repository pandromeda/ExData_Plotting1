## This script uses the data from the dates 2007-02-01 and 2007-02-02 in "Electric power consumption" (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) to plot the following 4 graphs in 2x2:
## topleft: line for global active power by minute;
## topright: line for voltage by minute;
## bottomleft: energy for each of the 3 sub-meters by minute;
## bottomright: line for global reactive power by minute.

## Workdirectory is set within the downloaded folder \exdata_data_household_power_consumption .

## Read data file
## For reading the file faster, read first 5 rows to get colclass, set comment.char to "" and set nrows

tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", as.is = TRUE,  nrows = 5)
classes <- sapply(tab5rows, class)
electricData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?", as.is = TRUE, comment.char = "", nrows = 2080000)

## Extract data for only 2007-02-01 and 2007-02-02, connect date and time then change format (not sure about the timezone so set to GMT), and add datetime to the first column of the original data

extractData <- subset(electricData, Date %in% c("1/2/2007","2/2/2007"))

dateplustime<-paste(extractData$Date,extractData$Time)
Datetime <- strptime(dateplustime, "%d/%m/%Y %H:%M:%S", tz="GMT")

extractDataPlot<-cbind(Datetime,extractData[,c(3:9)])

## plot 4 graphs 2 x 2 to png file:
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow= c(2,2))

## 1. topleft: line for global active power by minute

plot(extractDataPlot$Datetime,extractDataPlot$Global_active_power,type = "l",ylab = "Global Active Power", xlab = "")

## 2. topright: line for voltage by minute

plot(extractDataPlot$Datetime,extractDataPlot$Voltage,type = "l",ylab = "Voltage", xlab = "datetime")

# 3. bottomleft: line for each of the 3 sub-meters by minute to png file

## Set line color and legend label
cols <- c("black", "red", "blue")
labels<- colnames(extractDataPlot[,c(6:8)])

## Plot first line then add another 2
plot(extractDataPlot$Datetime,extractDataPlot$Sub_metering_1,type = "l", col=cols[1], ylab = "Energy sub metering", xlab = "")
lines(extractDataPlot$Datetime,extractDataPlot$Sub_metering_2, col=cols[2])
lines(extractDataPlot$Datetime,extractDataPlot$Sub_metering_3, col=cols[3])

## Add legend
legend("topright",legend = labels,col=cols,lty=1,bty="n")

## 4. bottomright: line for global reactive power by minute
plot(extractDataPlot$Datetime,extractDataPlot$Global_reactive_power,type = "l",ylab = "Global_reactive_power", xlab = "datetime")


dev.off()

## End of code