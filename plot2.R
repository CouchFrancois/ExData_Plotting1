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

plot(data$dateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.copy(png, file="plot2.png")
dev.off()