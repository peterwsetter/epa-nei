# Author: Peter W Setter
# Purpose: Create a graph of the PM2.5 emissions from coal-combustion sources
# Inputs: nei (data frame of National Emission Inventory Data)
# Inputs: scc (SCC codebook)
# Output: png file of graph

# dplyr for data manipulation, ggplot2 for plotting
library(dplyr)
library(ggplot2)

# Load data
source('obtaindata.R')

# Find SCC codes for coal combustion sources
coal.comb.sources <- scc %>%
        filter(grepl('Coal', EI.Sector) & grepl('Comb', EI.Sector)) %>%
        select(SCC, EI.Sector)

# Filter to obtain PM2.5 from coal combustion sources
coal.combustion <- nei %>%
        filter(SCC %in% coal.comb.sources$SCC) %>%
        group_by(year) %>%
        summarize(total.emissions = sum(Emissions))

# Create plot as a png file
png(filename = 'plot4.png')
ggplot(coal.combustion, aes(x = year, y = total.emissions)) +
        geom_line() +
        labs(title = 'PM2.5 Emissions from Coal Combustion Sources',
             x = 'Year',
             y = 'PM2.5 Emissions (Tons)') +
        theme_bw()
dev.off()