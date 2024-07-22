# Load and munge NEON data
# Author: Bennett McAfee

library(neonUtilities)
library(tidyverse)

sites <- c("SUGG", "BARC", "CRAM", "LIRO", "TOOK", "PRLA", "PRPO")

NEON_Lakes <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NEON_Lakes) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# Secchi Depth
packageID = "DP1.20252.001"
data_full <- loadByProduct(dpID=packageID, site=sites, 
                        package="expanded", 
                        check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[["dep_secchi"]]

# Make max depth the secchi depth and add flag for bottom visible
data <- data %>% mutate(secchiDepth = case_when(is.na(secchiMeanDepth) & clearToBottom == "Y" ~ maxDepth,
                                                is.na(secchiMeanDepth) == FALSE ~ secchiMeanDepth),
                        secchiBottomFlag = case_when(is.na(secchiMeanDepth) & clearToBottom == "Y" ~ "51"))

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = strptime(data$date, format = '%Y-%m-%d %H:%M:%S'),
                     "lake_id" = data$siteID,
                     "depth" = NA,
                     "variable" = rep("secchi", nrow(data)),
                     "unit" = rep("M", nrow(data)),
                     "observation" = data$secchiDepth,
                     "flag" = data$secchiBottomFlag) # dataQF is empty. Bottom is the only flag

data_a <- data_a[is.na(data_a$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
rm(data, data_a, data_full, packageID)

# Depth profile at specific depths
packageID = "DP1.20254.001"
data_full <- loadByProduct(dpID=packageID, site=sites,
                           package="expanded",
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[["dep_profileData"]]

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$date,
                     "lake_id" = data$siteID,
                     "depth" = data$sampleDepth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$waterTemp,
                     "flag" = data$dataQF)
data_b <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$date,
                     "lake_id" = data$siteID,
                     "depth" = data$sampleDepth,
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$dissolvedOxygen,
                     "flag" = data$dataQF)
data_a <- data_a[is.na(data_a$observation) == FALSE,]
data_b <- data_b[is.na(data_b$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
NEON_Lakes <- rbind(NEON_Lakes, data_b)
rm(data, data_a, data_b, data_full, packageID)

# Chemical properties of surface water
packageID = "DP1.20093.001"
data_full <- loadByProduct(dpID=packageID, site=sites,
                           package="expanded",
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[["swc_externalLabDataByAnalyte"]]
data <- data %>% 
  filter(analyte %in% c("TP", "TN", "NO3+NO2 - N", "NH4 - N", "DIC", "NO2 - N", "DOC") & grepl('buoy', namedLocation)) %>%
  mutate(analyte_new_name = case_when(analyte == "TP" ~ "tp",
                                      analyte == "TN" ~ "tn",
                                      analyte == "NO3+NO2 - N" ~ "no3no2",
                                      analyte == "NH4 - N" ~ "nh4",
                                      analyte == "DIC" ~ "dic",
                                      analyte == "NO2 - N" ~ "no2",
                                      analyte == "DOC" ~ "doc"),
         analyte_new_conc = case_when(analyte == "TP" ~ analyteConcentration*1000,
                                      analyte == "TN" ~ analyteConcentration*1000,
                                      analyte == "NO3+NO2 - N" ~ analyteConcentration*1000,
                                      analyte == "NH4 - N" ~ analyteConcentration*1000,
                                      analyte == "DIC" ~ analyteConcentration,
                                      analyte == "NO2 - N" ~ analyteConcentration*1000,
                                      analyte == "DOC" ~ analyteConcentration,
                                      belowDetectionQF == "ND" ~ 0),
         analyte_new_unit = case_when(analyte == "TP" ~ "MicroGM-PER-L",
                                      analyte == "TN" ~ "MicroGM-PER-L",
                                      analyte == "NO3+NO2 - N" ~ "MicroGM-PER-L",
                                      analyte == "NH4 - N" ~ "MicroGM-PER-L",
                                      analyte == "DIC" ~ "MilliGM-PER-L",
                                      analyte == "NO2 - N" ~ "MicroGM-PER-L",
                                      analyte == "DOC" ~ "MilliGM-PER-L")) %>%
  unite(col = "new_flag", c("belowDetectionQF", "remarks", "shipmentWarmQF", "sampleCondition"), sep = "|")
data$new_flag <- replace(data$new_flag, data$new_flag == "NA|NA|0|GOOD" | data$new_flag == "NA|NA|0|OK", NA)
data$new_flag <- replace(data$new_flag, is.na(data$new_flag) == FALSE, 1)

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$collectDate,
                     "lake_id" = data$siteID,
                     "depth" = rep(0, nrow(data)),
                     "variable" = data$analyte_new_name,
                     "unit" = data$analyte_new_unit,
                     "observation" = data$analyte_new_conc,
                     "flag" = data$new_flag)
data_a <- data_a[is.na(data_a$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
rm(data, data_a, data_full, packageID)

# Periphyton, seston, and phytoplankton chemical properties
packageID = "DP1.20163.001"
data_full <- loadByProduct(dpID=packageID, site=sites, 
                           package="expanded", 
                           check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data_a <- data_full[["alg_algaeExternalLabDataPerSample"]] %>% filter(grepl('buoy', namedLocation))
data_b <- data_full[["alg_fieldData"]] %>% filter(grepl('buoy', namedLocation))
data_c <- data_full[["alg_domainLabChemistry"]] %>% filter(grepl('buoy', namedLocation))

#names(data_b)[names(data_b) == 'parentSampleID'] <- 'sampleID'

data <- merge(data_b, data_c, by = "parentSampleID", all = TRUE)
data <- merge(data, data_a, by = "sampleID", all = TRUE)

data <- data %>% filter(analyte == "chlorophyll a")

data <- data %>% mutate(realdepth = case_when(is.na(phytoDepth2) == TRUE & is.na(phytoDepth3) == TRUE ~ phytoDepth1,
                                              phytoDepth1 == phytoDepth2 & is.na(phytoDepth3) == TRUE ~ phytoDepth1,
                                              phytoDepth1 == phytoDepth2 & phytoDepth2 == phytoDepth3 ~ phytoDepth1,
                                              is.na(phytoDepth2) == FALSE & phytoDepth1 != phytoDepth2 ~ -99,
                                              is.na(phytoDepth3) == FALSE & phytoDepth1 != phytoDepth3 ~ -99))

data$externalLabDataQF <- replace(data$externalLabDataQF, data$externalLabDataQF == "legacyData|Did not meet quality audit requirements for analysis audit" | data$externalLabDataQF == "legacyData|Did not meet quality audit requirements for analysis audit|acidTreatmentSOPNotFollowed", 1)
data$externalLabDataQF <- replace(data$externalLabDataQF, data$externalLabDataQF == "legacyData", 1)

data_d <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$collectDate.x,
                     "lake_id" = data$siteID.x,
                     "depth" = data$realdepth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$analyteConcentration,
                     "flag" = data$externalLabDataQF) %>%
  drop_na(observation)

NEON_Lakes <- rbind(NEON_Lakes, data_d)
rm(data, data_a, data_b, data_c, data_d, data_full, packageID)
