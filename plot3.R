##############################################################################
## File: plot3.R
##
## Description: Course_Project 2: Exloratory Data Analysis
## https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
##
## Exercise: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
##           variable, which of these four sources have seen decreases in emissions from 1999-2008 
##           for Baltimore City? Which have seen increases in emissions from 1999-2008?
##           Use the ggplot2 plotting system to make a plot answer this question.
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

# Filtering for Baltimore
bal <- subset(NEI, fips == "24510") 

# agreggating by date & type
a <- aggregate(Emissions ~ year + type , data = bal, FUN = sum)


# drawing the plot 
png(file = "plot3.png", width=480, height=480)

ggplot(data=a, aes(x=year, y=Emissions, colour=type)) + 
    geom_line() + geom_point() + 
    ggtitle("Evolution of PM2.5 Emissions for Baltimore per Source Type")

dev.off()

