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

png("plot5.png")
ggplot(bsmd, aes(Year, Emissions)) + geom_line(aes(group = 1, col = Emissions))+ geom_point(aes(col = Emissions)) + xlab("Year") + ylab(expression(paste("PM", ""[2.5], "  Emissions in tons"))) + ggtitle(expression(paste("PM", ""[2.5], "  Emissions from motor vehicle sources in Baltimore City (1999-2008)"))) + theme(legend.position = "none") + geom_text(aes(label = round(Emissions, 1), size = 1, hjust= 1, vjust = 1))
dev.off()
