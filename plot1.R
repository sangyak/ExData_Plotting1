url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="./power.zip",method="curl")
unzip("./power.zip") # text file created, how do i know its name?
list.files() #list of files in wd
#memory estimate: 2,075,259 rows, 9 columns
bytes<-2075259 * 9 * 8 #8 bytes/numeric
MB = bytes/(2^20) #bytes per mb --> MB
MB/1000 #GB
#load subset of data to R
library("RMySQL")  
library("sqldf")
test<-read.csv2.sql("household_power_consumption.txt",sql="SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'",sep=";",na.strings="?" )
test$dateTime <- strptime(paste(test$Date, test$Time), "%d/%m/%Y %H:%M:%S") #new timestamp
hist(test$Global_active_power,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="Red")
dev.copy(png, file = "plot1.png", width=480, height=480, units="px") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!