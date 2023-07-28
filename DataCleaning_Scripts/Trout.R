library(EDIutils)
library(tidyverse)
library(lubridate)
library(stringr)
library(data.table)

# Creating data table
Trout <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Trout) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")


# Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes 
# LTER: High Frequency Meteorological and Dissolved Oxygen Data - 
# Trout Lake Buoy 2004 - current ver 41. Environmental Data Initiative. 
# https://doi.org/10.6073/pasta/77d0536191a56c7dc32dbf5f6ec567be 
# (Accessed 2023-07-08).

res <- read_data_entity_names(packageId = "knb-lter-ntl.117.41")
raw <- read_data_entity(packageId = "knb-lter-ntl.117.41", entityId = res$entityId[3])
data <- readr::read_csv(file = raw)


data_a <- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Trout", nrow(data)),
                     "depth" = rep(0.5, nrow(data)),
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$do_raw,
                     "flag" = data$flag_do_raw) %>%
  drop_na(observation)

Trout <- rbind(Trout, data_a)
rm(data_a)

data_b <- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Trout", nrow(data)),
                     "depth" = rep(-2, nrow(data)),
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$par,
                     "flag" = data$flag_do_raw) %>%
  drop_na(observation)

Trout <- rbind(Trout, data_b)
rm(data_b)


#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. 
#North Temperate Lakes LTER: High Frequency Water Temperature Data 
#- Trout Lake Buoy 2004 - current ver 28. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/e1605901355d209dc588394312a4a38e 
#(Accessed 2023-07-20)

res <- read_data_entity_names(packageId = "knb-lter-ntl.116.28")
raw <- read_data_entity(packageId = "knb-lter-ntl.116.28", entityId = res$entityId[3])
data <- readr::read_csv(file = raw)

data_a <- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Trout", nrow(data)),
                     "depth" = data$depth,
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$wtemp,
                     "flag" = data$flag_wtemp) %>%
  drop_na(observation)


Trout <- rbind(Trout, data_a)
rm(data_a)


#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. 
#North Temperate Lakes LTER: Secchi Disk Depth; Other Auxiliary 
#Base Crew Sample Data 1981 - current ver 32. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/4c5b055143e8b7a5de695f4514e18142 

res <- read_data_entity_names(packageId = "knb-lter-ntl.31.32")
raw <- read_data_entity(packageId = "knb-lter-ntl.31.32.r", entityId = res$entityId[1])
data <- read_csv(raw)

trout_data <- data %>% filter(lakeid == "TR")


data_a <- data.frame("datetime" = ymd(trout_data$sampledate),
                     "lake" = rep("Trout",nrow(trout_data)),
                     "depth" = 0,
                     "variable" = rep("secview", nrow(trout_data)),
                     "unit" = rep("M", nrow(trout_data)),
                     "observation" = trout_data$secview,
                     "flag" = rep(NA, nrow(trout_data))) %>%
  drop_na(observation)

Trout <- rbind(Trout, data_a)
rm(data_a)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes 
#LTER: Physical Limnology of Primary Study Lakes 1981 - current ver 35. 
#Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/be287e7772951024ec98d73fa94eec08
res <- read_data_entity_names(packageId = "knb-lter-ntl.29.35")

raw <- read_data_entity(packageId = "knb-lter-ntl.29.35.r", entityId = res$entityId[1])

data <- read_csv(raw)

trout_data <- data %>% filter(lakeid == "TR")

data_a <- data.frame("datetime" = ymd(trout_data$sampledate),
                     "lake" = rep("Trout",nrow(trout_data)),
                     "depth" = trout_data$depth,
                     "variable" = rep("temp", nrow(trout_data)),
                     "unit" = rep("DEG_C", nrow(trout_data)),
                     "observation" = trout_data$wtemp,
                     "flag" = trout_data$flagwtemp) %>% drop_na(observation)

#The variable below is from the same data set as above
data_b <- data.frame("datetime" = ymd(trout_data$sampledate),
                     "lake" = rep("Trout",nrow(trout_data)),
                     "depth" = trout_data$depth,
                     "variable" = rep("do", nrow(trout_data)),
                     "unit" = rep("MilliGM-PER-L", nrow(trout_data)),
                     "observation" = trout_data$o2,
                     "flag" = trout_data$flago2) %>% drop_na(observation)

Trout <- rbind(Trout, data_a)
Trout <- rbind(Trout, data_b)
rm(data_a)
rm(data_b)
