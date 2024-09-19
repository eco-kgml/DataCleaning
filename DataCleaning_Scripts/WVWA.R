#Read in WVWA data from EDI
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
packageId_ctd = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_ctd)
raw <- read_data_entity(packageId = packageId_ctd, entityId = res$entityId[1])
ctd <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_ctd)
}

#2: inflow
scope = "edi"
identifier = 202
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_inflow = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_inflow)
raw <- read_data_entity(packageId = packageId_inflow, entityId = res$entityId[1])
inflow <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_inflow)
}

#3. FCR catwalk
scope = "edi"
identifier = 271
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_catwalk = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_catwalk)
raw <- read_data_entity(packageId = packageId_catwalk, entityId = res$entityId[1])
catwalk <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_catwalk)
}

#4. chemistry
scope = "edi"
identifier = 199
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_chemistry = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_chemistry)
raw <- read_data_entity(packageId = packageId_chemistry, entityId = res$entityId[1])
chem <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_chemistry)
}

#5. Secchi
scope = "edi"
identifier = 198
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_secchi = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_secchi)
raw <- read_data_entity(packageId = packageId_secchi, entityId = res$entityId[1])
secchi <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_secchi)
}

#6. YSI
scope = "edi"
identifier = 198
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_ysi = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_ysi)
raw <- read_data_entity(packageId = packageId_ysi, entityId = res$entityId[2])
ysi <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_ysi)
}

#7. Filtered chl-a
scope = "edi"
identifier = 555
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_chla = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_chla)
raw <- read_data_entity(packageId = packageId_chla, entityId = res$entityId[1])
chla <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_chla)
}

#8. BVR HF
scope = "edi"
identifier = 725
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId_BVRHF = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId_BVRHF)
raw <- read_data_entity(packageId = packageId_BVRHF, entityId = res$entityId[4])
BVRHF <- readr::read_csv(file = raw, show_col_types = FALSE)

if (exists("provenance")){
  provenance <- append(provenance, packageId_BVRHF)
}

##### REFORMAT DATA #####
library(tidyverse)
library(lubridate)
library(data.table)

#1. CTD
colnames(ctd)

ctd1 <- ctd %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake_id, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake_id, depth, variable, unit, observation, name)
head(ctd1)

ctd2 <- ctd %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake_id, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake_id, depth, variable, unit, flag, name)
head(ctd2)

ctd3 <- bind_cols(ctd1, ctd2$flag) %>%
  rename(flag = `...8`) %>%
  select(-name) %>%
  mutate(depth = as.double(depth), source = paste("EDI", packageId_ctd))%>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)
head(ctd3)

ctd3$flag <- replace(ctd3$flag, nchar(ctd3$flag) >= 2, 46)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 0, NA)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 1, 3)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 2, 21)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 3, 24)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 4, 23)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 5, 27)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 6, 31)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 7, 32)
ctd3$flag <- replace(ctd3$flag, ctd3$flag == 8, 8)

#2. inflow
colnames(inflow)
inflow1 <- inflow %>%
  filter(Reservoir == "FCR" & Site == 100) %>%
  select(DateTime, Reservoir, WVWA_Flow_cms, Flag_WVWA_Flow_cms) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir,
         observation = WVWA_Flow_cms,
         flag = Flag_WVWA_Flow_cms) %>%
  add_column(unit = "M3-PER-SEC",
             variable = "inflow",
             depth = NA) %>%
  mutate(source = paste("EDI", packageId_inflow)) %>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)
head(inflow1)

inflow1$flag <- replace(inflow1$flag, nchar(inflow1$flag) >= 2, 46)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 0, NA)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 1, 33)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 2, 28)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 3, 34)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 4, 35)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 5, 36)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 6, 37)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 7, 38)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 8, 39)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 13, 40)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 16, 41)
inflow1$flag <- replace(inflow1$flag, inflow1$flag == 24, 42)

