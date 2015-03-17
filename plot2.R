# Author: Peter W Setter
# Purpose: Create a graph of the total PM2.5 emissions in Baltimore City, Maryland
# by year using base plotting system
# Inputs: nei (data frame of National Emission Inventory Data)
# Output: png file of graph

# dplyr for data manipulation
library(dplyr)

# Load data
source('obtaindata.R')

# Summarise the total amount of PM2.5 by year for Baltimore City, Maryland
baltimore.by.year <- nei %>%
        filter(fips == 24510) %>%
        group_by(year) %>%
        summarize(total.emissions = sum(Emissions))

# Create plot as a png file
png(filename = 'plot2.png')
plot(x = baltimore.by.year$year, y = baltimore.by.year$total.emissions,
     type = 'b',
     main = 'Total PM2.5 Emissions by Year (Baltimore City, MD)',
     xlab = 'Year',
     ylab = 'PM2.5 Emissions (Tons)')
dev.off()