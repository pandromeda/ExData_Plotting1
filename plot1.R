## This script uses the data from the dates 2007-02-01 and 2007-02-02 in "Electric power consumption" (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) to plot histogram for Global Active Power (kilowatts) to a png file.
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

## Plot histogram for global active power to png file

png(filename = "plot1.png",width = 480, height = 480)
hist(extractDataPlot$Global_active_power,breaks=12,col="red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

## End of code