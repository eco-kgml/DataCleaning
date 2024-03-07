# Load and munge NEON High Frequency data
# Author: Bennett McAfee

library(neonUtilities)
library(tidyverse)

# view(data_full[[length(data_full)]])

sites <- c("SUGG", "BARC", "CRAM", "LIRO", "TOOK", "PRLA", "PRPO")

NEON_Lakes <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NEON_Lakes) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")


# Temperature at specific depth in surface water
packageID = "DP1.20264.001"
data_full <- loadByProduct(dpID=packageID, site=sites,
                           package="basic",
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[['TSD_1_min']] %>% mutate(flag = case_when(siteID == "BARC" & startDateTime >= "2018-03-01 01:00:00" & endDateTime <= "2018-08-27 14:00:00" ~ 1))
rm(data_full)
gc()

data <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                   "datetime" = data$startDateTime,
                   "lake_id" = data$siteID,
                   "depth" = data$thermistorDepth,
                   "variable" = rep("temp", nrow(data)),
                   "unit" = rep("DEG_C", nrow(data)),
                   "observation" = data$tsdWaterTemp,
                   "flag" = data$flag)

data <- data[is.na(data$observation) == FALSE,]
data$flag <- replace(data$flag, data$flag == 0, NA)
NEON_Lakes <- rbind(NEON_Lakes, data)
rm(data)
gc()

