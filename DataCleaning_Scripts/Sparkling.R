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
res <- read_data_entity_names(packageId = "knb-lter-ntl.116.28")
raw <- read_data_entity(packageId = "knb-lter-ntl.116.28", entityId = res$entityId[3])
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