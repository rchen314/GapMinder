# Set up libraries
#install.packages("lubridate")
library(dplyr)
library(ggplot2)
library(lubridate)

# Read data file
bd <- read.csv("friends_birthdays.csv", header = TRUE)

# Find birthday most commonly used
qplot(x = Start.Date, data=bd, binwidth = 1) 
bd %>% group_by(Start.Date) %>% summarise(num_friends = n()) %>%
  filter(num_friends == 3)

# Add month column
bd[,2] <- mdy(bd[,2])
bd <- mutate(bd, birthMonth = month(Start.Date))

# Plot # of birthdays in each month
qplot(x = birthMonth, data=bd, binwidth = 1) +
  scale_x_continuous(limit = c(1, 13), breaks = seq(1, 13, 1))


