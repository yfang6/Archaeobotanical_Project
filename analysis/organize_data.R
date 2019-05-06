#' ---
#' title: "organize_data.R"
#' author: "Yuan Fang"
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory.

# Loads data into R
huizui <- read.csv("analysis/input/Huizui.csv")

#source in any useful functions
source("useful_functions.R")