# Load and munge NEON High Frequency data
# Author: Bennett McAfee

library(neonUtilities)
library(tidyverse)

# view(data_full[[length(data_full)]])

sites <- c("SUGG", "BARC", "CRAM", "LIRO", "TOOK", "PRLA", "PRPO")

NEON_Lakes <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NEON_Lakes) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# HF Nitrate in surface water
packageID = "DP1.20033.001"
data_full <- loadByProduct(dpID=packageID, site=sites, 
                           package="expanded", 
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[["NSW_15_minute"]]

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$startDateTime,
                     "lake_id" = data$siteID,
                     "depth" = rep(0, nrow(data)), #double check
                     "variable" = rep("no3", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$surfWaterNitrateMean * (1/0.016128), #conversion from umol to ug
                     "flag" = data$finalQF)

data_a <- data_a[is.na(data_a$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
rm(data, data_a, data_full, packageID)

# HF Surface PAR
packageID = "DP1.20042.001"
data_full <- loadByProduct(dpID=packageID, site=sites, 
                           package="expanded", 
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data_vert <- data_full[["sensor_positions_20042"]] %>% select(siteID, zOffset) %>% distinct()
data <- data_full[["PARWS_1min"]] %>% mutate(sensorheight = case_when(siteID == "SUGG" ~ -data_vert[which(data_vert$siteID == "SUGG"), zOffset],
                                                           siteID == "BARC" ~ -data_vert[which(data_vert$siteID == "BARC"), zOffset],
                                                           siteID == "CRAM" ~ -data_vert[which(data_vert$siteID == "CRAM"), zOffset],
                                                           siteID == "LIRO" ~ -data_vert[which(data_vert$siteID == "LIRO"), zOffset],
                                                           siteID == "PRLA" ~ -data_vert[which(data_vert$siteID == "PRLA"), zOffset],
                                                           siteID == "PRPO" ~ -data_vert[which(data_vert$siteID == "PRPO"), zOffset],
                                                           siteID == "TOOK" ~ -data_vert[which(data_vert$siteID == "TOOK"), zOffset]))

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$startDateTime,
                     "lake_id" = data$siteID,
                     "depth" = data$sensorheight,
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$PARMean,
                     "flag" = data$PARFinalQF) # 1 = fail, 0 = Pass

data_a <- data_a[is.na(data_a$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
rm(data, data_a, data_full, data_vert, packageID)
gc()

# HF water quality
packageID = "DP1.20288.001"
data_full <- loadByProduct(dpID=packageID, site=sites, 
                           package="expanded", 
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[["waq_instantaneous"]] %>% filter(sensorDepth >= 0)

# data_vert <- data_full[["sensor_positions_20288"]]

data_chla <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$startDateTime,
                     "lake_id" = data$siteID,
                     "depth" = data$sensorDepth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$chlorophyll,
                     "flag" = data$chlorophyllFinalQF) # 1 = fail, 0 = Pass
data_do <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                        "datetime" = data$startDateTime,
                        "lake_id" = data$siteID,
                        "depth" = data$sensorDepth,
                        "variable" = rep("do", nrow(data)),
                        "unit" = rep("MilliGM-PER-L", nrow(data)),
                        "observation" = data$dissolvedOxygen,
                        "flag" = data$dissolvedOxygenFinalQF) # 1 = fail, 0 = Pass
data_fdom <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                        "datetime" = data$startDateTime,
                        "lake_id" = data$siteID,
                        "depth" = data$sensorDepth,
                        "variable" = rep("fdom", nrow(data)),
                        "unit" = rep("MicroGM-PER-L", nrow(data)),
                        "observation" = data$fDOM,
                        "flag" = data$fDOMFinalQF) # 1 = fail, 0 = Pass

data_chla <- data_chla[is.na(data_chla$observation) == FALSE,]
data_do <- data_do[is.na(data_do$observation) == FALSE,]
data_fdom <- data_fdom[is.na(data_fdom$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_chla) %>% rbind(data_do) %>% rbind(data_fdom)
NEON_Lakes$flag <- replace(NEON_Lakes$flag, NEON_Lakes$flag == 0, NA)
rm(data, data_chla, data_do, data_fdom, data_full, packageID)
gc()