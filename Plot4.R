
## Plot4() is a function in R and it will plot the  4 line graphs 
## Use source("plot4.R") in R Console to source the function and run plot4()
## The input data file household_power_consumption.txt should be in the working directory

plot4 <- function() {
	## This function uses sqldf package (install.packages("sqldf") in R Console)
	require(sqldf)

	## Read the using read.csv.sql() from sqldf package
	dataset <- read.csv.sql("./household_power_consumption.txt", header = T, sep=";", 
				sql="select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

	## Replace the "?" with NA in the subset of the data
	dataset[dataset == "?"] <- NA 

	## Conver the data and time
	dataset[,"Date"] <-as.POSIXct(paste(dataset[,"Date"],dataset[,"Time"]), format="%d/%m/%Y %H:%M:%S")

	## Open the png device with 480x480 pixel size
	png("./plot4.png", width = 480, height = 480, units = "px")

	par(mfrow = c(2,2))

	## Plot the line graph for date+time and Global_active_power
	plot(dataset$Date, dataset$Global_active_power, xlab="", 
		ylab="Global Active Power", type = "l")
	
	## Plot the line graph for date+time and Voltage
	plot(dataset$Date, dataset$Voltage, xlab="datetime", 
		ylab="Voltage", type = "l")

	## Plot the line graphs for all sub meterings
	plot(dataset$Date, dataset$Sub_metering_1, xlab="", 
		ylab="Energy sub metering", type = "l")
	lines(dataset$Date, dataset$Sub_metering_2, col="red")
	lines(dataset$Date, dataset$Sub_metering_3, col="blue")	
	legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           	col = c("black", "red", "blue"), bty = "n", lwd = .75, cex = .75)

	## Plot the line graph for date+time and Global_reactive_power
	plot(dataset$Date, dataset$Global_reactive_power, xlab="datetime", 
		ylab="Global_reactive_power", type = "l")

	invisible(dev.off())

}

