
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

#plot graph to png in working directory
png(filename = "plot3.png",
    width = 480, height = 480)
plot(trimmed$Sub_metering_1 ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), 
	type = "l", ylab = "Energy sub metering", xlab = "")
lines(trimmed$Sub_metering_2 ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), col = "red")
lines(trimmed$Sub_metering_3 ~ ymd_hms(paste(trimmed$Date,trimmed$Time)), col = "blue")
legend("topright",lwd=1, col= c("black", "red", "blue"),
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()