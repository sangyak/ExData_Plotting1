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

#print to png this time
png("plot3.png")  
plot (test$dateTime,test$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines (test$dateTime,test$Sub_metering_2,type = "l", col = "red")
lines (test$dateTime,test$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),pt.cex = .05,cex=.5,lwd=4)
dev.off()
