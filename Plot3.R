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

##loading "dplyr" package
library(dplyr)

#fetch separate data for plot1
household_plot1<-filter(household_power,Date=="1/2/2007"|Date=="2/2/2007")

#set the data tyoe 
household_plot1$Date<-as.Date(household_plot1$Date,format = "%d/%m/%Y")
timedata<-paste(as.Date(household_plot1$Date),household_plot1$Time)
household_plot1$Timedata<-as.POSIXct(timedata)

#the code for plot3#
with(household_plot1,{
        plot(Sub_metering_1~Timedata,type="l",
             ylab = "Global Active Power (kilowatts)",xlab="")
        lines(Sub_metering_2~Timedata,col="Red")
        lines(Sub_metering_3~Timedata,col="Blue")
}
     )
legend("topright",col = c("Black","Red","Blue"),lty = 1,lwd = 2,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file="Plot3.png",height=480,width=480)
dev.off()