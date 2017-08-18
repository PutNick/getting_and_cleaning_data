Setwd("F:/GitHub/getting_and_cleaning_data/Week4")

NEI <- readRDS("summarySCC_PM25.rds")
## contains all recordings of pm2.5 of 1999-2008 given in tons 

SCC <- readRDS("Source_Classification_Code.rds")

## Plot 1

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot 
## showing the total PM2.5 emission from all sources for
## each of the years 1999, 2002, 2005, and 2008.

NEI01 <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))
NEI01 <- as.data.frame(NEI01)
Years <- rownames(NEI01)
NEIß1 <- cbind(NEI01, Years)

## First we have too create a table summing the emissions for each year
png("plot1.png")
barplot(NEI01$Emissions, col = c("red", "orange", "yellow", "green"), ylab = expression(paste("PM", ""[2.5], " in Kilotons")), main = expression(paste("Total Emissions of PM", ""[2.5])))
dev.off
