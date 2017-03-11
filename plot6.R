##############################################################################
## File: plot6.R
##
## Description: Course_Project 2: Exloratory Data Analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
##
## Exercise:  Compare emissions from motor vehicle sources in Baltimore City with emissions
##            from motor vehicle sources in Los Angeles County, California. 
##
## Author: Pedro A. Alonso Baigorri
##############################################################################

# setting the working path
setwd("D://GIT_REPOSITORY//Exploratory_Course_Pract_2")


# Load required libraries
library(dplyr)
library(stringr)
library(ggplot2)


# Getting the data
localFile <- "./data/airPollution.zip"


if (!file.exists(localFile))
{
    fileURL <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    
    if (!file.exists("./data")){dir.create("./data")}

    download.file(fileURL, localFile)
    
    unzip(localFile, exdir = "./data")    
}

## Reading data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Merging SCC data
m <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC", all.x = TRUE, all.y = TRUE)

# getting only the Vehicles data sources in baltimore
m$vehicles <- regexpr('Vehicles', m$EI.Sector)
vehicles <- subset(m, (fips == "24510" | fips == "06037") & vehicles != -1) 


vehicles$city <- ifelse(vehicles$fips == "24510", "Baltimore", "Los Angeles" )

# agreggating by date & type
a <- aggregate(Emissions ~ year+city , data = vehicles, FUN = sum)


# drawing the plot 
png(file = "plot6.png", width=480, height=480)

ggplot(data = a, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(stat="identity") + 
    facet_grid(city ~ ., scales="free") +
    ylab("total emissions") + 
    xlab("year") +
    ggtitle("PM2.5 Emissions of Vehicle data sources for Baltimore and Los Angeles") +
    theme(legend.position="none")


dev.off()
