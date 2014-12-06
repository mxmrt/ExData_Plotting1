
# check to see if require packages are installed
# install if needed
if(require(dplyr) == FALSE) {install.packages("dplyr")}
if(require(lubridate) == FALSE) {install.packages("lubridate")}

# load data, convert to a tbl_df
# convert date and time column values to "POSIXct" "POSIXt" 
data <- read.csv(file = "household_power_consumption.txt",
	header = TRUE,sep = ";",stringsAsFactors=FALSE)
data <- tbl_df(data)
data$Date <- dmy(data$Date)

# trim the data to the desired time period
trimmed <- filter(data, Date <= ymd("2007-02-02") & Date >= ymd("2007-02-01"))

# convert Global_active_power to numeric
trimmed$Global_active_power<- as.numeric(trimmed$Global_active_power)

# set up graphical parameters
par(mar=c(5,4,2,2), mfcol = c(2,2))


#plot for 1st row 1st column 
plot(trimmed$Global_active_power ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), 
	type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")


#plot for 2nd row 1st column 
plot(trimmed$Sub_metering_1 ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), 
	type = "l", ylab = "Energy sub metering", xlab = "")
lines(trimmed$Sub_metering_2 ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), col = "red")
lines(trimmed$Sub_metering_3 ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), col = "blue")
legend("topright",lwd=1, col= c("black", "red", "blue"), bty = "n",
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))



#plot for 1st row 2nd column 
plot(trimmed$Voltage ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), 
	type = "l", ylab = "Voltage", xlab = "datetime")




#plot for 2nd row 2nd column 
plot(trimmed$Global_reactive_power ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), 
	type = "l", ylab = "Global_reactive_power", xlab = "datetime")


dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()