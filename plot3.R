# Read Data
DT <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Format date to Type Date
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")

# Filter data set from Feb. 1, 2007 to Feb. 2, 2007
DT <- subset(DT,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove incomplete observation
DT <- DT[complete.cases(DT),]

# Combine Date and Time column
dateTime <- paste(DT$Date, DT$Time)

# Name the vector
dateTime <- setNames(dateTime, "DateTime")

# Remove Date and Time column
DT <- DT[ ,!(names(DT) %in% c("Date","Time"))]

# Add DateTime column
DT <- cbind(dateTime, DT)

# Format dateTime Column
DT$dateTime <- as.POSIXct(dateTime)

#Plot 3
with(DT, {
       plot(Sub_metering_1~dateTime, type="l",
             +          ylab="Global Active Power (kilowatts)", xlab="")
       lines(Sub_metering_2~dateTime,col='Red')
       lines(Sub_metering_3~dateTime,col='Blue')
   })
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
                 c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save Plot
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()