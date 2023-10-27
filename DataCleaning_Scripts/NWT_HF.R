#Read in High Frequency NWT-LTER Lake data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
NWT <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NWT) <- c("source", "datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

# Johnson, P., S. Yevak, S. Dykema, K. Loria, and Niwot Ridge LTER. 2023. PAR data for the Green Lake 4 buoy, 
# 2018 - ongoing. ver 4. Environmental Data Initiative. https://doi.org/10.6073/pasta/9b5abafd602c097c793dabcd9f5e0bb9 (Accessed 2023-10-26).

scope = "knb-lter-nwt"
identifier = 189
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = data$timestamp,
                        "lake" = data$local_site,
                        "depth" = data$depth,
                        "variable" = rep("par", nrow(data)),
                        "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                        "observation" = data$PAR,
                        "flag" = data$flag_PAR) %>%
  drop_na(observation)
data_b <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$timestamp,
                     "lake" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$temperature,
                     "flag" = data$flag_temperature) %>%
  drop_na(observation)

NWT <- rbind(NWT, data_a) %>% 
  rbind(data_b)
rm(data_a, data_b)

# Johnson, P., S. Yevak, S. Dykema, K. Loria, and Niwot Ridge LTER. 2023. 
# Temperature data for the Green Lake 4 buoy, 2018 - ongoing. ver 4. Environmental Data Initiative. 
# https://doi.org/10.6073/pasta/ce2c273eae068f5fa80df4ddd82f2643 (Accessed 2023-10-26).

scope = "knb-lter-nwt"
identifier = 188
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$timestamp,
                     "lake" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$temperature,
                     "flag" = data$flag_temperature) %>%
  drop_na(observation)

NWT <- rbind(NWT, data_a)
rm(data_a)

# Johnson, P., S. Yevak, S. Dykema, K. Loria, and Niwot Ridge LTER. 2023. Dissolved oxygen data for the Green Lake 4 buoy, 
# 2018 - ongoing. ver 4. Environmental Data Initiative. https://doi.org/10.6073/pasta/c88e9145afc953e9719c27d6111563f7 (Accessed 2023-10-26).

scope = "knb-lter-nwt"
identifier = 175
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$timestamp,
                     "lake" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$temperature,
                     "flag" = data$flag_temperature) %>%
  drop_na(observation)
data_b <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$timestamp,
                     "lake" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$DO,
                     "flag" = data$flag_DO) %>%
  drop_na(observation)

NWT <- rbind(NWT, data_a) %>% rbind(data_b)
rm(data_a, data_b)

# Johnson, P., S. Yevak, S. Dykema, K. Loria, and Niwot Ridge LTER. 2023. Chlorophyll-a 
# data for the Green Lake 4 buoy, 2018 - ongoing. ver 4. Environmental Data Initiative. 
# https://doi.org/10.6073/pasta/5e659c5f72a20ac3af7090cf2cba59d5 (Accessed 2023-10-26).

scope = "knb-lter-nwt"
identifier = 267
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$timestamp,
                     "lake" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$temperature,
                     "flag" = data$flag_temperature) %>%
  drop_na(observation)
data_b <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$timestamp,
                     "lake" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)), # actually ppb but equivalent to ug/L
                     "observation" = data$C7_output,
                     "flag" = data$flag_C7) %>%
  drop_na(observation)

NWT <- rbind(NWT, data_a) %>% rbind(data_b)
rm(data_a, data_b)

NWT <- distinct(NWT)
NWT$flag[NWT$flag == "n"] <- NA




