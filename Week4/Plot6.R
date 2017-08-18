Setwd("F:/GitHub/getting_and_cleaning_data/Week4")

NEI <- readRDS("summarySCC_PM25.rds")
## contains all recordings of pm2.5 of 1999-2008 given in tons 

SCC <- readRDS("Source_Classification_Code.rds")

baltimoredata <- filter(.data = NEI, NEI$fips == "24510")
motorvehicles1 <- SCC[grep(pattern = "On-Road", x =  SCC$EI.Sector), ]
baltimoremotors <- merge(x = baltimoredata, y= motorvehicles2, by = "SCC")
bsmd <- with(baltimoremotors, tapply(Emissions, year, sum))
bsmd <- tibble::rownames_to_column(as.data.frame(bsmd))
colnames(bsmd) <- c("Year", "Emissions")

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
