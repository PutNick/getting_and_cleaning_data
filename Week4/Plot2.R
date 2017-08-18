Setwd("F:/GitHub/getting_and_cleaning_data/Week4")

NEI <- readRDS("summarySCC_PM25.rds")
## contains all recordings of pm2.5 of 1999-2008 given in tons 

SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)

Baltimoredata <- filter(.data = NEI, NEI$fips == "24510")
Baltimoredata01 <- with(Baltimoredata, tapply(Emissions, year, sum))
Baltimoredata01 <- as.data.frame(Baltimoredata01)

png(filename = "plot2.png")
barplot(Baltimoredata01$Baltimoredata01, col = c("red", "orange", "yellow", "green"), ylab = expression(paste("PM", ""[2.5], " in Kilotons")), main = expression(paste("Total Emissions of PM", ""[2.5], "in Baltimore from 1999-2008")))
dev.off()
