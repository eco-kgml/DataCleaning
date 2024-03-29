#Read in Mendota auxiliary data from EDI
#Author: Adi Tewari
library (tidyr)
library(EDIutils)
library(tidyverse)
library(lubridate)
#Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes 
#LTER: Chemical Limnology of Primary Study Lakes: Nutrients, pH and Carbon 1981
#- current ver 59. Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/c923b8e044310f3f5612dab09c2cc6c2

res <- read_data_entity_names(packageId = "knb-lter-ntl.1.60")
raw <- read_data_entity(packageId = "knb-lter-ntl.1.60", entityId = res$entityId[1])
data <- readr::read_csv(file = raw) 

mendota_data <- data %>%
  filter( lakeid == "ME") %>%
  filter(!is.na(totpuf_sloh)) %>%
  select(daynum,sampledate,depth,totpuf_sloh,flagtotpuf_sloh) %>%
  group_by(daynum) %>% 
  filter(max(depth)>=20)

mendota_data <- data.frame("datetime" = ymd(mendota_data$sampledate),
                     "lake" = rep("Mendota",nrow(mendota_data)),
                     "depth" = mendota_data$depth,
                     "variable" = rep("tp", nrow(mendota_data)),
                     "unit" = rep("MilliGM-PER-L", nrow(mendota_data)),
                     "observation" = mendota_data$totpuf_sloh,
                     "flag" = mendota_data$flagtotpuf_sloh) %>% drop_na(observation)


interpolate <- function(sample){
  check <- approx(sample$depth,sample$observation,method="linear",n=max(sample$depth)+1)
  
  missing_depths <- c((max(check$x)+1):25)
  
  check$x <- c(check$x,missing_depths) 
  
  check$y[length(check$y):26] <- check$y[length(check$y)] 
  
  new_tibble <- data.frame("datetime" = rep(unique(sample$datetime)),
                           "lake" = rep("Mendota"),
                           "depth" = check$x,
                           "variable" = rep("tp"),
                           "unit" = rep("MilliGM-PER-L"),
                           "observation" = check$y,
                           "flag" = NA)
  return (new_tibble)
}

new_mendota_data <- data.frame("datetime" = NULL,"lake" = NULL,"depth" = NULL,"variable" = NULL,"unit" = NULL,
                               "observation" = NULL, "flag" = NULL)

for (unique_date in unique(mendota_data$datetime)) {
  current_df <- mendota_data %>%
    filter(datetime == unique_date) %>%
    interpolate()

  new_mendota_data <- rbind(new_mendota_data,current_df)
}


hypsometry <- read.csv("/Users/aditewari/Desktop/DataCleaning/DataCleaning_Scripts/For Adi/LakeEnsemblR_bathymetry_standard.csv")


new_mendota_data <- new_mendota_data %>% 
  left_join(hypsometry,by=c("depth")) %>%
  mutate("volume_in_l" = Area_meterSquared*1000) %>%
  mutate("mass_in_mg" = observation*volume_in_l)

thermocline <- read.csv("/Users/aditewari/Desktop/DataCleaning/DataCleaning_Scripts/For Adi/ThermoClineDepth.csv")

thermocline <- thermocline %>%
  mutate(SimDates = ymd(SimDates)) %>%
  rename("datetime" = "SimDates") %>%
  filter(!is.na(ThermoclineDepth))

new_mendota_data <- new_mendota_data %>% 
  left_join(thermocline,by=c("datetime"))


new_mendota_data_exists <- new_mendota_data %>%
  filter(ThermoclineDepth>0) %>%
  mutate("type" = ifelse(depth<ThermoclineDepth,"epi","hypo")) %>% 
  group_by(datetime,lake,variable,unit,ThermoclineDepth,type) %>%
  summarise(concentration_mg_per_L = sum(mass_in_mg)/sum(volume_in_l))

new_mendota_data_all <- new_mendota_data %>%
  drop_na(Area_meterSquared) %>% 
  group_by(datetime) %>% 
  filter(n()>=25) %>%
  mutate("type" ="all") %>%
  group_by(datetime,lake,variable,unit,ThermoclineDepth,type) %>%
  summarise(concentration_mg_per_L = sum(mass_in_mg)/sum(volume_in_l))

revision_v1 <- rbind(new_mendota_data_exists,new_mendota_data_all) %>% 
  arrange(datetime,type)

write.csv(revision_v1,"/Users/aditewari/Desktop/DataCleaning/DataCleaning_Scripts/revision_v1.csv",row.names = FALSE)



