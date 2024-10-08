#Read in NTL-LTER Lake data from EDI
#Author: Bennett McAfee & Adi Tewari

library(EDIutils)
library(tidyverse)

# Creating data table
NTL <- data.frame(matrix(ncol = 8, nrow = 0))
colnames(NTL) <- c("source", "datetime", "lake_id", "depth", "varbiable", "unit", "observation", "flag")

#### Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate 
#### Lakes LTER: Secchi Disk Depth; Other Auxiliary Base Crew Sample Data 1981 - 
#### current ver 32. Environmental Data Initiative. 
#### https://doi.org/10.6073/pasta/4c5b055143e8b7a5de695f4514e18142 (Accessed 2023-06-10).

scope = "knb-lter-ntl"
identifier = 31
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data$datetime <- as_datetime(paste(data$sampledate, "12:00:00"))

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = data$datetime,
                     "lake_id" = data$lakeid,
                     "depth" = NA,
                     "variable" = rep("secchi", nrow(data)),
                     "unit" = rep("M", nrow(data)),
                     "observation" = data$secnview,
                     "flag" = rep(NA, nrow(data))) %>%
  drop_na(observation)

NTL <- rbind(NTL, data_a)
rm(data_a)

####Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER
####:Chlorophyll - Madison Lakes Area 1995 - current ver 28. Environmental Data
#### Initiative. https://doi.org/10.6073/pasta/f9c2e1059bcf92f138e140950a3632f2 
#### (Accessed 2023-06-14).

scope = "knb-lter-ntl"
identifier = 38
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data$depth_range_m <- replace(data$depth_range_m, str_detect(data$depth_range_m, "-"), -99)

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                     "lake_id" = data$lakeid,
                     "depth" = data$depth_range_m,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$correct_chl_fluor,
                     "flag" = data$flag_spec)%>%
  drop_na(observation)

NTL <- rbind(NTL, data_a)
rm(data_a)

# Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes LTER: 
# Chlorophyll - Trout Lake Area 1981 - current ver 32. Environmental Data Initiative. 
# https://doi.org/10.6073/pasta/4a110bd6534525f96aa90348a1871f86 (Accessed 2023-10-24).

scope = "knb-lter-ntl"
identifier = 35
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                     "lake_id" = data$lakeid,
                     "depth" = data$depth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$chlor,
                     "flag" = data$flagchlor)%>%
  drop_na(observation)

NTL <- rbind(NTL, data_a)
rm(data_a)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes 
#LTER: Physical Limnology of Primary Study Lakes 1981 - current ver 35. 
#Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/be287e7772951024ec98d73fa94eec08

scope = "knb-lter-ntl"
identifier = 29
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                     "lake_id" = data$lakeid,
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flagwtemp) %>% drop_na(observation)
data_b <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                     "lake_id" = data$lakeid,
                     "depth" = data$depth,
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$o2,
                     "flag" = data$flago2) %>% drop_na(observation)
data_c <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                     "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                     "lake_id" = data$lakeid,
                     "depth" = data$depth,
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$light,
                     "flag" = NA) %>% 
  drop_na(observation)

NTL <- rbind(NTL, data_a)
NTL <- rbind(NTL, data_b)
NTL <- rbind(NTL, data_c)
rm(data_a)
rm(data_b)
rm(data_c)
rm(data)

# Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes LTER: Chemical Limnology of Primary Study Lakes: 
# Nutrients, pH and Carbon 1981 - current ver 59. Environmental Data Initiative. 
# https://doi.org/10.6073/pasta/c923b8e044310f3f5612dab09c2cc6c2 (Accessed 2023-09-21).

scope = "knb-lter-ntl"
identifier = 1
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_tp1 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("tp", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = data$totpuf,
                       "flag" = data$flagtotpuf)%>% 
  drop_na(observation)
data_tp2 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("tp", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = data$totpuf_sloh,
                       "flag" = data$flagtotpuf_sloh)%>% 
  drop_na(observation)
