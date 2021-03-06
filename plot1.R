
# check to see if require packages are installed
# install if needed
if(require(dplyr) == FALSE) {install.packages("dplyr")}
if(require(lubridate) == FALSE) {install.packages("lubridate")}

# load data, convert to a tbl_df
# convert date column values to "POSIXct" "POSIXt" 
data <- read.csv(file = "household_power_consumption.txt",
	header = TRUE,sep = ";",stringsAsFactors=FALSE)
data <- tbl_df(data)
data$Date <- dmy(data$Date)


# trim the data to the desired time period
trimmed <- filter(data, Date <= ymd("2007-02-02") & Date >= ymd("2007-02-01"))

# convert Global_active_power to numeric
trimmed$Global_active_power<- as.numeric(trimmed$Global_active_power)

#plot histogram to png in working directory
png(filename = "plot1.png",
    width = 480, height = 480)
hist(trimmed$Global_active_power, col = "red", 
	main = "Global Active Power", xlab = "Global Active Power (kilowatts")

dev.off()