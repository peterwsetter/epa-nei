# Author: Peter W Setter
# Purpose: Create a graph of the proportional change in PM2.5 emissions 
# from motor vehicle sources in Baltimore City, MD and Los Angeles County, CA
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
        filter(fips %in% c('24510', '06037')) %>%
        filter(SCC %in% motor.vehicle.sources$SCC) %>%
        group_by(year, fips) %>%
        summarize(total.emissions = sum(Emissions))

# Find the baseline total emissions for each region
baltimore.1999 <- motor.vehicles %>% ungroup %>%
                        filter(year == 1999, fips == '24510') %>%
                        select(total.emissions)

baltimore.1999 <- as.numeric(baltimore.1999)

la.county.1999 <- motor.vehicles %>% ungroup %>%
                        filter(year == 1999, fips == '06037') %>%
                        select(total.emissions)

la.county.1999 <- as.numeric(la.county.1999)

# Create new data frame with the variable change.emissions that compares
# emissions from that year with 1999
compare.change <- motor.vehicles %>%
                        mutate(change.emissions = ifelse(fips == '24510', 
                                (total.emissions - baltimore.1999)/baltimore.1999,
                                (total.emissions - la.county.1999)/la.county.1999)) %>%
                        mutate(region = ifelse(fips == '24510',
                                               'Baltimore City, MD',
                                               'Los Angeles County, CA'))

# Create plot as a png file
png(filename = 'plot6.png')
ggplot(compare.change, aes(x = year, y = change.emissions, group = fips)) +
        geom_line(aes(color = region)) +
        labs(title = 'Change in PM2.5 Emissions \n from Motor Vechiles Since 1999',
             x = 'Year',
             y = 'Proportional Change in PM2.5 Emissions') +
        geom_hline(aes(yintercept = 0)) +
        theme_bw()
dev.off()