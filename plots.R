# setting up the working directory
setwd("C:\\Users\\Username\\Documents\\specdata")

# load the package data.table
library(data.table)

# load the dataset household power consumption
datasetHPC<-read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, dec=".")

# extracting data with date 1/2/2007 and 2/2/2007 from the dataset
neededData<-datasetHPC[datasetHPC$Date %in% c("1/2/2007","2/2/2007"), ]

# convert the value of Date and Time in the dataset as Date/Time Classes
converted_date_time<-strptime(paste(neededData$Date, neededData$Time, sep =" "), "%d/%m/%Y %H:%M:%S")

# defining function plot1 the will plot the frequency of Global Active Power in histogram
plot1<-function(x){
  hist(x, col = "red", main = "Global Active Power" , xlab =  "Global Active Power (kilowatts)")
}
# X is a numeric vector that contains the value 
# that will be plot in a histogram with red columns, with title "Global Active Power" 
# and the name of x axis is "Global Active Power (kilowatts)"

# defining function plot2 the will plot the Global Active Power based on specified time and data
# defining function plot4 the will plot the a given set of data given based on specified time and data
plot2<-function(x, y, xlabel, ylabel){
  plot(x, y, type = "l", xlab = xlabel , ylab = ylabel)
}
# X is a list that contains the dataset of date and time, and
# Y is a numeric vector that contains the value
# that will be plot in a line type scatter plot in which the values in X the x-axis
# and the values Y in the Y axis. The label of the y -axis is "Global Active Power (kilowatts)")
# defining function plot3 the will plot the Sub metering of energy, based on specified time and data

plot3<-function(main, x, y, z, labels){
  plot(main, x, type="l", xlab="", ylab="Energy sub metering")
  lines(main, y, col = "red")
  lines(main,  z, col = "blue")
  legend("topright", labels, lty = 1, lwd = 1, col = c("black", "red", "blue"))
}
# Main is a list that contains the dataset of date and time, and
# X, Y, Z are numeric vectors that contains the value
# that will be plot in a line type scatter plot, in which the values in Main is in the x-axis
# and the values X, Y, Z  in the Y axis. The label of the y -axis is "Global Active Power (kilowatts)")
# The last line is function that shows the legend of data in the plot
# black lines for X while Red line for Y, and Blue line for Z

# globalActivePower is a numeric vector with values from the globalActivePower in the neededData dataset
globalActivePower<-as.numeric(neededData$Global_active_power)

#opened a PNG graphing device
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

# call the function plot1
plot1(globalActivePower)

#closed the PNG graphing device
dev.off()

#opened a PNG graphing device
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

# call the function plot2
plot2(converted_date_time, globalActivePower, "", "Global Active Power (kilowats")

#closed a PNG graphing device
dev.off()

# submetering 1-3 are numeric vector with values from the submeters in the neededData dataset
Submetering_1<-as.numeric(neededData$Sub_metering_1)
Submetering_2<-as.numeric(neededData$Sub_metering_2)
Submetering_3<-as.numeric(neededData$Sub_metering_3)

# labels is a character vector that contains the label for the legends
labels<-c("Submetering_1", "Submetering_2", "Submetering_3")

#opened a PNG graphing device
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

# call the function plot2
plot3(converted_date_time, Submetering_1, Submetering_2, Submetering_3, labels)

#close the PNG graphing device
dev.off()

#globalReactivePower is a numeric vector with values from globalReactivePower in the neededData dataset
globalReactivePower<-as.numeric(neededData$Global_reactive_power)

# voltage is a numeric vector with values from voltage in the neededData dataset
voltage<-as.numeric(neededData$Voltage)

#opened a PNG graphing device
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

# set the graphical parameters of the graphing device
par(mfrow=c(2,2))

# calling the functions plot1, plot2 and plot3
plot1(globalActivePower)
plot2(converted_date_time, voltage, "datetime", "voltage")
plot3(converted_date_time, Submetering_1, Submetering_2, Submetering_3, labels)
plot2(converted_date_time, globalReactivePower,"datetime", "global_Reactive_Power")

#closed the PNG graphing device
dev.off()