data_drp <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("drp", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = data$drp_sloh * 1000,
                       "flag" = data$flagdrp_sloh)%>% 
  drop_na(observation)
data_tn1 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("tn", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = data$totnuf,
                       "flag" = data$flagtotnuf)%>% 
  drop_na(observation)
data_tn2 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("tn", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = data$totnuf_sloh * 1000, # *1000 converts mg/L to ug/L
                       "flag" = data$flagtotnuf_sloh)%>% 
  drop_na(observation)
data_no3no2 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                          "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                          "lake_id" = data$lakeid,
                          "depth" = data$depth,
                          "variable" = rep("no3no2", nrow(data)),
                          "unit" = rep("MicroGM-PER-L", nrow(data)),
                          "observation" = data$no3no2,
                          "flag" = data$flagno3no2)%>% 
  drop_na(observation)
data_no3no2_2 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                            "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                            "lake_id" = data$lakeid,
                            "depth" = data$depth,
                            "variable" = rep("no3no2", nrow(data)),
                            "unit" = rep("MicroGM-PER-L", nrow(data)),
                            "observation" = data$no3no2_sloh * 1000, # *1000 converts mg/L to ug/L
                            "flag" = data$flagno3no2_sloh)%>% 
  drop_na(observation)
data_no2 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)), #NO2 is reported as NO2-N according to personal correspndance with Emily Stanley of the NTL-LTER
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("no2", nrow(data)),
                       "unit" = rep("MicroGM-PER-L", nrow(data)),
                       "observation" = data$no2,
                       "flag" = data$flagno2)%>% 
  drop_na(observation)
data_nh41 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                        "lake_id" = data$lakeid,
                        "depth" = data$depth,
                        "variable" = rep("nh4", nrow(data)),
                        "unit" = rep("MicroGM-PER-L", nrow(data)),
                        "observation" = data$nh4,
                        "flag" = data$flagnh4)%>% 
  drop_na(observation)
data_nh42 <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                        "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                        "lake_id" = data$lakeid,
                        "depth" = data$depth,
                        "variable" = rep("nh4", nrow(data)),
                        "unit" = rep("MicroGM-PER-L", nrow(data)),
                        "observation" = data$nh4_sloh,
                        "flag" = data$flagnh4_sloh)%>% 
  drop_na(observation)
data_dic <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("dic", nrow(data)),
                       "unit" = rep("MilliGM-PER-L", nrow(data)),
                       "observation" = data$dic,
                       "flag" = data$flagdic)%>% 
  drop_na(observation)
data_doc <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = data$lakeid,
                       "depth" = data$depth,
                       "variable" = rep("doc", nrow(data)),
                       "unit" = rep("MilliGM-PER-L", nrow(data)),
                       "observation" = data$doc,
                       "flag" = data$flagdoc)%>% 
  drop_na(observation)

NTL <- rbind(NTL, data_tp1)
NTL <- rbind(NTL, data_tp2)
NTL <- rbind(NTL, data_drp)
NTL <- rbind(NTL, data_tn1)
NTL <- rbind(NTL, data_tn2)
NTL <- rbind(NTL, data_no3no2)
NTL <- rbind(NTL, data_no3no2_2)
NTL <- rbind(NTL, data_no2)
NTL <- rbind(NTL, data_nh41)
NTL <- rbind(NTL, data_nh42)
NTL <- rbind(NTL, data_dic)
NTL <- rbind(NTL, data_doc)
rm(data_tp1, data_tp2, data_drp, data_tn1, data_tn2, data_no3no2, data_no3no2_2, data_no2, data_nh41, data_nh42, data_dic, data_doc)

# Hart, J., H. Dugan, C. Carey, E. Stanley, and P. Hanson. 2022. 
# Lake Mendota Carbon and Greenhouse Gas Measurements at North Temperate Lakes LTER 2016 ver 22. 
# Environmental Data Initiative. https://doi.org/10.6073/pasta/a2b38bc23fb0061e64ae76bbdec656fd (Accessed 2023-10-11).

