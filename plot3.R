library(dplyr)
library(tidyr)
library(lubridate)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,mode="wb")
unzip(temp, "household_power_consumption.txt")
data <- read.csv("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors = F)
data <- filter(data,Date == "1/2/2007" | Date =="2/2/2007")


data <- unite(data,dateTime, Date, Time, sep=" ")
data$dateTime <- data$dateTime %>% strptime("%d/%m/%Y %H:%M:%S")

with(data,plot(dateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type = "n"))
with(data,lines(dateTime,Sub_metering_1,col="black"))
with(data,lines(dateTime,Sub_metering_2,col="red"))
with(data,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",lwd=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, file="plot3.png")
dev.off()