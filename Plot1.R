##loading "dplyr" package
library(dplyr)

#Download the dataset from link in the Cousera instruction 
filename<-"Course Project 1.zip"

#Check the archieve of the link file
if(!file.exists(filename)){
        fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,filename,method = "curl")
}

#check whether the folder exists or not
if(!file.exists("household_power_consumption")){
        unzip(filename)
}

#Load the data into data frame
household_power<-read.table("household_power_consumption.txt",header = TRUE, sep = ';',na.strings = "?",
                            nrow=2075259,
                            check.names = FALSE, stringsAsFactors = FALSE,
                            comment.char = "")
View(household_power)

#fetch separate data for plot1
household_plot1<-filter(household_power,Date=="1/2/2007"|Date=="2/2/2007")

#set the data tyoe 
household_plot1$Date<-as.Date(household_plot1$Date,format = "%d/%m/%Y")

#the code for plot1
hist(household_plot1$Global_active_power,main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)",ylab = "Frequency",col="Red")

dev.copy(png,file="Plot1.png",height=480,width=480)
dev.off()
