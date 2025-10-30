## Course Project 1 ##
## Plot 1 ##

getwd()

# 1. Load & install packages #
install.packages("lubridate")
library(lubridate)

install.packages("dplyr")
library(dplyr)

# 2. Load data into R #
PowerData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

dim(PowerData)
head(PowerData)
summary(PowerData)
colnames(PowerData)

# 3. Clean data #
#Create datetime
PowerData$DateTime <- dmy_hms(paste(PowerData$Date, PowerData$Time))
print(PowerData$DateTime)
print(class(PowerData$DateTime))

#Create day of the week
PowerData$Day <- wday(PowerData$DateTime, abbr=TRUE)
print(PowerData$Day)
print(class(PowerData$Day))

#Date
PowerData$Date <- dmy(PowerData$Date)
print(PowerData$Date)
print(class(PowerData$Date))

#Time
PowerData$Time <- hms(PowerData$Time)
print(PowerData$Time)
print(class(PowerData$Time))

#Change character variables to numeric
PowerData <- PowerData %>%
  mutate(across(c(Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2), as.numeric))

summary(PowerData)

# 4. Remove rows with NA data #
PowerData_NoNA <- na.omit(PowerData)
summary(PowerData_NoNA)

# 3. Create plot #
png(file = "plot1.png", width = 480, height = 480, units = "px") 
with(subset(PowerData, Date == "2007-02-01" | Date == "2007-02-02"), hist(
  Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
