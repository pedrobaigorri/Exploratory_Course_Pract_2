##############################################################################
## File: plot1.R
##
## Description: Course_Project 2: Exloratory Data Analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
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
NEI$date <- as.Date(as.character(NEI$year), "%Y")
NEI$year <- as.factor(NEI$year)

# agreggating by date
a <- aggregate(Emissions ~ year , data = NEI, FUN = sum)
head(a)

# drawing the plot 
png(file = "plot1.png", width=480, height=480)
plot(a$year, a$Emissions,  ylab = "Total Emissions", xlab = "year", main ="Yearly evolution of PM2.5 emissions", type="h")
dev.off()

