#Read in Trout Bog data from EDI
#Author: Adi Tewari

library(EDIutils)
library(tidyverse)

# Creating data table
Trout_Bog <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Trout_Bog) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

#Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER:
#High Frequency Meteorological and Dissolved Oxygen Data - Trout Bog Buoy 2003 
#- 2014 ver 23. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/556848924bf5d83e6ba166b84f1f10bb

scope = "knb-lter-ntl"
identifier = 69
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
                     "lake_id" = rep("TB", nrow(data)),
                     "depth" = data$do_depth,
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$do_raw,
                     "flag" = data$flag_do_raw) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a)
rm(data_a)

raw <- read_data_entity(packageId = packageId, entityId = res$entityId[6])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("TB", nrow(data)),
                     "depth" = data$hobo_depth,
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$hobo_lux * 0.0185, #0.0185 is the conversion factor for lux to PPFD
                     "flag" = data$flag_hobo_lux) %>%
  drop_na(observation)
data_b <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("TB", nrow(data)),
                     "depth" = data$hobo_depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$hobo_wtemp,
                     "flag" = data$flag_hobo_lux) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a) %>% rbind(data_b)
rm(data_a, data_b)


#Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER: 
#High Frequency Water Temperature Data - Trout Bog Buoy 2003 - 2014 ver 28. 
#Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/db38add6b67134d205086de3d7366001

scope = "knb-lter-ntl"
identifier = 70
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
                     "lake_id" = rep("TB", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a)
rm(data_a)

raw <- read_data_entity(packageId = packageId, entityId = res$entityId[4])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("TB", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a)
rm(data_a)

raw <- read_data_entity(packageId = packageId, entityId = res$entityId[5])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- as_datetime(paste(data$sampledate, data$sampletime))
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = rep("TB", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a)
rm(data_a)


Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "H", 8)
Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "J", 25)
Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "A", 26)
Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "C", 27)
Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "E", 28)
Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "F", 29)
Trout_Bog$flag <- replace(Trout_Bog$flag, Trout_Bog$flag == "G", 30)