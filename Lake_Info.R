#Read in and summarize Bathymetry information
#Author: Bennett McAfee

library(tidyverse)
library(EDIutils)

lake_info <- data.frame(lake_id = character(),
                        lake_name = character(),
                        institution = character(),
                        latitude = numeric(),
                        longitude = numeric(),
                        elevation_m = numeric(),
                        area_ha = numeric(),
                        mean_depth_m = numeric(),
                        max_depth_m = numeric(),
                        residence_time_yr = numeric(),
                        known_manipulations = character())

# NEON Lakes Bathymetry: https://data.neonscience.org/data-products/DP4.00132.001

# Green Lake 4 Bathymetry: https://doi.org/10.1046/j.1365-2427.2000.00517.x

gl4_elev <- 3550
gl4_area <- 5.3
gl4_meandepth <- 4.1
gl4_max <- 13.0

###################
#### FCR & BVR ####
###################

# Bathymetry: https://doi.org/10.6073/pasta/352735344150f7e77d2bc18b69a22412

packageId <- "edi.1254.1"
res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

lake <- "FCR"
data_filtered <- data %>% filter(Reservoir == lake)
FCR_sa_ha <- data_filtered$SA_m2[which(data_filtered$Depth_m == 0.0)] / 10000 # convert from meters squared to hectares
FCR_max_depth <- max(data_filtered$Depth_m)
FCR_mean_depth <- (data_filtered$Volume_below_L[which(data_filtered$Depth_m == 0.0)]/1000) / (data_filtered$SA_m2[which(data_filtered$Depth_m == 0.0)]) #(volume in liters converted to cubic meter) / (surface area in meters squared)

FCR_info <- data.frame(lake_id = "FCR",
                       lake_name = "Falling Creek Reservoir",
                       institution = "WVWA",
                       latitude = 37.30333, #converted from Upadhyay et al. 2013 (https://doi.org/10.1016/j.ecoleng.2013.09.032)
                       longitude = 79.8375, #converted from Upadhyay et al. 2013
                       elevation_m = 509, #Upadhyay et al. 2013
                       area_ha = FCR_sa_ha,
                       mean_depth_m = FCR_mean_depth,
                       max_depth_m = FCR_max_depth,
                       residence_time_yr = 0.68, #Gerling et al. 2014 (https://doi.org/10.1016/j.watres.2014.09.002)
                       known_manipulations = NA)

lake <- "BVR"
data_filtered <- data %>% filter(Reservoir == lake)
BVR_sa_ha <- data_filtered$SA_m2[which(data_filtered$Depth_m == 0.0)] / 10000 # convert from meters squared to hectares
BVR_max_depth <- max(data_filtered$Depth_m)
BVR_mean_depth <- (data_filtered$Volume_below_L[which(data_filtered$Depth_m == 0.0)]/1000) / (data_filtered$SA_m2[which(data_filtered$Depth_m == 0.0)]) #(volume in liters converted to cubic meter) / (surface area in meters squared)

BVR_info <- data.frame(lake_id = "BVR",
                       lake_name = "Beaverdam Reservoir",
                       institution = "WVWA",
                       latitude = 37.313, #Doubek et al. 2018 (https://doi.org/10.1002/ecs2.2332)
                       longitude = 79.816, #Doubek et al. 2018
                       elevation_m = NA, # Citation needed
                       area_ha = BVR_sa_ha,
                       mean_depth_m = BVR_mean_depth,
                       max_depth_m = BVR_max_depth,
                       residence_time_yr = 0.9, #converted from Doubek et al. 2018
                       known_manipulations = NA)

###################
#### NTL Lakes ####
###################

AL_info <- data.frame(lake_id = "AL",
                       lake_name = "Allequash Lake",
                       institution = "NTL-LTER",
                       latitude = NA, 
                       longitude = NA,
                       elevation_m = NA, 
                       area_ha = 164.2, # Ladwig et al. 2022 (https://doi.org/10.1002/lno.12098)
                       mean_depth_m = 2.9, # Ladwig et al. 2022
                       max_depth_m = 8, # Ladwig et al. 2022
                       residence_time_yr = 0.5, # Webster et al. 1996 (https://doi.org/10.4319/lo.1996.41.5.0977)
                       known_manipulations = NA)

BM_info <- data.frame(lake_id = "BM",
                      lake_name = "Big Muskellunge Lake",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 363.4, # Ladwig et al. 2022
                      mean_depth_m = 7.5, # Ladwig et al. 2022
                      max_depth_m = 21.3, # Ladwig et al. 2022
                      residence_time_yr = 8, # Webster et al. 1996
                      known_manipulations = NA)

