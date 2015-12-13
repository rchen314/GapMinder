# Set up libraries
library(dplyr)
library(ggplot2)

# Read data file
cp <- read.csv("cell_phone_total.csv", header = TRUE)

# Rename column 1 title
colnames(cp)[1] = "Country"

# Filter out any countries without 2011 data, any data before 1980
cpf <- cp %>% filter(!is.na(X2011))
cpf <- cpf %>% select(Country, Region, 
                      starts_with("X198"), starts_with("X199"), 
                      starts_with("X20") )

# Compare overall usage for most recent year for each region
qplot(x=as.factor(Region), y=X2011, data=cpf, geom="boxplot")
qplot(x=as.factor(Region), y=log10(X2011), data=cpf, geom="boxplot")

# Generate year-on-year increase for 2011 and do a boxplot by region
cpf <- mutate(cpf, pctIncrease = ((X2011 - X2010)/X2010)*100)
qplot(x=as.factor(Region), y=pctIncrease, data=cpf, geom="boxplot")

# Calculate total usage by region
regions <- cpf %>% group_by(Region) %>% summarise(total=sum(as.numeric(X2011)))
plot(regions)

# Show histogram of usage for all countries
qplot(x=log10(X2011), data=cpf)


