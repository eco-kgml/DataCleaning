#Read in Mendota Under-Ice High Frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Mendota <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Mendota) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

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

data <- data[data$lake == "Mendota",]
data_a <- data.frame("datetime" = strptime(data$Sampledate, format = '%Y-%m-%d %H:%M:%S'),
                     "lake" = data$lake,
                     "depth" = data$depth_m,
                     "variable" = rep("temp_C", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$temperature,
                     "flag" = rep(NA, nrow(data)))
Mendota <- rbind(Mendota, data_a)
rm(data_a)
