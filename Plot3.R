
## Plot3() is a function in R and it will plot the line graphs of sub metering
## Use source("plot3.R") in R Console to source the function and run plot3()
## The input data file household_power_consumption.txt should be in the working directory

plot3 <- function() {
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
	png("./plot3.png", width = 480, height = 480, units = "px")
    
	## Plot the line graphs for all sub meterings
	plot(dataset$Date, dataset$Sub_metering_1, xlab="", 
		ylab="Energy sub metering", type = "l")
	lines(dataset$Date, dataset$Sub_metering_2, col="red")
	lines(dataset$Date, dataset$Sub_metering_3, col="blue")	
	legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           	col = c("black", "red", "blue"), lwd = .75, cex = .75)

	invisible(dev.off())

}