#3. catwalk
colnames(catwalk)
catwalk1 <- catwalk %>%
  select(DateTime, Reservoir, ThermistorTemp_C_surface:ThermistorTemp_C_9, EXOTemp_C_1, RDOTemp_C_5, RDOTemp_C_9, EXODO_mgL_1, RDO_mgL_5, RDO_mgL_9,  EXOChla_ugL_1, EXOBGAPC_RFU_1, EXOfDOM_RFU_1, Flag_ThermistorTemp_C_surface:Flag_ThermistorTemp_C_9, Flag_RDO_mgL_5, Flag_RDOTemp_C_5, Flag_RDO_mgL_9, Flag_RDOTemp_C_9, Flag_EXOTemp_C_1, Flag_EXODO_mgL_1, Flag_EXOChla_ugL_1, Flag_EXOBGAPC_RFU_1, Flag_EXOfDOM_RFU_1) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir) %>%
  pivot_longer(-c(datetime, lake_id)) %>%
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
  select(datetime, lake_id, depth, variable, unit, observation, name)
head(catwalk1)

catwalk2 <- catwalk %>%
  select(DateTime, Reservoir, ThermistorTemp_C_surface:ThermistorTemp_C_9, EXOTemp_C_1, RDOTemp_C_5, RDOTemp_C_9, EXODO_mgL_1, RDO_mgL_5, RDO_mgL_9,  EXOChla_ugL_1, EXOBGAPC_RFU_1, EXOfDOM_RFU_1, Flag_ThermistorTemp_C_surface:Flag_ThermistorTemp_C_9, Flag_RDO_mgL_5, Flag_RDOTemp_C_5, Flag_RDO_mgL_9, Flag_RDOTemp_C_9, Flag_EXOTemp_C_1, Flag_EXODO_mgL_1, Flag_EXOChla_ugL_1, Flag_EXOBGAPC_RFU_1, Flag_EXOfDOM_RFU_1) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir) %>%
  pivot_longer(-c(datetime, lake_id)) %>%
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
  select(datetime, lake_id, depth, variable, unit, flag, name)
head(catwalk2)

catwalk3 <- left_join(catwalk1, catwalk2, by = c("datetime","lake_id","depth","variable","unit","name")) %>%
  select(-name) %>%
  mutate(depth = as.double(depth), source = paste("EDI", packageId_catwalk))%>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)
head(catwalk3)

catwalk3$flag <- replace(catwalk3$flag, nchar(catwalk3$flag) >= 2, 46)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 0, NA)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 1, 39)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 2, 49)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 3, 47)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 4, 47)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 5, 30)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 6, 30)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 7, 11)
catwalk3$flag <- replace(catwalk3$flag, catwalk3$flag == 8, 48)

#'4. water chemistry 
colnames(chem)
chem1 <- chem %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(-Site,-Rep, -DC_mgL, -DN_mgL, -Flag_DC_mgL, -Flag_DN_mgL, -Flag_DateTime) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake_id, depth)) %>%
  mutate(variable = str_extract(name, 'TP|TN|SRP|NH4|NO3NO2|DIC|DOC')) %>%
  mutate(variable = ifelse(variable == "TP","tp",
                           ifelse(variable == "TN","tn",
                                  ifelse(variable == "SRP","drp",
                                         ifelse(variable == "NO3NO2","no3no2",
                                                ifelse(variable == "NH4","nh4",
                                                      ifelse(variable == "DIC","dic","doc_mgl"))))))) %>%
  mutate(unit = ifelse(variable %in% c("tp","tn","drp","no3no2", "nh4"),"MicroGM-PER-L","MilliGM-PER-L")) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake_id, depth, variable, unit, observation, name)
head(chem1)

