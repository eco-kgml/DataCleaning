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

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes
#LTER: High Frequency Water Temperature Data - Sparkling Lake Raft 1989
#- current ver 24. Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/52ceba5984c4497d158093f32b23b76d 
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