#Read in Crystal Bog data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Crystal_Bog <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Crystal_Bog) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER: 
# High Frequency Meteorological and Dissolved Oxygen Data - Crystal Bog Buoy 2005 - 2014 ver 12. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/3e56050897da4adbd856598063539376 (Accessed 2023-10-24).

scope = "knb-lter-ntl"
identifier = 118
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[4])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("CB", nrow(data)),
                     "depth" = data$do_depth,
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$do_raw,
                     "flag" = data$flag_do_raw) %>%
  drop_na(observation)

Crystal_Bog <- rbind(Crystal_Bog,data_a)
rm(data_a)

raw <- read_data_entity(packageId = packageId, entityId = res$entityId[6])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("CB", nrow(data)),
                     "depth" = data$hobo_depth,
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$hobo_lux * 0.0185, #0.0185 is the conversion factor for lux to PPFD
                     "flag" = data$flag_hobo_lux) %>%
  drop_na(observation)
data_b <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("CB", nrow(data)),
                     "depth" = data$hobo_depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$hobo_wtemp,
                     "flag" = data$flag_hobo_lux) %>%
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

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("CB", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Crystal_Bog <- rbind(Crystal_Bog,data_a)
rm(data_a)

raw <- read_data_entity(packageId = packageId, entityId = res$entityId[4])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("CB", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Crystal_Bog <- rbind(Crystal_Bog, data_a)
rm(data_a)


Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "H", 8)
Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "J", 25)
Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "A", 26)
Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "C", 27)
Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "E", 28)
Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "F", 29)
Crystal_Bog$flag <- replace(Crystal_Bog$flag, Crystal_Bog$flag == "G", 30)