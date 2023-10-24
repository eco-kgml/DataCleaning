#Read in Crystal Bog data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Crystal_Bog <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Crystal_Bog) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

# Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER: 
# High Frequency Meteorological and Dissolved Oxygen Data - Crystal Bog Buoy 2005 - 2014 ver 12. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/3e56050897da4adbd856598063539376 (Accessed 2023-10-24).

scope = "knb-lter-ntl"
identifier = 118
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[3])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$sampledate,
                     "lake" = rep("CB", nrow(data)),
                     "depth" = rep(0.5, nrow(data)),
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$opt_do_raw,
                     "flag" = data$flag_opt_do_raw) %>%
  drop_na(observation)

Crystal_Bog <- rbind(Crystal_Bog, data_a)
rm(data_a)

# Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER: 
# High Frequency Water Temperature Data - Crystal Bog Buoy 2005 - 2014 ver 9. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/d40e8685a6dac519b51c77e460268230 (Accessed 2023-10-24).

scope = "knb-lter-ntl"
identifier = 119
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[3])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$sampledate,
                     "lake" = rep("CB", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Crystal_Bog <- rbind(Crystal_Bog, data_a)
rm(data_a)