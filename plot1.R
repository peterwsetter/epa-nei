# Author: Peter W Setter
# Purpose: Create a graph of the total PM2.5 emissions by year using base plotting system
# Inputs: nei (data frame of National Emission Inventory Data)
# Output: png file of graph

# dplyr for data manipulation
library(dplyr)

# Load data
source('obtaindata.R')

# Summarise the total amount of PM2.5 by year
total.by.year <- nei %>%
                group_by(year) %>%
                summarize(total.emissions = sum(Emissions))

# Create plot as a png file
png(filename = 'plot1.png')
plot(x = total.by.year$year, y = total.by.year$total.emissions,
     type = 'b',
     main = 'Total PM2.5 Emissions by Year (United States)',
     xlab = 'Year',
     ylab = 'PM2.5 Emissions (Tons)')
dev.off()