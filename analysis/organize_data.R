#' ---
#' title: "organize_data.R"
#' author: "Yuan Fang"
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory.

# Loads data into R
library(readxl)
huizui <- read_excel("input/Huizui.xlsx")

#source in any useful functions
source("useful_functions.R")

huizui <- subset(huizui, select=apply(is.na(huizui), 2, mean)<1)
huizui[,17:ncol(huizui)][is.na(huizui[,17:ncol(huizui)])] <- 0
huizui$`Millet %` <- 100 * huizui$`Millet %`
