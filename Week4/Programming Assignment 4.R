


Setwd("F:/GitHub/getting_and_cleaning_data/Week4")

NEI <- readRDS("summarySCC_PM25.rds")
## contains all recordings of pm2.5 of 1999-2008 given in tons 

SCC <- readRDS("Source_Classification_Code.rds")
## contains the mapping of the SCC


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


## Plot2: 

library(dplyr)

Baltimoredata <- filter(.data = NEI, NEI$fips == "24510")
Baltimoredata01 <- with(Baltimoredata, tapply(Emissions, year, sum))
Baltimoredata01 <- as.data.frame(Baltimoredata01)

png(filename = "plot2.png")
barplot(Baltimoredata01$Baltimoredata01, col = c("red", "orange", "yellow", "green"), ylab = expression(paste("PM", ""[2.5], " in Kilotons")), main = expression(paste("Total Emissions of PM", ""[2.5], "in Baltimore from 1999-2008")))
dev.off()

## Plot3

Balitmoredata$year <- as.factor(Balitmoredata$year)
png("plot3.png")
mdpd <- ggplot(Balitmoredata, aes(year, log(Emissions)))
mdpd + facet_grid(.~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + stat_boxplot(geom = "errorbar") + title(expression(paste("Total Emissions of PM", ""[2.5], "in Baltimore from 1999-2008"))) + ylab(expression(paste("PM", ""[2.5], " in Kilotons")))
dev.off()

## Plot 4: First we have to subset all Coal related scc indexes from SCC in order to merge them with corresponding data points of NEI  

SCC.Coal <- SCC[grepl(pattern = "Coal",x = SCC$Short.Name,ignore.case = TRUE )]
coalmerged <- merge(SCC.Coal, NEI, by = "SCC")
coalsum <- coalsum <- with(ussccpoints, tapply(Emissions, year, sum))
coalsum <- as.data.frame(coalsum)
coalsum <- rownames_to_column(df = coalsum)
colnames(coalsum) <- c("Year", "Emissions")
png("plot5.png")
ggplot(coalsum, aes(Year, Emissions/1000)) + geom_line(aes(group = 1, col = Emissions))+ geom_point(aes(col = Emissions)) + xlab("Year") + ylab(expression(paste("PM", ""[2.5], "in Kilotons"))) + ggtitle(expression(paste("Total Emissions of PM", ""[2.5], "in the US from 1999-2008"))) + theme(legend.position = "none") + geom_text(aes(label = round(Emissions, 1), size = 1, hjust= 1, vjust = 1))
dev.off()

## Plot 5
baltimoredata <- filter(.data = NEI, NEI$fips == "24510")
motorvehicles1 <- SCC[grep(pattern = "On-Road", x =  SCC$EI.Sector), ]
baltimoremotors <- merge(x = baltimoredata, y= motorvehicles2, by = "SCC")
bsmd <- with(baltimoremotors, tapply(Emissions, year, sum))
bsmd <- tibble::rownames_to_column(as.data.frame(bsmd))
colnames(bsmd) <- c("Year", "Emissions")

png("plot5.png")
ggplot(bsmd, aes(Year, Emissions)) + geom_line(aes(group = 1, col = Emissions))+ geom_point(aes(col = Emissions)) + xlab("Year") + ylab(expression(paste("PM", ""[2.5], "  Emissions in tons"))) + ggtitle(expression(paste("PM", ""[2.5], "  Emissions from motor vehicle sources in Baltimore City (1999-2008)"))) + theme(legend.position = "none") + geom_text(aes(label = round(Emissions, 1), size = 1, hjust= 1, vjust = 1))
dev.off()

## plot 6

Losan <- filter(NEI, NEI$fips == "06037")
losangm <- merge(Losan, motorvehicles2, "SCC")
lsmd <- with(losangm, tapply(Emissions, year, sum))
lsmd <- tibble::rownames_to_column(as.data.frame(lsmd))
colnames(lsmd) <- c("Year", "Emissions")
citymat <- rbind(lsmd, bsmd)
citymat$Year <- as.factor(citymat$Year)
citymat$City <- c("Los Angeles County","Los Angeles County","Los Angeles County","Los Angeles County", "Baltimore City","Baltimore City","Baltimore City","Baltimore City")

## lets plot! 
png("plot6.png")
ggplot(citymat, aes(Year, Emissions)) + geom_bar(stat = "identity", aes(fill = Year)) + facet_grid(.~City) + ylab(expression(paste("PM", ""[2.5], "  Emissions in tons"))) + ggtitle(expression(paste("PM", ""[2.5], "  Emissions from motor vehicles in Baltimore City and Los Angeles County"))) + theme(legend.position = "none")
dev.off()
