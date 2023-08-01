#Read in Mendota auxiliary data from EDI
#Author: Adi Tewari

library(EDIutils)
library(tidyverse)

# Creating data table
Mendota <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Mendota) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

####Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate 
####Lakes LTER: Secchi Disk Depth; Other Auxiliary Base Crew Sample Data 1981 - 
#### current ver 32. Environmental Data Initiative. 
#### https://doi.org/10.6073/pasta/4c5b055143e8b7a5de695f4514e18142 (Accessed 2023-06-10).
res <- read_data_entity_names(packageId = "knb-lter-ntl.31.32")
raw <- read_data_entity(packageId = "knb-lter-ntl.31.32.r", entityId = res$entityId[1])
data <- read_csv(raw)

mendota_data <- data %>% filter(lakeid == "ME")

data_a <- data.frame("datetime" = ymd(mendota_data$sampledate),
                     "lake" = rep("Mendota",nrow(mendota_data)),
                     "depth" = 0,
                     "variable" = rep("secview", nrow(mendota_data)),
                     "unit" = rep("M", nrow(mendota_data)),
                     "observation" = mendota_data$secview,
                     "flag" = rep(NA, nrow(mendota_data))) %>%
  drop_na(observation)

Mendota <- rbind(Mendota, data_a)
rm(data_a)

####Magnuson, J., S. Carpenter, and E. Stanley. 2022. North Temperate Lakes LTER
####:Chlorophyll - Madison Lakes Area 1995 - current ver 28. Environmental Data
#### Initiative. https://doi.org/10.6073/pasta/f9c2e1059bcf92f138e140950a3632f2 
#### (Accessed 2023-06-14).

res <- read_data_entity_names(packageId = "knb-lter-ntl.38.28")

raw <- read_data_entity(packageId = "knb-lter-ntl.38.28.r", entityId = res$entityId[1])

data <- read_csv(raw)

data$lake <- "Mendota"

data1 <- data %>%
  filter(str_detect(data$depth_range_m,"-")) %>%
  mutate(depth = as.integer(str_sub(depth_range_m,start=-1,end = -1))/2)


data2 <- data %>%
  filter(!str_detect(data$depth_range_m,"-")) %>%
  mutate(depth = depth_range_m)


data <- rbind(data1,data2)

data_a <- data.frame("datetime" = ymd(data$sampledate),
                     "lake" = data$lake,
                     "depth" = data$depth,
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("MicroGM-PER-L", nrow(data)),
                     "observation" = data$correct_chl_fluor,
                     "flag" = data$flag_spec)%>%
  drop_na(observation)

Mendota <- rbind(Mendota, data_a)
rm(data_a)
rm(data1)
rm(data2)

#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes 
#LTER: Physical Limnology of Primary Study Lakes 1981 - current ver 35. 
#Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/be287e7772951024ec98d73fa94eec08
res <- read_data_entity_names(packageId = "knb-lter-ntl.29.35")

raw <- read_data_entity(packageId = "knb-lter-ntl.29.35.r", entityId = res$entityId[1])

data <- read_csv(raw)

mendota_data <- data %>% filter(lakeid == "ME")

data_a <- data.frame("datetime" = ymd(mendota_data$sampledate),
                     "lake" = rep("Mendota",nrow(mendota_data)),
                     "depth" = mendota_data$depth,
                     "variable" = rep("temp", nrow(mendota_data)),
                     "unit" = rep("DEG_C", nrow(mendota_data)),
                     "observation" = mendota_data$wtemp,
                     "flag" = mendota_data$flagwtemp) %>% drop_na(observation)

#The variable below is form the same data set as above
data_b <- data.frame("datetime" = ymd(mendota_data$sampledate),
              "lake" = rep("Mendota",nrow(mendota_data)),
              "depth" = mendota_data$depth,
              "variable" = rep("do", nrow(mendota_data)),
              "unit" = rep("MilliGM-PER-L", nrow(mendota_data)),
              "observation" = mendota_data$o2,
              "flag" = mendota_data$flago2) %>% drop_na(observation)

Mendota <- rbind(Mendota, data_a)
Mendota <- rbind(Mendota, data_b)
rm(data_a)
rm(data_b)
rm(mendota_data)


