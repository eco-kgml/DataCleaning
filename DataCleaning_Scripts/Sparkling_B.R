#Read in Sparkling Temperature High Frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Sparkling <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(Sparkling) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

# Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes LTER: 
# High Frequency Water Temperature Data - Sparkling Lake Raft 1989 - current ver 24. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/52ceba5984c4497d158093f32b23b76d (Accessed 2023-10-26).

scope = "knb-lter-ntl"
identifier = 5
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

res <- read_data_entity_names(packageId = packageId)

# 2011
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[4])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("SP", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Sparkling <- rbind(Sparkling, data_a)
rm(data_a)
gc()

# 2012
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[5])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("SP", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Sparkling <- rbind(Sparkling, data_a)
rm(data_a)
gc()

# 2013
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[6])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("SP", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Sparkling <- rbind(Sparkling, data_a)
rm(data_a)
gc()

# 2014
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[7])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("SP", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Sparkling <- rbind(Sparkling, data_a)
rm(data_a)
gc()

# 2015
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[8])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("SP", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Sparkling <- rbind(Sparkling, data_a)
rm(data_a)
gc()

# 2016
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[9])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake" = rep("SP", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp)
Sparkling <- rbind(Sparkling, data_a)
rm(data_a)
gc()