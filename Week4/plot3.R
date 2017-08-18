NEI <- readRDS("summarySCC_PM25.rds")
## contains all recordings of pm2.5 of 1999-2008 given in tons 

SCC <- readRDS("Source_Classification_Code.rds")
## contains the mapping of the SCC


Baltimoredata <- filter(.data = NEI, NEI$fips == "24510")
Baltimoredata01 <- with(Baltimoredata, tapply(Emissions, year, sum))
Baltimoredata01 <- as.data.frame(Baltimoredata01)

Balitmoredata$year <- as.factor(Balitmoredata$year)
png("plot3.png")
mdpd <- ggplot(Balitmoredata, aes(year, log(Emissions)))
mdpd + facet_grid(.~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + stat_boxplot(geom = "errorbar") + title(expression(paste("Total Emissions of PM", ""[2.5], "in Baltimore from 1999-2008"))) + ylab(expression(paste("PM", ""[2.5], " in Kilotons")))
dev.off()