CR_info <- data.frame(lake_id = "CR",
                      lake_name = "Crystal Lake",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 37.5, # Ladwig et al. 2022
                      mean_depth_m = 10.4, # Ladwig et al. 2022
                      max_depth_m = 20.4, # Ladwig et al. 2022
                      residence_time_yr = 12.7, # Webster et al. 1996
                      known_manipulations = NA)

SP_info <- data.frame(lake_id = "SP",
                      lake_name = "Sparkling Lake",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 63.7, # Ladwig et al. 2022
                      mean_depth_m = 10.9, # Ladwig et al. 2022
                      max_depth_m = 20, # Ladwig et al. 2022
                      residence_time_yr = 10.4, # Webster et al. 1996
                      known_manipulations = NA)

TR_info <- data.frame(lake_id = "TR",
                      lake_name = "Trout Lake",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 1565.1, # Ladwig et al. 2022
                      mean_depth_m = 14.6, # Ladwig et al. 2022
                      max_depth_m = 35.7, # Ladwig et al. 2022
                      residence_time_yr = 4.5, # Webster et al. 1996
                      known_manipulations = NA)

FI_info <- data.frame(lake_id = "FI",
                      lake_name = "Fish Lake",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 80.4, # Ladwig et al. 2022
                      mean_depth_m = 6.6, # Ladwig et al. 2022
                      max_depth_m = 18.9, # Ladwig et al. 2022
                      residence_time_yr = NA, # closed basin system, residence time is unknown
                      known_manipulations = NA)

ME_info <- data.frame(lake_id = "ME",
                      lake_name = "Lake Mendota",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 3961.2, # Ladwig et al. 2022
                      mean_depth_m = 12.8, # Ladwig et al. 2022
                      max_depth_m = 25.3, # Ladwig et al. 2022
                      residence_time_yr = 4.3, # Lathrop and Carpenter 2014 (https://doi.org/10.5268/IW-4.1.680)
                      known_manipulations = NA)

MO_info <- data.frame(lake_id = "MO",
                      lake_name = "Lake Monona",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = 1359.8, # Ladwig et al. 2022
                      mean_depth_m = 8.2, # Ladwig et al. 2022
                      max_depth_m = 22.5, # Ladwig et al. 2022
                      residence_time_yr = 0.7,  # Lathrop and Carpenter 2014
                      known_manipulations = NA)

WI_info <- data.frame(lake_id = "WI",
                      lake_name = "Lake Wingra",
                      institution = "NTL-LTER",
                      latitude = NA, 
                      longitude = NA,
                      elevation_m = NA, 
                      area_ha = NA,
                      mean_depth_m = NA,
                      max_depth_m = NA,
                      residence_time_yr = 4.4, # Rast and Lee 1977 (https://books.google.com/books?hl=en&lr=&id=W4fwAAAAMAAJ&oi=fnd&pg=PA337&dq=%22lake+wingra%22+%22residence+time%22&ots=dMYwrs2Mb5&sig=7p4o2g-D15sQPhlA2dlAR-7Qr8M#v=onepage&q=%22lake%20wingra%22%20%22residence%20time%22&f=false)
                      known_manipulations = NA)

CB_info <- data.frame(lake_id = "CB",
                      lake_name = "Crystal Bog",
                      institution = "NTL-LTER",
                      latitude = 46.008, # Watras and Hanson 2023 (https://doi.org/10.1002/eco.2591)
                      longitude = -89.606, # Watras and Hanson 2023
                      elevation_m = NA, 
                      area_ha = 5357 / 10000, # Watras and Hanson 2023 converted to hectares
                      mean_depth_m = 9660 / 5357, # Watras and Hanson 2023 calculated
                      max_depth_m = 2.5, # Watras and Hanson 2023
                      residence_time_yr = 2.6, # Watras and Hanson 2023
                      known_manipulations = NA)

TB_info <- data.frame(lake_id = "TB",
                      lake_name = "Trout Bog",
                      institution = "NTL-LTER",
                      latitude = 46.041, # Watras and Hanson 2023
                      longitude = -89.686, # Watras and Hanson 2023
                      elevation_m = NA, 
                      area_ha = 11000 / 10000, # Watras and Hanson 2023 converted to hectares
                      mean_depth_m = 61693 / 11000, # Watras and Hanson 2023 calculated
                      max_depth_m = 7.9, # Watras and Hanson 2023
                      residence_time_yr = 6.4, # Watras and Hanson 2023 
                      known_manipulations = NA)