chem2 <- chem %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(-Site,-Rep, -DC_mgL, -DN_mgL, -Flag_DC_mgL, -Flag_DN_mgL, -Flag_DateTime) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake_id, depth)) %>%
  mutate(variable = str_extract(name, 'TP|TN|SRP|NH4|NO3NO2|DIC|DOC')) %>%
  mutate(variable = ifelse(variable == "TP","tp",
                           ifelse(variable == "TN","tn",
                                  ifelse(variable == "SRP","drp",
                                         ifelse(variable == "NO3NO2","no3no2",
                                                ifelse(variable == "NH4","nh4",
                                                    ifelse(variable == "DIC","dic","doc_mgl"))))))) %>%
  mutate(unit = ifelse(variable %in% c("tp","tn","drp","no3", "nh4"),"MicroGM-PER-L","MilliGM-PER-L")) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake_id, depth, variable, unit, flag, name)
head(chem2)

chem1$variable <- replace(chem1$variable, chem2$variable == "doc_mgl", "doc")
chem1$variable <- replace(chem1$variable, chem2$variable == "DIC", "dic")

chem2$variable <- replace(chem2$variable, chem2$variable == "doc_mgl", "doc")
chem2$variable <- replace(chem2$variable, chem2$variable == "DIC", "dic")

chem3 <- bind_cols(chem1, chem2$flag) %>%
  rename(flag = `...8`) %>%
  select(-name) %>%
  mutate(depth = as.double(depth), source = paste("EDI", packageId_chemistry))%>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)

chem3$observation[chem3$variable == "no3no2"] <- chem3$observation[chem3$variable == "no3no2"] / 4.42664 #FCR and BVR have incredibly low no2 concentrations, meaning using the molar mass of no3 to convert from no3no2 to no3no2-n is more accurate.
chem3$observation[chem3$variable == "nh4"] <- chem3$observation[chem3$variable == "nh4"] / 1.28786

head(chem3)

chem3$flag <- replace(chem3$flag, nchar(chem3$flag) >= 2, 46)
chem3$flag <- replace(chem3$flag, chem3$flag == 0, NA)
chem3$flag <- replace(chem3$flag, chem3$flag == 1, 3)
chem3$flag <- replace(chem3$flag, chem3$flag == 2, 21)
chem3$flag <- replace(chem3$flag, chem3$flag == 3, 24)
chem3$flag <- replace(chem3$flag, chem3$flag == 4, 23)
chem3$flag <- replace(chem3$flag, chem3$flag == 5, 35)
chem3$flag <- replace(chem3$flag, chem3$flag == 6, 10)
chem3$flag <- replace(chem3$flag, chem3$flag == 7, 5)
chem3$flag <- replace(chem3$flag, chem3$flag == 8, 43)
chem3$flag <- replace(chem3$flag, chem3$flag == 9, 1)

#5. Secchi
colnames(secchi)
secchi1 <- secchi %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(DateTime, Reservoir, Secchi_m, Flag_Secchi_m) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir,
         observation = Secchi_m,
         flag = Flag_Secchi_m) %>%
  add_column(unit = "M",
             variable = "secchi",
             depth = NA) %>%
  mutate(source = paste("EDI", packageId_secchi)) %>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)
head(secchi1)

secchi1$flag <- replace(secchi1$flag, secchi1$flag == 0, NA)
secchi1$flag <- replace(secchi1$flag, secchi1$flag == 1, 32)

#6. YSI
colnames(ysi)

ysi1 <- ysi %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake_id, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(observation = value) %>%
  filter(!grepl("Flag",name)) %>%
  select(datetime, lake_id, depth, variable, unit, observation, name)
head(ysi1)

