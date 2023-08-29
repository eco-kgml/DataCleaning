#Read in Trout Bog data from EDI
#Author: Adi Tewari

library(EDIutils)
library(tidyverse)

# Creating data table
Trout_Bog <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Trout_Bog) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

#Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER:
#High Frequency Meteorological and Dissolved Oxygen Data - Trout Bog Buoy 2003 
#- 2014 ver 23. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/556848924bf5d83e6ba166b84f1f10bb

scope = "knb-lter-ntl"
identifier = 69
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[3])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Trout Bog", nrow(data)),
                     "depth" = rep(0.5, nrow(data)),
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$opt_do_raw,
                     "flag" = data$flag_opt_do_raw) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a)
rm(data_a)

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
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Trout Bog", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)

Trout_Bog <- rbind(Trout_Bog,data_a)
rm(data_a)
