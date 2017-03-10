##############################################################################
## File: plot5.R
##
## Description: Course_Project 2: Exloratory Data Analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
##
## Exercise:  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
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

#converting year
NEI$year <- as.factor(NEI$year)

# Merging SCC data
m <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC", all.x = TRUE, all.y = TRUE)

# getting only the Vehicles data sources in baltimore
m$vehicles <- regexpr('Vehicles', m$EI.Sector)
vehicles <- subset(m, fips == "24510" & vehicles != -1) 

# agreggating by date & type
a <- aggregate(Emissions ~ year , data = vehicles, FUN = sum)


# drawing the plot 
png(file = "plot5.png", width=480, height=480)
barplot(a$Emissions, names.arg=a$year,  ylab = "Total Emissions", xlab = "year", main ="PM2.5 emissions from motor vehicles sources in Baltimore")
dev.off()

