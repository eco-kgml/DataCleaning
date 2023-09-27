#Read in Sparkling Lake data from EDI
#Author: Adi Tewari

library(EDIutils)
library(tidyverse)

# Creating data table
Sparkling <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Sparkling) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes
#LTER: High Frequency Water Temperature Data - Sparkling Lake Raft 1989
#- current ver 24. Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/52ceba5984c4497d158093f32b23b76d 

scope = "knb-lter-ntl"
identifier = 5
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[3])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a <- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Sparkling", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)


Sparkling <- rbind(Sparkling, data_a)
rm(data_a)


#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes 
#LTER: High Frequency Meteorological and Dissolved Oxygen Data - Sparkling Lake
#Raft 1989 - current ver 34. Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/9d054e35fb0b8d3a36b49b5e7a35f48f

scope = "knb-lter-ntl"
identifier = 4
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[3])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data_a<- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Sparkling", nrow(data)),
                     "depth" = rep(-2, nrow(data)),
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$par,
                     "flag" = data$flag_do_raw) %>%
  drop_na(observation)

data_b <- data.frame("datetime" = ymd(data$sampledate),
                     "lake" = rep("Sparkling",nrow(data)),
                     "depth" = rep(0,nrow(data)),
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$do_raw,
                     "flag" = data$flag_do_raw) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
Sparkling <- rbind(Sparkling, data_b)
rm(data_a, data_b)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. 
#North Temperate Lakes LTER: Secchi Disk Depth; Other Auxiliary 
#Base Crew Sample Data 1981 - current ver 32. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/4c5b055143e8b7a5de695f4514e18142 

scope = "knb-lter-ntl"
identifier = 31
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

sparkling_data <- data %>% filter(lakeid == "SP")


data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = 0,
                     "variable" = rep("secview", nrow(sparkling_data)),
                     "unit" = rep("M", nrow(sparkling_data)),
                     "observation" = sparkling_data$secview,
                     "flag" = rep(NA, nrow(sparkling_data))) %>%
  drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
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
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

sparkling_data <- data %>% filter(lakeid == "SP")

data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("temp", nrow(sparkling_data)),
                     "unit" = rep("DEG_C", nrow(sparkling_data)),
                     "observation" = sparkling_data$wtemp,
                     "flag" = sparkling_data$flagwtemp) %>% drop_na(observation)

#The variable below is from the same data set as above
data_b <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("do", nrow(sparkling_data)),
                     "unit" = rep("MilliGM-PER-L", nrow(sparkling_data)),
                     "observation" = sparkling_data$o2,
                     "flag" = sparkling_data$flago2) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
Sparkling <- rbind(Sparkling, data_b)
rm(data_a)
rm(data_b)
rm(sparkling_data)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley.
#2023. North Temperate Lakes LTER: Chemical Limnology of Primary Study Lakes:
#Nutrients, pH and Carbon 1981 - current ver 60. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/325232e6e4cd1ce04025fa5674f7b782 

# Total phosophorus unfiltered
res <- read_data_entity_names(packageId = "knb-lter-ntl.1.60")
raw <- read_data_entity(packageId = "knb-lter-ntl.1.60", entityId = res$entityId[1])
data <- readr::read_csv(file = raw)

sparkling_data <- data %>% filter(lakeid == "SP")

data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("tp", nrow(sparkling_data)),
                     "unit" = rep("MicroGM-PER-L", nrow(sparkling_data)),
                     "observation" = sparkling_data$totpuf ,
                     "flag" = sparkling_data$flagtotpuf) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
rm(data_a)

  
# TN (Total Nitrogen) Unfiltered
data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("tn", nrow(sparkling_data)),
                     "unit" = rep("MicroGM-PER-L", nrow(sparkling_data)),
                     "observation" = sparkling_data$totnuf,
                     "flag" = sparkling_data$flagtotnuf) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
rm(data_a)

#DIC (Dissolved Inorganic Carbon)
data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("dic", nrow(sparkling_data)),
                     "unit" = rep("MilliGM-PER-L", nrow(sparkling_data)),
                     "observation" = sparkling_data$dic,
                     "flag" = sparkling_data$flagdic) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
rm(data_a)

#DOC (Dissolved Organic Carbon)
data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("doc", nrow(sparkling_data)),
                     "unit" = rep("MilliGM-PER-L", nrow(sparkling_data)),
                     "observation" = sparkling_data$doc,
                     "flag" = sparkling_data$flagdoc) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
rm(data_a)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023.
#North Temperate Lakes LTER: Chlorophyll - Trout Lake Area 1981 - current ver 
#32. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/4a110bd6534525f96aa90348a1871f86 

#Chlorophyll a filtered
res <- read_data_entity_names(packageId = "knb-lter-ntl.35.32")
raw <- read_data_entity(packageId = "knb-lter-ntl.35.32", entityId = res$entityId[1])
data <- readr::read_csv(file = raw)

sparkling_data <- data %>% filter(lakeid == "SP")

data_a <- data.frame("datetime" = ymd(sparkling_data$sampledate),
                     "lake" = rep("Sparkling",nrow(sparkling_data)),
                     "depth" = sparkling_data$depth,
                     "variable" = rep("chlor", nrow(sparkling_data)),
                     "unit" = rep("MicroGM-PER-L", nrow(sparkling_data)),
                     "observation" = sparkling_data$chlor,
                     "flag" = sparkling_data$flagchlor) %>% drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
rm(data_a)