
#Setworkingdirectory
setwd("C:/Users/mp64310/Desktop/R_Programming/04_EDA/Week1")


#Download File and Create folder in current director

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Dataset.zip")
unzip("./Dataset.zip")
#Read Training set
EPC<-read.table("household_power_consumption.txt",stringsAsFactors = FALSE, header = TRUE, sep =";")
str(EPC)
View(EPC)
library(lubridate)
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
png("plot1.png", width=480, height=480)

#plot histogram
hist((EPC_subset$Global_active_power), col="red", border="black",main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()