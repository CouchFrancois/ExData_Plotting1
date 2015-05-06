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

par(mfrow = c(2,2))
par(cex = .65)
plot(data$dateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(data$dateTime,data$Voltage,type="l",xlab="datetime",ylab="Voltage")

with(data,plot(dateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type = "n"))
with(data,lines(dateTime,Sub_metering_1,col="black"))
with(data,lines(dateTime,Sub_metering_2,col="red"))
with(data,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",lwd=1,cex=.85, col = c("black","red","blue"), bty = "n",  xjust=1, yjust=1,text.width=strwidth("1,000,000"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(data$dateTime,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.copy(png, file="plot4.png")
dev.off()