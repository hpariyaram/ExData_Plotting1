
## Plot1() is a function in R and it will plot the histogram for Global Active Power 
## Use source("plot1.R") in R Console to source the function and run plot1()
## The input data file household_power_consumption.txt should be in the working directory

plot1 <- function() {
	## This function uses sqldf package (install.packages("sqldf") in R Console)
	require(sqldf)

	## Read the using read.csv.sql() from sqldf package
	dataset <- read.csv.sql("./household_power_consumption.txt", header = T, sep=";", 
				sql="select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

	## Replace the "?" with NA in the subset of the data
	dataset[dataset == "?"] <- NA 
	
	png("./plot1.png", width = 480, height = 480, units = "px")
    
	## Plot the histogram for Global_active_power
	hist(dataset$Global_active_power,breaks=12,col="red", xlab="Global Active Power (kilowatts)", 
			main="Global Active Power")
	invisible(dev.off())

}