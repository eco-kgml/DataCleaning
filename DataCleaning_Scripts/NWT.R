#Read in NWT-LTER Lake data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
NWT <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NWT) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

# McKnight, D., S. Yevak, S. Dykema, K. Loria, and Niwot Ridge LTER. 2023. Water quality data for Green Lakes Valley, 
# 2000 - ongoing. ver 8. Environmental Data Initiative. https://doi.org/10.6073/pasta/2b9271ce9c27c939696fff96553a7bd2 (Accessed 2023-10-26).

scope = "knb-lter-nwt"
identifier = 157
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data$depth[data$depth == "below_ice" | data$depth == "NaN"] <- NA

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_chla <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = ymd(data$date),
                     "lake_id" = data$local_site,
                     "depth" = data$depth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$chl_a,
                     "flag" = data$flag) %>%
  drop_na(observation)
data_temp <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = ymd(data$date),
                        "lake_id" = data$local_site,
                        "depth" = data$depth,
                        "variable" = rep("temp", nrow(data)),
                        "unit" = rep("DEG_C", nrow(data)),
                        "observation" = data$temp,
                        "flag" = data$flag) %>%
  drop_na(observation)
data_do <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = ymd(data$date),
                        "lake_id" = data$local_site,
                        "depth" = data$depth,
                        "variable" = rep("do", nrow(data)),
                        "unit" = rep("MilliGM-PER-L", nrow(data)),
                        "observation" = data$DO,
                        "flag" = data$flag) %>%
  drop_na(observation)
data_nitrate <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = ymd(data$date),
                        "lake_id" = data$local_site,
                        "depth" = data$depth,
                        "variable" = rep("no3no2", nrow(data)),
                        "unit" = rep("MicroGM-PER-L", nrow(data)),
                        "observation" = data$nitrate * 1000,
                        "flag" = data$flag) %>%
  drop_na(observation)
data_secchi <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = ymd(data$date),
                        "lake_id" = data$local_site,
                        "depth" = NA,
                        "variable" = rep("secchi", nrow(data)),
                        "unit" = rep("M", nrow(data)),
                        "observation" = data$secchi,
                        "flag" = data$flag) %>%
  drop_na(observation)
data_par <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                          "datetime" = ymd(data$date),
                          "lake_id" = data$local_site,
                          "depth" = data$depth,
                          "variable" = rep("par", nrow(data)),
                          "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                          "observation" = data$PAR,
                          "flag" = data$flag) %>%
  drop_na(observation)

NWT <- rbind(NWT, data_chla) %>% 
  rbind(data_temp) %>%
  rbind(data_do) %>%
  rbind(data_nitrate) %>%
  rbind(data_secchi) %>%
  rbind(data_par)
rm(data_chla, data_temp, data_do, data_nitrate, data_secchi, data_par)

# Mcknight, D., P. Johnson, K. Loria, Niwot Ridge LTER, and S. Dykema. 2021. Stream and lake water 
# chemistry data for Green Lakes Valley, 1998 - ongoing. ver 3. Environmental Data Initiative. 
# https://doi.org/10.6073/pasta/811e22e67aa850fa6c03148ab621e76e (Accessed 2023-10-26).

scope = "knb-lter-nwt"
identifier = 10
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data <- data %>% filter(location == "LAKE")

data$date <- as.character(data$date)
data[data == "NP"] <- NA
data[data == "u"] <- "0"
data[data == "NaN"] <- NA
data$date <- as.Date(data$date)

data_nh4 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = ymd(data$date),
                       "lake_id" = data$local_site,
                       "depth" = data$depth,
                       "variable" = rep("nh4", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = as.numeric(data$`NH4+`) * 18.04, # convert microequivalents to micrograms
                       "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)
data_no3 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = ymd(data$date),
                       "lake_id" = data$local_site,
                       "depth" = data$depth,
                       "variable" = rep("no3", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = as.numeric(data$`NO3-`) * 62, # convert microequivalents to micrograms
                       "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)
data_tn <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = ymd(data$date),
                       "lake_id" = data$local_site,
                       "depth" = data$depth,
                       "variable" = rep("tn", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = as.numeric(data$TN) * (1/0.071394), # convert micromoles to micrograms
                       "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)
data_tp <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                      "datetime" = ymd(data$date),
                      "lake_id" = data$local_site,
                      "depth" = data$depth,
                      "variable" = rep("tp", nrow(data)),
                      "unit" = rep("MicroGM-PER-L", nrow(data)),
                      "observation" = as.numeric(data$TP) * (1/0.032285), # convert micromoles to micrograms
                      "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)
data_doc <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                      "datetime" = ymd(data$date),
                      "lake_id" = data$local_site,
                      "depth" = data$depth,
                      "variable" = rep("doc", nrow(data)),
                      "unit" = rep("MilliGM-PER-L", nrow(data)),
                      "observation" = as.numeric(data$DOC), # convert micromoles to micrograms
                      "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)
data_poc <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = ymd(data$date),
                       "lake_id" = data$local_site,
                       "depth" = data$depth,
                       "variable" = rep("poc", nrow(data)),
                       "unit" = rep("MilliGM-PER-L", nrow(data)),
                       "observation" = as.numeric(data$POC), # convert micromoles to micrograms
                       "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)

NWT <- rbind(NWT, data_nh4) %>% 
  rbind(data_no3) %>%
  rbind(data_tn) %>%
  rbind(data_tp) %>%
  rbind(data_doc) %>%
  rbind(data_poc)
rm(data_nh4, data_no3, data_tn, data_tp, data_doc, data_poc)

NWT <- NWT %>% filter(lake_id == "GL4")

NWT$flag <- replace(NWT$flag, NWT$flag == "NaN" | NWT$flag == "Q(conduct)" | NWT$flag == "Q(std_conduct)" | NWT$flag == "pH_out_of_range Q(std_conduct)", NA)
NWT$flag <- replace(NWT$flag, NWT$flag == "pH_out_of_range", 8)
NWT$flag <- replace(NWT$flag, NWT$flag == "Q(NO3)", 29)
NWT$flag <- replace(NWT$flag, NWT$flag == "duplicate", 44)

NWT$flag <- replace(NWT$flag, grepl("<", NWT$observation), 19)
NWT$observation <- replace(NWT$observation, grepl("<", NWT$observation), 0)



