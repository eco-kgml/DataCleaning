library(EDIutils)
library(tidyverse)
library(lubridate)
library(stringr)
library(data.table)

# Creating data table
Sparkling <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Sparkling) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes
#LTER: High Frequency Water Temperature Data - Sparkling Lake Raft 1989
#- current ver 24. Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/52ceba5984c4497d158093f32b23b76d 
res <- read_data_entity_names(packageId = "knb-lter-ntl.5.24")
raw <- read_data_entity(packageId = "knb-lter-ntl.5.24.r", entityId = res$entityId[3])
data <- readr::read_csv(file = raw)

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
res <- read_data_entity_names(packageId = "knb-lter-ntl.4.34")
raw <- read_data_entity(packageId = "knb-lter-ntl.4.34.r", entityId = res$entityId[3])
data <- readr::read_csv(file = raw)




data_a<- data.frame("datetime" = data$sampledate,
                     "lake" = rep("Sparkling", nrow(data)),
                     "depth" = rep(-2, nrow(data)),
                     "variable" = rep("par", nrow(data)),
                     "unit" = rep("MicroMOL-PER-M2-SEC", nrow(data)),
                     "observation" = data$par,
                     "flag" = data$flag_do_raw) %>%
  drop_na(observation)

Sparkling <- rbind(Sparkling, data_a)
rm(data_a)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. 
#North Temperate Lakes LTER: Secchi Disk Depth; Other Auxiliary 
#Base Crew Sample Data 1981 - current ver 32. Environmental Data Initiative.
#https://doi.org/10.6073/pasta/4c5b055143e8b7a5de695f4514e18142 
res <- read_data_entity_names(packageId = "knb-lter-ntl.31.32")
raw <- read_data_entity(packageId = "knb-lter-ntl.31.32.r", entityId = res$entityId[1])
data <- read_csv(raw)

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