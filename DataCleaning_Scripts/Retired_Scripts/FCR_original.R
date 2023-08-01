#Read in FCR data from EDI
#Author: Mary Lofton
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

#1. CTD
inUrl1  <- "https://portal.edirepository.org/nis/dataviewer?packageid=edi.200.13&entityid=27ceda6bc7fdec2e7d79a6e4fe16ffdf" 
infile1 <- paste0("./FCR_data_raw/CTD_2013_2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

#2: inflow
inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/202/9/c065ff822e73c747f378efe47f5af12b" 
infile1 <- paste0("./FCR_data_raw/Inflow_2013_2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

#3. catwalk
inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/271/7/71e6b946b751aa1b966ab5653b01077f" 
infile1 <- paste0("./FCR_data_raw/FCR_Catwalk_EDI_2018_2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

#4. chemistry
inUrl1  <- "https://portal.edirepository.org/nis/dataviewer?packageid=edi.199.11&entityid=509f39850b6f95628d10889d66885b76" 
infile1 <- paste0("./FCR_data_raw/chemistry_2013_2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

#5. Secchi
inUrl1  <- "https://portal.edirepository.org/nis/dataviewer?packageid=edi.198.11&entityid=81f396b3e910d3359907b7264e689052" 
infile1 <- paste0("./FCR_data_raw/Secchi_depth_2013-2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

#6. YSI
inUrl1  <- "https://portal.edirepository.org/nis/dataviewer?packageid=edi.198.11&entityid=6e5a0344231de7fcebbe6dc2bed0a1c3" 
infile1 <- paste0("./FCR_data_raw/YSI_PAR_profiles_2013-2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

#7. Filtered chl-a
inUrl1  <- "https://portal.edirepository.org/nis/dataviewer?packageid=edi.555.3&entityid=2f670c8316af634c76effdd205623912" 
infile1 <- paste0("./FCR_data_raw/manual_chlorophyll_2014-2022.csv")
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

##### REFORMAT DATA #####
library(tidyverse)
library(lubridate)
library(data.table)

#'Example data format:
#'datetime	      lake	   depth	variable	unit	observation	  flag
#'3/31/2020 18:00	Mendota	 1	    temp_c		      3.553285384

#1. CTD
ctd <- fread("./FCR_data_raw/CTD_2013_2022.csv")
colnames(ctd)

ctd1 <- ctd %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temperature",
                           ifelse(variable == "DO","do_mgl","par"))) %>%
  mutate(unit = ifelse(variable == "temperature","DEG_C",
                       ifelse(variable == "do_mgl","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
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
  mutate(variable = ifelse(variable == "Temp","temperature",
                           ifelse(variable == "DO","do_mgl","par"))) %>%
  mutate(unit = ifelse(variable == "temperature","DEG_C",
                       ifelse(variable == "do_mgl","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
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
inflow <- read_csv("./FCR_data_raw/Inflow_2013_2022.csv")
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
catwalk <- fread("./FCR_data_raw/FCR_Catwalk_EDI_2018_2022.csv")
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
  mutate(variable = ifelse(variable == "Temp","temperature",
                           ifelse(variable == "DO","do_mgl",
                                  ifelse(variable == "Chla","chlorophyll a",
                                         ifelse(variable == "BGAPC","phyco_rfu","fdomrfu"))))) %>%
  mutate(unit = ifelse(variable == "temperature","DEG_C",
                           ifelse(variable == "do_mgl","MilliGM-PER-L",
                                  ifelse(variable == "chlorophyll a","MicroGM-PER-L","RFU")))) %>%
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
  mutate(variable = ifelse(variable == "Temp","temperature",
                           ifelse(variable == "DO","do_mgl",
                                  ifelse(variable == "Chla","chlorophyll a",
                                         ifelse(variable == "BGAPC","phyco_rfu","fdomrfu"))))) %>%
  mutate(unit = ifelse(variable == "temperature","DEG_C",
                       ifelse(variable == "do_mgl","MilliGM-PER-L",
                              ifelse(variable == "chlorophyll a","MicroGM-PER-L","RFU")))) %>%
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
chem <- read_csv("./FCR_data_raw/chemistry_2013_2022.csv")
colnames(chem)
chem1 <- chem %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(-Site,-Rep, -DC_mgL, -DN_mgL, -Flag_DC_mgL, -Flag_DN_mgL, -Flag_DateTime) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'TP|TN|SRP|NH4|NO3NO2|DIC|DOC')) %>%
  mutate(variable = ifelse(variable == "TP","tp_ugl",
                           ifelse(variable == "TN","tn_ugl",
                                  ifelse(variable == "SRP","drp_ugl",
                                         ifelse(variable == "NO3NO2","no3_ugl",
                                                ifelse(variable == "DIC","dic_mgl","doc_mgl")))))) %>%
  mutate(unit = ifelse(variable %in% c("tp_ugl","tn_ugl","drp_ugl","no3_ugl"),"MicroGM-PER-L","MilliGM-PER-L")) %>%
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
  mutate(variable = ifelse(variable == "TP","tp_ugl",
                           ifelse(variable == "TN","tn_ugl",
                                  ifelse(variable == "SRP","drp_ugl",
                                         ifelse(variable == "NO3NO2","no3_ugl",
                                                ifelse(variable == "DIC","dic_mgl","doc_mgl")))))) %>%
  mutate(unit = ifelse(variable %in% c("tp_ugl","tn_ugl","drp_ugl","no3_ugl"),"MicroGM-PER-L","MilliGM-PER-L")) %>%
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
secchi <- read_csv("./FCR_data_raw/Secchi_depth_2013-2022.csv")
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
ysi <- read_csv("./FCR_data_raw/YSI_PAR_profiles_2013-2022.csv")
colnames(ysi)

ysi1 <- ysi %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Depth_m, Temp_C, DO_mgL, PAR_umolm2s, Flag_Temp_C, Flag_DO_mgL, Flag_PAR_umolm2s) %>%  
  rename(datetime = DateTime,
         lake = Reservoir,
         depth = Depth_m) %>%
  pivot_longer(-c(datetime, lake, depth)) %>%
  mutate(variable = str_extract(name, 'Temp|DO|PAR')) %>%
  mutate(variable = ifelse(variable == "Temp","temperature",
                           ifelse(variable == "DO","do_mgl","par"))) %>%
  mutate(unit = ifelse(variable == "temperature","DEG_C",
                       ifelse(variable == "do_mgl","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
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
  mutate(variable = ifelse(variable == "Temp","temperature",
                           ifelse(variable == "DO","do_mgl","par"))) %>%
  mutate(unit = ifelse(variable == "temperature","DEG_C",
                       ifelse(variable == "do_mgl","MilliGM-PER-L","MicroMOL-PER-M2-SEC"))) %>%
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
chla <- read_csv("./FCR_data_raw/manual_chlorophyll_2014-2022.csv")
colnames(chla)
chla1 <- chla %>%
  filter(Reservoir == "FCR" & Site == 50) %>%
  select(DateTime, Reservoir, Chla_ugL, Flag_Chla_ugL) %>%
  rename(datetime = DateTime,
         lake = Reservoir,
         observation = Chla_ugL,
         flag = Flag_Chla_ugL) %>%
  add_column(unit = "MicroGM-PER-L",
             variable = "chla_mgl",
             depth = NA) %>%
  select(datetime, lake, depth, variable, unit, observation, flag)
head(chla1)

#### MERGE DATA ####
df <- bind_rows(ctd3, inflow1) %>%
  bind_rows(., catwalk3) %>%
  bind_rows(., chem3) %>%
  bind_rows(., secchi1) %>%
  bind_rows(., ysi3) %>%
  bind_rows(., chla1)
write.csv(df, "./FCR.csv", row.names = FALSE)