scope = "knb-lter-ntl"
identifier = 339
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

data <- data %>% filter(sample_site == "Deep Hole")

data_poc <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = rep("ME", nrow(data)),
                       "depth" = data$water_depth,
                       "variable" = rep("poc", nrow(data)),
                       "unit" = rep("MilliGM-PER-L", nrow(data)),
                       "observation" = data$poc,
                       "flag" = rep(NA, nrow(data)))%>% 
  drop_na(observation)
data_doc <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = rep("ME", nrow(data)),
                       "depth" = data$water_depth,
                       "variable" = rep("doc", nrow(data)),
                       "unit" = rep("MilliGM-PER-L", nrow(data)),
                       "observation" = data$doc,
                       "flag" = rep(NA, nrow(data)))%>% 
  drop_na(observation)
data_dic <- data.frame("source" = rep(paste("EDI", packageId), nrow(data)),
                       "datetime" = as_datetime(paste(data$sampledate, "12:00:00")),
                       "lake_id" = rep("ME", nrow(data)),
                       "depth" = data$water_depth,
                       "variable" = rep("dic", nrow(data)),
                       "unit" = rep("MilliGM-PER-L", nrow(data)),
                       "observation" = data$dic,
                       "flag" = rep(NA, nrow(data)))%>% 
  drop_na(observation)

NTL <- rbind(NTL, data_poc)
NTL <- rbind(NTL, data_dic)
NTL <- rbind(NTL, data_doc)
rm(data_poc, data_dic, data_doc)

NTL$flag <- replace(NTL$flag, NTL$flag == "A", 1)
NTL$flag <- replace(NTL$flag, NTL$flag == "B", 2)
NTL$flag <- replace(NTL$flag, NTL$flag == "C", 3)
NTL$flag <- replace(NTL$flag, NTL$flag == "D", 4)
NTL$flag <- replace(NTL$flag, NTL$flag == "E" | NTL$flag == "e", 5)
NTL$flag <- replace(NTL$flag, NTL$flag == "F", 6)
NTL$flag <- replace(NTL$flag, NTL$flag == "G", 7)
NTL$flag <- replace(NTL$flag, NTL$flag == "H", 8)
NTL$flag <- replace(NTL$flag, NTL$flag == "I", 9)
NTL$flag <- replace(NTL$flag, NTL$flag == "J", 10)
NTL$flag <- replace(NTL$flag, NTL$flag == "K", 11)
NTL$flag <- replace(NTL$flag, NTL$flag == "L", 12)
NTL$flag <- replace(NTL$flag, NTL$flag == "M", 13)
NTL$flag <- replace(NTL$flag, NTL$flag == "N", 14)
NTL$flag <- replace(NTL$flag, NTL$flag == "O", 15)
NTL$flag <- replace(NTL$flag, NTL$flag == "P", 16)
NTL$flag <- replace(NTL$flag, NTL$flag == "Q", 17)
NTL$flag <- replace(NTL$flag, NTL$flag == "R", 18)
NTL$flag <- replace(NTL$flag, NTL$flag == "S", 19)
NTL$flag <- replace(NTL$flag, NTL$flag == "T", 20)
NTL$flag <- replace(NTL$flag, NTL$flag == "U", 21)
NTL$flag <- replace(NTL$flag, NTL$flag == "V" | NTL$flag == "v", 22)
NTL$flag <- replace(NTL$flag, NTL$flag == "W", 23)
NTL$flag <- replace(NTL$flag, NTL$flag == "X", 24)
NTL$flag <- replace(NTL$flag, NTL$flag == "Y", 47)
NTL$flag <- replace(NTL$flag, nchar(NTL$flag) >= 2 & NTL$flag != "NA", 46)
NTL$flag <- replace(NTL$flag, is.na(NTL$flag) == TRUE, 32)



