library(sqldf)
library(graphics)
library(grDevices)

# partially load file https://class.coursera.org/exdata-002/forum/thread?thread_id=47 
# http://r.789695.n4.nabble.com/How-to-set-a-filter-during-reading-tables-td893857.html
data <- read.csv2.sql("household_power_consumption.txt", "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'")

data1 <- within(data, datetime <- strptime(paste(Date, Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

with(data1, plot(datetime, Global_active_power, 
                 type = "l", 
                 ylab = "Global Active Power", 
                 xlab = NA))
with(data1, plot(datetime, Voltage, 
                 type = "l", 
                 ylab = "Voltage"))

with(data1, {
  lines <- list(list(title = "Sub_metering_1", 
                     color = "black", 
                     data = Sub_metering_1),
                list(title = "Sub_metering_2", 
                     color = "red", 
                     data = Sub_metering_2),
                list(title = "Sub_metering_3", 
                     color = "blue", 
                     data = Sub_metering_3))
  plot(rep(datetime, length(lines)), 
       do.call(c, lapply(lines, function(l) l$data)), 
       type = "n", 
       ylab = "Energy sub metering", xlab = NA)
  
  for (l in lines) {
    lines(datetime, l$data, col = l$color)
  }
  
  legend("topright", legend = sapply(lines, function(l) l$title),
         bty = "n",
         lty = rep(1, length(lines)), 
         lwd = rep(1, length(lines)), 
         col = sapply(lines, function(l) l$color))
})

with(data1, plot(datetime, Global_reactive_power, type = "l"))

dev.off()