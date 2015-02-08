
## Plot2() is a function in R and it will plot the line graph 
## Use source("plot2.R") in R Console to source the function and run plot2()
## The input data file household_power_consumption.txt should be in the working directory

plot2 <- function() {
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
	png("./plot2.png", width = 480, height = 480, units = "px")
    
	## Plot the line graph for date+time and Global_active_power
	plot(dataset$Date, dataset$Global_active_power, xlab="", 
		ylab="Global Active Power (Kilowatts)", type = "l")

	invisible(dev.off())

}

