#Read in Trout Lake high frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Trout <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Trout) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes LTER: 
# High Frequency Water Temperature Data - Trout Lake Buoy 2004 - current ver 28. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/e1605901355d209dc588394312a4a38e (Accessed 2023-10-26).

scope = "knb-lter-ntl"
identifier = 116
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

res <- read_data_entity_names(packageId = packageId)
last_year_data_index <- nrow(res)

for (i in 10:last_year_data_index){
  raw <- read_data_entity(packageId = packageId, entityId = res$entityId[i])
  data <- readr::read_csv(file = raw, show_col_types = FALSE)
  
  data$datetime <- paste(data$sampledate, data$sampletime)
  data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
  data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = data$datetime,
                       "lake_id" = rep("TR", nrow(data)),
                       "depth" = data$depth,
                       "variable" = rep("temp", nrow(data)),
                       "unit" = rep("DEG_C", nrow(data)),
                       "observation" = data$wtemp,
                       "flag" = data$flag_wtemp)
  Trout <- rbind(Trout, data_a)
  rm(data_a)
  gc()
}

Trout$flag <- replace(Trout$flag, Trout$flag == "H", 8)
Trout$flag <- replace(Trout$flag, Trout$flag == "J", 25)
Trout$flag <- replace(Trout$flag, Trout$flag == "A", 26)
Trout$flag <- replace(Trout$flag, Trout$flag == "C", 27)
Trout$flag <- replace(Trout$flag, Trout$flag == "E", 28)
Trout$flag <- replace(Trout$flag, Trout$flag == "F", 29)
Trout$flag <- replace(Trout$flag, Trout$flag == "G", 30)