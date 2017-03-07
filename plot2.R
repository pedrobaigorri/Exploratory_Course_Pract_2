##############################################################################
## File: plot2.R
##
## Description: Course_Project 2: Exloratory Data Analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
##
## Exercise: Have total emissions from PM2.5 decreased in the Baltimore City,
##           Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
##           system to make a plot answering this question.
##
## Author: Pedro A. Alonso Baigorri
##############################################################################

# setting the working path
setwd("D://GIT_REPOSITORY//Exploratory_Course_Pract_2")


# Load required libraries
library(dplyr)
library(stringr)


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

# Filtering for Baltimore
bal <- subset(NEI, fips == "24510") 

# agreggating by date
a <- aggregate(Emissions ~ year , data = bal, FUN = sum)


# drawing the plot 
png(file = "plot2.png", width=480, height=480)
barplot(a$Emissions, names.arg=a$year,  ylab = "Total Emissions", xlab = "year", main ="Yearly evolution of PM2.5 emissions in Baltimore")
dev.off()

