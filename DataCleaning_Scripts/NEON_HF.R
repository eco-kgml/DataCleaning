# Load and munge NEON High Frequency data
# Author: Bennett McAfee

library(neonUtilities)
library(tidyverse)

# view(data_full[[length(data_full)]])

NEON_Lakes <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NEON_Lakes) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

# HF Nitrate in surface water
packageID = "DP1.20033.001"
data_full <- loadByProduct(dpID=packageID, site=c("SUGG", "BARC", "CRAM", "LIRO", "TOOL", "PRLA", "PRPO"), 
                           package="expanded", 
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[[7]]

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = strptime(data$startDateTime, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$siteID,
                     "depth" = 0,
                     "variable" = rep("no3no2", nrow(data)),
                     "unit" = rep("M", nrow(data)),
                     "observation" = data$secchiDepth,
                     "flag" = data$secchiBottomFlag)

data_a <- data_a[is.na(data_a$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
rm(data, data_a, data_full, packageID)