#Code to Create plot1.png of ExData_Plotting1 assignment

#Download Data
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "householdData.zip")
  unzip("householdData.zip", overwrite = T)
}

#Read Data from .txt
library(data.table)
householdData<-read.table("household_power_consumption.txt", sep=";",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),header=TRUE,na.strings = "?")

#Clean Data for Plot 1
#Fix Date Format
householdData$Date <- as.Date(householdData$Date, "%d/%m/%Y")
#Filter Date
householdData <- subset(householdData,Date >= as.Date("2007/2/1") & Date <= as.Date("2007/2/2"))
#Get Complete Pairs
householdData <- householdData[complete.cases(householdData),]

#Generate Plot 1 in PNG
png(file="plot1.png", width = 480, height = 480)
with(householdData, hist(Global_active_power, col="red",main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))
dev.off()