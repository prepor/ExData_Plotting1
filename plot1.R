library(sqldf)
library(graphics)
library(grDevices)

# partially load file https://class.coursera.org/exdata-002/forum/thread?thread_id=47 
# http://r.789695.n4.nabble.com/How-to-set-a-filter-during-reading-tables-td893857.html
data <- read.csv2.sql("household_power_consumption.txt", "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'")

png(filename = "plot1.png", width = 480, height = 480)

hist(data$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowats)")

dev.off()