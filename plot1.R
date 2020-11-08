library(dplyr)
library(lubridate)

my_data <- read.delim("household_power_consumption.txt",
                      sep = ";",
                      colClasses = "character",
                      nrows = 2075259,
                      stringsAsFactors = FALSE)

my_data <- my_data %>%  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
  mutate_at(vars(Global_active_power), as.numeric)


png(file = "plot1.png")
with(my_data, hist(Global_active_power,
                   main = "Global Active Power",
                   col = "red",
                   xlab = "Global Active Power (kilowatts)"))
dev.off()
