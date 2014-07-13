#download & unzip file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="./power.zip",method="curl")
unzip("./power.zip") # text file created, how do i know its name?
list.files() #list of files in wd\

#memory estimate: 2,075,259 rows, 9 columns
bytes<-2075259 * 9 * 8 #8 bytes/numeric
MB = bytes/(2^20) #bytes per mb --> MB
MB/1000 #GB

#load subset of data to R
library("RMySQL")  
library("sqldf")
test<-read.csv2.sql("household_power_consumption.txt",sql="SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'",sep=";",na.strings="?" )

#create timestamp column
test$dateTime <- strptime(paste(test$Date, test$Time), "%d/%m/%Y %H:%M:%S") 

#set grid
par(mfrow=c(2,2)) 

#create plots
plot(test$dateTime,test$Global_active_power, type ='l', xlab="",ylab ="Global Active Power")
plot( test$dateTime, test$Voltage, type = "l",xlab = "dateTime", ylab = "Voltage")
plot (test$dateTime,test$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines (test$dateTime,test$Sub_metering_2,type = "l", col = "red")
lines (test$dateTime,test$Sub_metering_3,type = "l", col = "blue")
plot( test$dateTime, test$Global_reactive_power, type = "l",xlab = "dateTime", ylab = "Global_reactive_power")

#copy to png
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
