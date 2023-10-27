# Load and munge NEON data
# Author: Bennett McAfee

library(neonUtilities)
library(tidyverse)

sites <- c("SUGG", "BARC", "CRAM", "LIRO", "TOOL", "PRLA", "PRPO")

# view(data_full[[length(data_full)]])

NEON_Lakes <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NEON_Lakes) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

# Secchi Depth
packageID = "DP1.20252.001"
data_full <- loadByProduct(dpID=packageID, site=c("SUGG", "BARC", "CRAM", "LIRO", "TOOL", "PRLA", "PRPO"), 
                        package="expanded", 
                        check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageID)
}

data <- data_full[[4]]

# Make max depth the secchi depth and add flag for bottom visible
data <- data %>% mutate(secchiDepth = case_when(is.na(secchiMeanDepth) & clearToBottom == "Y" ~ maxDepth,
                                                is.na(secchiMeanDepth) == FALSE ~ secchiMeanDepth),
                        secchiBottomFlag = case_when(is.na(secchiMeanDepth) & clearToBottom == "Y" ~ "Z"))

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = strptime(data$date, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$siteID,
                     "depth" = NA,
                     "variable" = rep("secchi", nrow(data)),
                     "unit" = rep("M", nrow(data)),
                     "observation" = data$secchiDepth,
                     "flag" = data$secchiBottomFlag)

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

data <- data_full[[4]]

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = strptime(data$date, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$siteID,
                     "depth" = data$sampleDepth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$waterTemp,
                     "flag" = data$dataQF)
data_b <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = strptime(data$date, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$siteID,
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

data <- data_full[[9]]
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

data_a <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = strptime(data$collectDate, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$siteID,
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

data_a <- data_full[[1]] %>% filter(grepl('buoy', namedLocation))
data_b <- data_full[[4]] %>% filter(grepl('buoy', namedLocation))

names(data_b)[names(data_b) == 'parentSampleID'] <- 'sampleID'

data <- merge(data_b, data_a, by = "sampleID", all = TRUE)

data$meandepth <- rowMeans(data[,c("phytoDepth1", "phytoDepth2", "phytoDepth3")], na.rm=TRUE)
data$n_depth <- rowSums(is.na(data[,c("phytoDepth1", "phytoDepth2", "phytoDepth3")]))

data <- data %>% mutate(integrated_flag = case_when(n_depth < 2 ~ 1,
                                     n_depth == 2 ~ NA)) %>%
  filter(analyte == "chlorophyll a") %>%
  select(sampleID, collectDate.x, collectDate.y, siteID.x, siteID.y, phytoDepth1, phytoDepth2, phytoDepth3, meandepth, analyte, analyteConcentration, integrated_flag)

data_c <- data.frame("source" = rep(paste("NEON", packageID), nrow(data)),
                     "datetime" = data$collectDate.y,
                     "lake" = data$siteID.y,
                     "depth" = data$meandepth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$analyteConcentration,
                     "flag" = data$integrated_flag) # flag will need to be adjusted
data_c <- data_c[is.na(data_c$observation) == FALSE,]

NEON_Lakes <- rbind(NEON_Lakes, data_c)
rm(data, data_a, data_b, data_c, data_full, packageID)
