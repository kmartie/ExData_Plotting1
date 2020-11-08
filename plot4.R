library(dplyr)
library(lubridate)

Sys.setlocale("LC_TIME", "English")

data <- read.delim("household_power_consumption.txt",
                   sep = ";",
                   colClasses = "character",
                   nrows = 2075259,
                   stringsAsFactors = FALSE)

my_data <- data %>%  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
  mutate_at(vars(3:9), as.numeric) %>% 
  mutate_at(vars(Date), ~dmy_hms(paste(Date, Time)))

png(file = "plot4.png")

par(mfrow = c(2,2))

with(my_data, plot(Date, Global_active_power,
                   type = "l",
                   xlab = "",
                   ylab = "Global active power"))

with(my_data, plot(Date, Voltage,
                   type = "l",
                   xlab = "datetime",
                   ylab = "Voltage"))

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
       bty = "n",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)

with(my_data, plot(Date, Global_reactive_power,
                   type = "l",
                   xlab = "datetime"))

dev.off()
