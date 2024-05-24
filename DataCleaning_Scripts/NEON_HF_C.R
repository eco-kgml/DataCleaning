library(neonUtilities)
library(tidyverse)

# view(data_full[[length(data_full)]])

sites <- c("SUGG", "BARC", "CRAM", "LIRO", "TOOK", "PRLA", "PRPO")

NEON_Lakes <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NEON_Lakes) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# Photosynthetically active radiation below water surface
packageID = "DP1.20261.001"
data_full <- loadByProduct(dpID=packageID, site=sites,
                           package="basic",
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data_vert <- data_full[['sensor_positions_20261']] %>% filter(grepl("103", HOR.VER)) %>% filter(grepl("Incoming", sensorLocationDescription))
data <- data_full[['uPAR_1min']] %>% mutate(sensorheight = case_when(siteID == "SUGG" ~ -data_vert$zOffset[which(data_vert$siteID == "SUGG")],
                                                                     siteID == "BARC" ~ -data_vert$zOffset[which(data_vert$siteID == "BARC")],
                                                                     siteID == "CRAM" ~ -data_vert$zOffset[which(data_vert$siteID == "CRAM")],
                                                                     siteID == "LIRO" ~ -data_vert$zOffset[which(data_vert$siteID == "LIRO")],
                                                                     siteID == "PRLA" ~ -data_vert$zOffset[which(data_vert$siteID == "PRLA")],
                                                                     siteID == "PRPO" ~ -data_vert$zOffset[which(data_vert$siteID == "PRPO")],
                                                                     siteID == "TOOK" ~ -data_vert$zOffset[which(data_vert$siteID == "TOOK")]))

rm(data_full, data_vert)
gc()

data <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                   "datetime" = data$startDateTime,
                   "lake_id" = data$siteID,
                   "depth" = data$sensorheight,
                   "variable" = rep("par", nrow(data)),
                   "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                   "observation" = data$uPARMean,
                   "flag" = data$uPARFinalQF)

data <- data[is.na(data$observation) == FALSE,]
data$flag <- replace(data$flag, data$flag == 0, NA)
NEON_Lakes <- rbind(NEON_Lakes, data)
rm(data)
gc()