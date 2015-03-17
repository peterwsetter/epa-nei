# Author: Peter W Setter
# Purpose: Create a graph of the PM2.5 emissions in Baltimore City, Maryland
# by year and type using the ggplot2 plotting system
# Inputs: nei (data frame of National Emission Inventory Data)
# Output: png file of graph

# dplyr for data manipulation, ggplot2 for graphing
library(dplyr)
library(ggplot2)

# Load data
source('obtaindata.R')

# Summarise the total amount of PM2.5 by year and type for Baltimore City, Maryland
baltimore.by.year.type <- nei %>%
        filter(fips == 24510) %>%
        group_by(year, type) %>%
        summarize(total.emissions = sum(Emissions))

# Create plot as a png file
png(filename = 'plot3.png')
ggplot(baltimore.by.year.type, aes(x = year, y = total.emissions, group = type)) +
        geom_line(aes(color = type)) +
        labs(title = 'PM2.5 Emissions in Baltimore City, MD by Type',
             x = 'Year',
             y = 'PM2.5 Emissions (Tons)') +
        theme_bw()
dev.off()