ysi2 <- ysi %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake_id, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temp",
                           ifelse(variable == "DO","do","par"))) %>%
  mutate(unit = ifelse(variable == "temp","DEG_C",
                       ifelse(variable == "do","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
  filter(!(variable == "par" & depth >= 0)) %>%
  rename(flag = value) %>%
  filter(grepl("Flag",name)) %>%
  mutate(name = gsub("Flag_","",name)) %>%
  select(datetime, lake_id, depth, variable, unit, flag, name)
head(ysi2)

ysi3 <- bind_cols(ysi1, ysi2$flag) %>%
  rename(flag = `...8`) %>%
  select(-name) %>%
  mutate(depth = as.double(depth), source = paste("EDI", packageId_ysi))%>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)
head(ysi3)

ysi3$flag <- replace(ysi3$flag, nchar(ysi3$flag) >= 2, 46)
ysi3$flag <- replace(ysi3$flag, ysi3$flag == 0, NA)
ysi3$flag <- replace(ysi3$flag, ysi3$flag == 1, 3)
ysi3$flag <- replace(ysi3$flag, ysi3$flag == 2, 21)
ysi3$flag <- replace(ysi3$flag, ysi3$flag == 3, 24)
ysi3$flag <- replace(ysi3$flag, ysi3$flag == 4, 23)
ysi3$flag <- replace(ysi3$flag, ysi3$flag == 5, 1)

#7. filtered chl-a
colnames(chla)
chla1 <- chla %>%
  filter(Reservoir == "FCR" & Site == 50 | Reservoir == "BVR" & Site == 50) %>%
  select(DateTime, Depth_m, Reservoir, Chla_ugL, Flag_Chla_ugL) %>%
  rename(datetime = DateTime,
         lake_id = Reservoir,
         depth = Depth_m,
         observation = Chla_ugL,
         flag = Flag_Chla_ugL) %>%
  add_column(unit = "MicroGM-PER-L",
             variable = "chla") %>%
  mutate(source = paste("EDI", packageId_chla)) %>%
  select(source, datetime, lake_id, depth, variable, unit, observation, flag)
head(chla1)

chla1$flag <- replace(chla1$flag, nchar(chla1$flag) >= 2, 46)
chla1$flag <- replace(chla1$flag, chla1$flag == 0, NA)
chla1$flag <- replace(chla1$flag, chla1$flag == 1, 24)
chla1$flag <- replace(chla1$flag, chla1$flag == 2, 3)
chla1$flag <- replace(chla1$flag, chla1$flag == 3, 44)
chla1$flag <- replace(chla1$flag, chla1$flag == 4, 45)
chla1$flag <- replace(chla1$flag, chla1$flag == 5, 5)

#8. BVR High Frequency Data
BVRHF_HoboMini <- BVRHF %>% 
  select(-contains("Flag"), -contains("EXO")) %>% # Flags only indicate missing data, which is removed later.
  pivot_longer(cols = 4:21) %>% 
  filter(Reservoir == "BVR" & Site == 50) %>%
  rowwise() %>%
  mutate(depth = strsplit(name, "_(?!.*_)", perl=TRUE)[[1]][2],
         name2 = strsplit(name, "_(?!.*_)", perl=TRUE)[[1]][1]) %>%
  ungroup() %>%
  mutate(variable = case_when(name2 == "HoboTemp_C" ~ "temp",
                              name2 == "MiniDotTemp_C" ~ "temp",
                              name2 == "MiniDotDO_mgL" ~ "do"),
         unit = case_when(name2 == "HoboTemp_C" ~ "DEG_C",
                          name2 == "MiniDotTemp_C" ~ "DEG_C",
                          name2 == "MiniDotDO_mgL" ~ "MilliGM-PER-L")) %>%
  filter(variable == "temp" | variable == "do")
BVRHF_HoboMini <- data.frame("source" = rep(paste("EDI", packageId_BVRHF), nrow(BVRHF_HoboMini)),
                       "datetime" = BVRHF_HoboMini$DateTime,
                       "lake_id" = BVRHF_HoboMini$Reservoir,
                       "depth" = BVRHF_HoboMini$depth,
                       "variable" = BVRHF_HoboMini$variable,
                       "unit" = BVRHF_HoboMini$unit,
                       "observation" = BVRHF_HoboMini$value,
                       "flag" = NA) %>% 
  drop_na(observation)

BVRHF_EXOdo <- data.frame("source" = rep(paste("EDI", packageId_BVRHF), nrow(BVRHF)),
                              "datetime" = BVRHF$DateTime,
                              "lake_id" = BVRHF$Reservoir,
                              "depth" = BVRHF$EXODepth_m,
                              "variable" = "do",
                              "unit" = "MilliGM-PER-L",
                              "observation" = BVRHF$EXODO_mgL_1.5,
                              "flag" = NA) %>% 
  drop_na(observation)
BVRHF_EXOchla <- data.frame("source" = rep(paste("EDI", packageId_BVRHF), nrow(BVRHF)),
                         "datetime" = BVRHF$DateTime,
                         "lake_id" = BVRHF$Reservoir,
                         "depth" = BVRHF$EXODepth_m,
                         "variable" = "chla",
                         "unit" = "RFU",
                         "observation" = BVRHF$EXOChla_RFU_1.5,
                         "flag" = NA) %>% 
  drop_na(observation)
BVRHF_EXOfdom <- data.frame("source" = rep(paste("EDI", packageId_BVRHF), nrow(BVRHF)),
                             "datetime" = BVRHF$DateTime,
                             "lake_id" = BVRHF$Reservoir,
                             "depth" = BVRHF$EXODepth_m,
                             "variable" = "fdom",
                             "unit" = "RFU",
                             "observation" = BVRHF$EXOfDOM_RFU_1.5,
                             "flag" = NA) %>% 
  drop_na(observation)

source("DataCleaning_Scripts/BVR.R")
HLW_FLARE_output2 <- HLW_FLARE_output %>% 
  mutate(var = case_when(Variable == "temperature" ~ "temp",
                         Variable == "oxygen" ~ "do",
                         Variable == "fdom" ~ "fdom",
                         Variable == "chla" ~ "chla"),
         unit = case_when(Units == "C" ~ "DEG_C",
                          Units == "mgL" ~ "MilliGM-PER-L",
                          Units == "RFU" ~ "RFU")) %>%
  filter(is.na(var) == FALSE & is.na(unit) == FALSE)
HLW_FLARE_output3 <- data.frame("source" = rep(paste("EDI", packageId_BVRHF), nrow(HLW_FLARE_output2)),
                                "datetime" = HLW_FLARE_output2$DateTime,
                                "lake_id" = HLW_FLARE_output2$Reservoir,
                                "depth" = HLW_FLARE_output2$Depth,
                                "variable" = HLW_FLARE_output2$var,
                                "unit" = HLW_FLARE_output2$unit,
                                "observation" = HLW_FLARE_output2$Reading,
                                "flag" = NA) %>% 
  drop_na(observation)

BVRHF_all <- rbind(BVRHF_HoboMini, BVRHF_EXOdo) %>% 
  rbind(BVRHF_EXOchla) %>% 
  rbind(BVRHF_EXOfdom) %>% 
  rbind(HLW_FLARE_output3)
rm(BVRHF_HoboMini, BVRHF_EXOdo, BVRHF_EXOchla, BVRHF_EXOfdom, HLW_FLARE_output, HLW_FLARE_output2, HLW_FLARE_output3)

#### MERGE DATA ####
# FCR <- bind_rows(ctd3, inflow1) %>% 
#   bind_rows(., catwalk3) %>% 
#   bind_rows(., chem3) %>% 
#   bind_rows(., secchi1) %>% 
#   bind_rows(., ysi3) %>% 
#   bind_rows(., chla1) 

WVWA_LF <- rbind(chem3, secchi1) %>% rbind(ysi3) %>% rbind(chla1)
WVWA_LF <- drop_na(WVWA_LF, observation)

WVWA_HF <- rbind(ctd3, inflow1) %>% rbind(catwalk3) %>% rbind(BVRHF_all)
WVWA_HF <- drop_na(WVWA_HF, observation)

rm(catwalk, catwalk1, catwalk2, catwalk3, chem, chem1, chem2, chem3, chla, chla1,
   ctd, ctd1, ctd2, ctd3, inflow, inflow1, secchi, secchi1, ysi, ysi1, ysi2, ysi3,
   res, raw, packageId_catwalk, packageId_chemistry, packageId_chla, packageId_ctd,
   packageId_inflow, packageId_secchi, packageId_ysi, identifier, revision, scope, BVRHF, BVRHF_all, packageId_BVRHF)


