#Read in FCR data from EDI
#Author: Mary Lofton (data curation and formatting), Bennett McAfee (EDIutils loading)
#Date: 09JUN23

#Purpose: Download and read in data from Falling Creek Reservoir stored in the 
#Environmental Data Initiative Repository and format it for Eco-KGML project

#Data needed:
#'1. CTD (water temp, DO)
#'2. inflow at weir (Q)
#'3. catwalk sensors (EXO chl-a, water temp)
#'4. water chemistry (SRP, DIN)
#'5. Secchi (Kd)
#'6. YSI (water temp, DO)
#'7. filtered chl-a

options(timeout=10000)


##### READ IN DATA #####

library(EDIutils)

#1. CTD
scope = "edi"
identifier = 200
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
ctd <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

#2: inflow
scope = "edi"
identifier = 202
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
inflow <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

#3. catwalk
scope = "edi"
identifier = 271
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
catwalk <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

#4. chemistry
scope = "edi"
identifier = 199
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
chem <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

#5. Secchi
scope = "edi"
identifier = 198
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
secchi <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

#6. YSI
scope = "edi"
identifier = 198
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[2])
ysi <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

#7. Filtered chl-a
scope = "edi"
identifier = 555
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
chla <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

##### REFORMAT DATA #####
library(tidyverse)
library(lubridate)
library(data.table)

#'Example data format:
#'datetime	      lake	   depth	variable	unit	observation	  flag
#'3/31/2020 18:00	Mendota	 1	    temp_c		      3.553285384

#1. CTD
colnames(ctd)

ctd1 <- ctd %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake, depth, variable, unit, observation, name)
head(ctd1)

ctd2 <- ctd %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake, depth, variable, unit, flag, name)
head(ctd2)

ctd3 <- bind_cols(ctd1, ctd2$flag) %>%
  rename(flag = `...8`) %>%
  select(-name) %>%
  mutate(depth = as.double(depth))
head(ctd3)

#2. inflow
colnames(inflow)
inflow1 <- inflow %>%
  filter(Reservoir == "FCR" & Site == 100) %>%
  select(DateTime, Reservoir, WVWA_Flow_cms, Flag_WVWA_Flow_cms) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         observation = WVWA_Flow_cms,
         flag = Flag_WVWA_Flow_cms) %>%
  add_column(unit = "cms",
             variable = "inflow",
             depth = NA) %>%
  select(datetime, lake, depth, variable, unit, observation, flag)
head(inflow1)

#3. catwalk
colnames(catwalk)
catwalk1 <- catwalk %>%
  select(DateTime, Reservoir, ThermistorTemp_C_surface:ThermistorTemp_C_9, EXOTemp_C_1, RDOTemp_C_5, RDOTemp_C_9, EXODO_mgL_1, RDO_mgL_5, RDO_mgL_9,  EXOChla_ugL_1, EXOBGAPC_RFU_1, EXOfDOM_RFU_1, Flag_ThermistorTemp_C_surface:Flag_ThermistorTemp_C_9, Flag_RDO_mgL_5, Flag_RDOTemp_C_5, Flag_RDO_mgL_9, Flag_RDOTemp_C_9, Flag_EXOTemp_C_1, Flag_EXODO_mgL_1, Flag_EXOChla_ugL_1, Flag_EXOBGAPC_RFU_1, Flag_EXOfDOM_RFU_1) %>%
  rename(datetime = DateTime,
         lake = Reservoir) %>%
  pivot_longer(-c(datetime, lake)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|Chla|BGAPC|fDOM'),
         depth = str_extract(name, 'surface|1|2|3|4|5|6|7|8|9')) %>%
  mutate(depth = ifelse(grepl("EXO",name),1.6,
                        ifelse(depth == "surface",0.1,depth))) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do",
                                  ifelse(variable == "Chla","chla",
                                         ifelse(variable == "BGAPC","phyco","fdom"))))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                           ifelse(variable == "do","MilliGM-PER-L",
                                  ifelse(variable == "chla","MicroGM-PER-L","RFU")))) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake, depth, variable, unit, observation, name)
head(catwalk1)

