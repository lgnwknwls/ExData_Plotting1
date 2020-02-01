#Code to Create plot3.png of ExData_Plotting1 assignment

#Download Data
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "householdData.zip")
  unzip("householdData.zip", overwrite = T)
}

#Read Data from .txt
library(data.table)
householdData<-read.table("household_power_consumption.txt", sep=";",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),header=TRUE,na.strings = "?")

#Clean Data for Plot 3
#Fix Date Format
householdData$Date <- as.Date(householdData$Date, "%d/%m/%Y")
#Filter Date
householdData <- subset(householdData,Date >= as.Date("2007/2/1") & Date <= as.Date("2007/2/2"))
#Get Complete Pairs
householdData <- householdData[complete.cases(householdData),]

#Organize Data for Plot 3
householdData <- data.table(householdData, dateTimeMerge = paste(householdData$Date,householdData$Time, sep = " "))

#Generate Plot 3 in PNG
png(file="plot3.png", width = 480, height = 480)
with(householdData, plot(as.POSIXct(dateTimeMerge), Sub_metering_1, type = "l", ylab="Energy sub metering",xlab="",col="black"))
with(householdData, lines(as.POSIXct(dateTimeMerge), Sub_metering_2, type = "l", ylab="Energy sub metering",xlab="",col="red"))
with(householdData, lines(as.POSIXct(dateTimeMerge), Sub_metering_3, type = "l", ylab="Energy sub metering",xlab="",col="blue"))
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()