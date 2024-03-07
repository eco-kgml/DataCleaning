#Read in Mendota Temperature High Frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Mendota <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Mendota) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes LTER: 
# High Frequency Water Temperature Data - Lake Mendota Buoy 2006 - current ver 31. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/2d6db053cfe03be2ddd3fbc0d86a6fb3 (Accessed 2023-10-12).

scope = "knb-lter-ntl"
identifier = 130
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

res <- read_data_entity_names(packageId = packageId)

for (i in 3:10){
  raw <- read_data_entity(packageId = packageId, entityId = res$entityId[i])
  data <- readr::read_csv(file = raw, show_col_types = FALSE)
  
  data$datetime <- paste(data$sampledate, data$sampletime)
  data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
  data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = data$datetime,
                       "lake_id" = rep("ME", nrow(data)),
                       "depth" = data$depth,
                       "variable" = rep("temp", nrow(data)),
                       "unit" = rep("DEG_C", nrow(data)),
                       "observation" = data$wtemp,
                       "flag" = data$flag_wtemp)
  Mendota <- rbind(Mendota, data_a)
  rm(data_a)
  gc()
}

Mendota$flag <- replace(Mendota$flag, Mendota$flag == "H", 8)
Mendota$flag <- replace(Mendota$flag, Mendota$flag == "J", 25)
Mendota$flag <- replace(Mendota$flag, Mendota$flag == "A", 26)
Mendota$flag <- replace(Mendota$flag, Mendota$flag == "C", 27)
Mendota$flag <- replace(Mendota$flag, Mendota$flag == "E", 28)
Mendota$flag <- replace(Mendota$flag, Mendota$flag == "F", 29)
Mendota$flag <- replace(Mendota$flag, Mendota$flag == "G", 30)