# Author: Peter W Setter
# Purpose: Download, unzip, and read EPA National Emissions Inventory
# Inputs: url of data set
# Output: nei (data frame of National Emission Inventory Data)
# Output: scc (table of emission source codes)

data.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile.name <- 'neidata.zip'
download.file(data.url, destfile.name, method = 'curl')
unzip(destfile.name)
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")