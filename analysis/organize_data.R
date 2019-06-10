#' ---
#' title: "organize_data.R"
#' author: "Yuan Fang"
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory.

# Load data into R
library(readxl)
huizui <- read_excel("input/Huizui.xlsx")

# source in any useful functions
source("useful_functions.R")

# Delete columns with only NAs.
huizui <- subset(huizui, select=apply(is.na(huizui), 2, mean)<1)

# Substitute NAs with 0s for quantitative columns
huizui[,6:ncol(huizui)][is.na(huizui[,6:ncol(huizui)])] <- 0

# Subset Huizui to only contain useful variables
huizui <- subset(huizui, select = c(4:6, 8:16))

# Change column names
names(huizui) <- c("Period", "FeatureType", "LightFractionWt", "Vol", 
                   "TotalSeedNo", "TotalSeedDensity", "Millets",
                   "LuxuryCereal", "Bean", "MilletPct", "LCPct", "BeanPct")

# Change millet, LC, and bean proportions into percentages
huizui$`MilletPct` <- 100 * huizui$`MilletPct`
huizui$`LCPct` <- 100 * huizui$`LCPct`
huizui$`BeanPct` <- 100 * huizui$`BeanPct`

# Standardize periods
huizui$Period[huizui$Period == "Late Yangshao" | huizui$Period == "Mid/L Yangshao"] <- "Yangshao"
huizui$Period[huizui$Period == "Late Longshan"] <- "Longshan"

# Round data in certain columns
huizui[,c(3:4, 6, 10:12)] <- round(huizui[,c(3:4, 6, 10:12)], 2)

# Add several new variables
huizui$MilletDensity <- huizui$Millets / huizui$Vol
huizui$LCDensity <- huizui$LuxuryCereal / huizui$Vol
huizui$BeanDensity <- huizui$Bean / huizui$Vol

# Delete periods and feature types that have only one or two observations
table(huizui$Period)
which(huizui$Period == "Majiayao")
huizui <- huizui[-c(6), ]

table(huizui$FeatureType)
which(huizui$FeatureType == "Burial" | huizui$FeatureType == "Cultural Layer" | huizui$FeatureType == "Hearth")
huizui <- huizui[-c(13, 14, 25, 81), ]

# Reorganize Periods chronologically
huizui$Period <- factor(huizui$Period, levels = c("Yangshao", "Longshan", "Erlitou"))

# Save huizui in the output directory
save(huizui, file="output/analytical_data.RData")
