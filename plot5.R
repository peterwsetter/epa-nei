# Author: Peter W Setter
# Purpose: Create a graph of the PM2.5 emissions from motor vehicle sources in
# Baltimore City, MD
# Inputs: nei (data frame of National Emission Inventory Data)
# Inputs: scc (SCC codebook)
# Output: png file of graph

# dplyr for data manipulation, ggplot2 for plotting
library(dplyr)
library(ggplot2)

# Load data
source('obtaindata.R')

# Find SCC codes for coal combustion sources
motor.vehicle.sources <- scc %>%
        filter(grepl('Vehicle', EI.Sector)) %>%
        select(SCC, EI.Sector)

# Filter to obtain PM2.5 from coal combustion sources
motor.vehicles <- nei %>%
        filter(fips == 24510) %>%
        filter(SCC %in% motor.vehicle.sources$SCC) %>%
        group_by(year) %>%
        summarize(total.emissions = sum(Emissions))

# Create plot as a png file
png(filename = 'plot5.png')
ggplot(motor.vehicles, aes(x = year, y = total.emissions)) +
        geom_line() +
        labs(title = 'PM2.5 Emissions from Motor Vechiles (Baltimore City, MD)',
             x = 'Year',
             y = 'PM2.5 Emissions (Tons)') +
        theme_bw()
dev.off()