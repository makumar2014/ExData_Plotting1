# Code for PLOT3,PNG
# setwd("ExData_Plotting1/") if needed

# Download the dataset zip file if not already downloaded
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "IHEPC.zip"
if(!file.exists(filename)) {
    download.file(dataset_url, filename)
}
unzip(filename)

# Read into a Data Frame, transform and subset to prepare final data for graphs
IHEPC_data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
IHEPC_formatted <- IHEPC_data
IHEPC_formatted$Date <- as.Date(IHEPC_formatted$Date, format="%d/%m/%Y")
IHEPC_subset <- IHEPC_formatted[IHEPC_formatted$Date=="2007-02-01"|IHEPC_formatted$Date=="2007-02-02", ]
IHEPC_subset$Time <- as.POSIXct(paste(IHEPC_subset$Date, IHEPC_subset$Time))

# Plot the graph
with(IHEPC_subset, {
    plot(Time, Sub_metering_1, type="l", col="black", ylab="Energy sub metering")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Create the image
output <- "plot3.png"
dev.copy(png, file=output, width=480, height=480)
dev.off()
