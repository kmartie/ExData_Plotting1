library(dplyr)
library(lubridate)

Sys.setlocale("LC_TIME", "English")

data <- read.delim("household_power_consumption.txt",
                   sep = ";",
                   colClasses = "character",
                   nrows = 2075259,
                   stringsAsFactors = FALSE)

my_data <- data %>%  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
  mutate_at(vars(c(Sub_metering_1, Sub_metering_2, Sub_metering_3)), as.numeric) %>% 
  mutate_at(vars(Date), ~dmy_hms(paste(Date, Time)))

png(file = "plot3.png")

with(my_data, plot(Date, Sub_metering_1,
                   type = "l",
                   ylab = "Energy sub metering",
                   xlab = ""))

with(my_data, points(Date, Sub_metering_2,
                     type = "l",
                     col = "red"))

with(my_data, points(Date, Sub_metering_3,
                     type = "l",
                     col = "blue"))

legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)
     
dev.off()
