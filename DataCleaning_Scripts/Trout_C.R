#Read in Trout Lake high frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Trout <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Trout) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

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

# 2016
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[10])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()

# 2017
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[11])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()

# 2018
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[12])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()

# 2019
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[13])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()

# 2020
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[14])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()

# 2021
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[15])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()

# 2022
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[16])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("TR", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Trout <- rbind(Trout, data_a)
rm(data_a)
gc()
