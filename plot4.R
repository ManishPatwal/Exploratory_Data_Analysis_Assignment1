library(lubridate)
library(dplyr)

#Setworkingdirectory
setwd("C:/Users/mp64310/Desktop/R_Programming/04_EDA/Week1")

#Download File and Create folder in current director

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Dataset.zip")
unzip("./Dataset.zip")
#Read Training set
EPC<-read.table("household_power_consumption.txt",stringsAsFactors = FALSE, header = TRUE, sep =";")
View(EPC)

# Merge Time and Date Together
TimeDate <- strptime(paste(EPC$Date, EPC$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
EPC<-cbind(EPC,TimeDate)
View(EPC)
#check class and Dim of Variables in EPC
str(EPC)
#get class of all the variables in the dataframe
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")
EPC$Time <- format(EPC$Time, format="%H:%M:%S")
EPC$Global_active_power <- as.numeric(EPC$Global_active_power)
EPC$Global_reactive_power <- as.numeric(EPC$Global_reactive_power)
EPC$Voltage <- as.numeric(EPC$Voltage)
EPC$Global_intensity <- as.numeric(EPC$Global_intensity)
EPC$Sub_metering_1 <- as.numeric(EPC$Sub_metering_1)
EPC$Sub_metering_2 <- as.numeric(EPC$Sub_metering_2)
EPC$Sub_metering_3 <- as.numeric(EPC$Sub_metering_3)

#subsetEPC
EPC_subset <- subset(EPC, Date == "2007-02-01" | Date =="2007-02-02")
View(EPC_subset)

#set pixles for the image and name it
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Createsdesired graph
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(EPC_subset,{plot(Global_active_power~TimeDate, type="l",ylab="Global Active Power (kilowatts)", xlab="")
            plot(Voltage~TimeDate, type="l",ylab="Voltage (volt)", xlab="")
            plot(Sub_metering_1~TimeDate, type="l",ylab="Global Active Power (kilowatts)", xlab="")
            lines(Sub_metering_2~TimeDate,col='Red')
            lines(Sub_metering_3~TimeDate,col='Blue')
            legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
            plot(Global_reactive_power~TimeDate, type="l", 
            ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()
