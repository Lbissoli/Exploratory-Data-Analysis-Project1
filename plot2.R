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

# Set graph in screen
par(mfrow=c(1,1))

# Generate Graph
plot(houseplot$timestamp,houseplot$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

# Salve Graph in Desktop
cat("Plot2.png has been saved in", getwd())