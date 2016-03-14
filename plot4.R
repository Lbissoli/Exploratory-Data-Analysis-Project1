#########################################################################################
# Exploratory Data Analysis
# Project 1
#########################################################################################

library("dplyr")
# Read data
household_power <- read.table("household_power_consumption.txt",header = TRUE,sep = ";")
household <- tbl_df(household_power)
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
# This work will work just 2 days
houseplot <- filter(household, Date == "2007-02-01" | Date == "2007-02-02")
# Define Formats
houseplot$Global_active_power <- as.numeric(as.character(houseplot$Global_active_power))
houseplot$Global_reactive_power <- as.numeric(as.character(houseplot$Global_reactive_power))
houseplot$Voltage <- as.numeric(as.character(houseplot$Voltage))

# Define Timestamp
houseplot <- mutate(houseplot, timestamp = paste(Date,Time))
houseplot <- transform(houseplot, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
# Define Formats
houseplot$Sub_metering_1 <- as.numeric(as.character(houseplot$Sub_metering_1))
houseplot$Sub_metering_2 <- as.numeric(as.character(houseplot$Sub_metering_2))
houseplot$Sub_metering_3 <- as.numeric(as.character(houseplot$Sub_metering_3))

# Set graph in screen
par(mfrow=c(2,2))

#PLOT 1
plot(houseplot$timestamp,houseplot$Global_active_power, type="l", xlab="", ylab="Global Active Power")
#PLOT 2
plot(houseplot$timestamp,houseplot$Voltage, type="l", xlab="datetime", ylab="Voltage")
#PLOT 3
plot(houseplot$timestamp,houseplot$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(houseplot$timestamp,houseplot$Sub_metering_2,col="red")
lines(houseplot$timestamp,houseplot$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
lty=c(1,1), bty="n", cex=.5)
#PLOT 4
plot(houseplot$timestamp,houseplot$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

# Salve Graph in Desktop
cat("Plot4.png has been saved in", getwd())