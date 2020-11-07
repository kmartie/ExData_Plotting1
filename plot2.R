library(dplyr)
library(lubridate)

Sys.setlocale("LC_TIME", "English")

data <- read.delim("household_power_consumption.txt",
                    sep = ";",
                    colClasses = "character",
                    nrows = 2075259,
                    stringsAsFactors = FALSE)

my_data <- data %>%  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
  mutate_at(vars(Global_active_power), as.numeric) %>% 
  mutate_at(vars(Date), ~dmy_hms(paste(Date, Time), tz = "America/New_York"))
 
png(file = "plot2.png") 
with(my_data, plot(Date, Global_active_power,
                   ylab = "Global Active Power (kilowatts)",
                   xlab = "",
                   type = "l"))
dev.off()
