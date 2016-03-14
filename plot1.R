#########################################################################################
# Exploratory Data Analysis
# Project 1
#########################################################################################

library("dplyr")
# Download data defined and after analise and tide data.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path <- paste(getwd(), "household_power_consumption.zip", sep = "/")
download.file(fileUrl, path)

#Unzip File to work
unzip(zipfile=path,exdir="./data")

setwd("./data")
path <- paste(getwd(), "household_power_consumption.txt", sep = "/")


# Read data
household_power <- read.table(path, header = TRUE,sep = ";")
household <- tbl_df(household_power)
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
# This work will work just 2 days
houseplot <- filter(household, Date == "2007-02-01" | Date == "2007-02-02")
# Define Formats
houseplot$Global_active_power <- as.numeric(as.character(houseplot$Global_active_power))
houseplot$Global_reactive_power <- as.numeric(as.character(houseplot$Global_reactive_power))
houseplot$Voltage <- as.numeric(as.character(houseplot$Voltage))

# Set graph in screen
par(mfrow=c(1,1))

# Generate Graph
hist(houseplot$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

# Salve Graph in Desktop
cat("Plot1.png has been saved in", getwd())
  