catwalk2 <- catwalk %>%
  select(DateTime, Reservoir, ThermistorTemp_C_surface:ThermistorTemp_C_9, EXOTemp_C_1, RDOTemp_C_5, RDOTemp_C_9, EXODO_mgL_1, RDO_mgL_5, RDO_mgL_9,  EXOChla_ugL_1, EXOBGAPC_RFU_1, EXOfDOM_RFU_1, Flag_ThermistorTemp_C_surface:Flag_ThermistorTemp_C_9, Flag_RDO_mgL_5, Flag_RDOTemp_C_5, Flag_RDO_mgL_9, Flag_RDOTemp_C_9, Flag_EXOTemp_C_1, Flag_EXODO_mgL_1, Flag_EXOChla_ugL_1, Flag_EXOBGAPC_RFU_1, Flag_EXOfDOM_RFU_1) %>%
  rename(datetime = DateTime,
         lake = Reservoir) %>%
  pivot_longer(-c(datetime, lake)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|Chla|BGAPC|fDOM'),
         depth = str_extract(name, 'surface|1|2|3|4|5|6|7|8|9')) %>%
  mutate(depth = ifelse(grepl("EXO",name),1.6,
                        ifelse(depth == "surface",0.1,depth))) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do",
                                  ifelse(variable == "Chla","chla",
                                         ifelse(variable == "BGAPC","phyco","fdom"))))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L",
                              ifelse(variable == "chla","MicroGM-PER-L","RFU")))) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake, depth, variable, unit, flag, name)
head(catwalk2)

catwalk3 <- left_join(catwalk1, catwalk2, by = c("datetime","lake","depth","variable","unit","name")) %>%
  select(-name) %>%
  mutate(depth = as.double(depth))
head(catwalk3)

#'4. water chemistry 
colnames(chem)
chem1 <- chem %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(-Site,-Rep, -DC_mgL, -DN_mgL, -Flag_DC_mgL, -Flag_DN_mgL, -Flag_DateTime) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'TP|TN|SRP|NH4|NO3NO2|DIC|DOC')) %>%
  mutate(variable = ifelse(variable == "TP","tp",
                           ifelse(variable == "TN","tn",
                                  ifelse(variable == "SRP","drp",
                                         ifelse(variable == "NO3NO2","no3",
                                                ifelse(variable == "DIC","dic","doc_mgl")))))) %>%
  mutate(unit = ifelse(variable %in% c("tp","tn","drp","no3"),"MicroGM-PER-L","MilliGM-PER-L")) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake, depth, variable, unit, observation, name)
head(chem1)

chem2 <- chem %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(-Site,-Rep, -DC_mgL, -DN_mgL, -Flag_DC_mgL, -Flag_DN_mgL, -Flag_DateTime) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'TP|TN|SRP|NH4|NO3NO2|DIC|DOC')) %>%
  mutate(variable = ifelse(variable == "TP","tp",
                           ifelse(variable == "TN","tn",
                                  ifelse(variable == "SRP","drp",
                                         ifelse(variable == "NO3NO2","no3",
                                                ifelse(variable == "DIC","dic","doc_mgl")))))) %>%
  mutate(unit = ifelse(variable %in% c("tp","tn","drp","no3"),"MicroGM-PER-L","MilliGM-PER-L")) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake, depth, variable, unit, flag, name)
head(chem2)

chem3 <- bind_cols(chem1, chem2$flag) %>%
  rename(flag = `...8`) %>%
  select(-name) %>%
  mutate(depth = as.double(depth))
head(chem3)

#5. Secchi
colnames(secchi)
secchi1 <- secchi %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Secchi_m, Flag_Secchi_m) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         observation = Secchi_m,
         flag = Flag_Secchi_m) %>%
  add_column(unit = "M",
             variable = "secchi",
             depth = NA) %>%
  select(datetime, lake, depth, variable, unit, observation, flag)
head(secchi1)

#6. YSI
colnames(ysi)

ysi1 <- ysi %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake, depth, variable, unit, observation, name)
head(ysi1)

ysi2 <- ysi %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake, depth, variable, unit, flag, name)
head(ysi2)

ysi3 <- bind_cols(ysi1, ysi2$flag) %>%
  rename(flag = `...8`) %>%
  select(-name) %>%
  mutate(depth = as.double(depth))
head(ysi3)

#7. filtered chl-a
colnames(chla)
chla1 <- chla %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Chla_ugL, Flag_Chla_ugL) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         observation = Chla_ugL,
         flag = Flag_Chla_ugL) %>%
  add_column(unit = "MicroGM-PER-L",
             variable = "chla",
             depth = NA) %>%
  select(datetime, lake, depth, variable, unit, observation, flag)
head(chla1)

#### MERGE DATA ####
FCR <- bind_rows(ctd3, inflow1) %>%
  bind_rows(., catwalk3) %>%
  bind_rows(., chem3) %>%
  bind_rows(., secchi1) %>%
  bind_rows(., ysi3) %>%
  bind_rows(., chla1)

rm(catwalk, catwalk1, catwalk2, catwalk3, chem, chem1, chem2, chem3, chla, chla1, ctd, ctd1, ctd2, ctd3, inflow, inflow1, secchi, secchi1, ysi, ysi1, ysi2, ysi3, res, raw)


