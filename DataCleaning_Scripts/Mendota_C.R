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

scope = "knb-lter-ntl"
identifier = 38
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

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

scope = "knb-lter-ntl"
identifier = 29
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw)

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

data_a <- data.frame("datetime" = NULL,"lake" = NULL,"depth" = NULL,"variable" = NULL,"unit" = NULL,
                               "observation" = NULL, "flag" = NULL)

for (unique_date in unique(mendota_data$datetime)) {
  current_df <- mendota_data %>%
    filter(datetime == unique_date) %>%
    interpolate()
  
  data_a <- rbind(data_a,current_df)
}

Mendota <- rbind(Mendota, data_a)
rm(data_a)

