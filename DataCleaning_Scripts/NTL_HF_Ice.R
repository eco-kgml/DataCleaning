#Read in Mendota Under-Ice High Frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
NTL <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NTL) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

#### Lottig, N. 2022. High Frequency Under-Ice Water Temperature Buoy Data - 
#### Crystal Bog, Trout Bog, and Lake Mendota, Wisconsin, USA 2016-2020 ver 3. 
#### Environmental Data Initiative. https://doi.org/10.6073/pasta/ad192ce8fbe8175619d6a41aa2f72294 (Accessed 2023-06-09).

scope = "knb-lter-ntl"
identifier = 390
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}



data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$Sampledate,
                     "lake" = data$lake,
                     "depth" = data$depth_m,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$temperature,
                     "flag" = rep(NA, nrow(data)))

data_a$lake[data_a$lake == "Mendota"] <- "ME"
data_a$lake[data_a$lake == "Crystal Bog"] <- "CB"
data_a$lake[data_a$lake == "Trout Bog"] <- "TB"
NTL <- rbind(NTL, data_a)
rm(data_a)
