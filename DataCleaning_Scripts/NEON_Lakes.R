# Load and munge NEON data
# Author: Bennett McAfee

library(neonUtilities)
library(tidyverse)

NEON_Lakes <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(NEON_Lakes) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

# Secchi Depth
packageID = "DP1.20252.001"
data_full <- loadByProduct(dpID=packageID, site=c("SUGG", "BARC", "CRAM", "LIRO", "TOOL", "PRLA", "PRPO"), 
                        package="expanded", 
                        check.size = F)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data <- data_full[[4]]

# view(data_full[[8]])

# Make max depth the secchi depth and add flag for bottom visible
data <- data %>% mutate(secchiDepth = case_when(is.na(secchiMeanDepth) & clearToBottom == "Y" ~ maxDepth,
                                                is.na(secchiMeanDepth) == FALSE ~ secchiMeanDepth),
                        secchiBottomFlag = case_when(is.na(secchiMeanDepth) & clearToBottom == "Y" ~ "Z"))

data_a <- data.frame("datetime" = strptime(data$date, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$siteID,
                     "depth" = 0,
                     "variable" = rep("secchi", nrow(data)),
                     "unit" = rep("M", nrow(data)),
                     "observation" = data$secchiDepth,
                     "flag" = data$secchiBottomFlag)

data_a <- data_a[is.na(data_a$observation) == FALSE,]
NEON_Lakes <- rbind(NEON_Lakes, data_a)
rm(data, data_a, data_full, packageID)

# Chemical properties of surface water
# packageID = "DP1.20093.001"
# data_full <- loadByProduct(dpID=packageID, site=c("SUGG", "BARC", "CRAM", "LIRO", "TOOL", "PRLA", "PRPO"), 
#                            package="expanded", 
#                            check.size = F)
# 
# if (exists("provenance")){
#   provenance <- append(provenance, packageId)
# }

# data <- data_full[[?]]

# view(data_full[[14]])

# To Be Continued

