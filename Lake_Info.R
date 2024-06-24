#Read in and summarize Bathymetry information
#Author: Bennett McAfee

library(tidyverse)
library(EDIutils)
library(neonUtilities)

output_df <- data.frame(lake_id = character(),
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
####################
#### NEON Lakes #### 
####################

BARC_info <- data.frame(lake_id = "BARC",
                       lake_name = "Barco Lake",
                       institution = "NEON",
                       latitude = 29.675982, # Thomas et al. 2023 (https://doi.org/10.1002/fee.2623)
                       longitude = -82.008414, # Thomas et al. 2023
                       elevation_m = 26.98,# USGS National Map (https://apps.nationalmap.gov/epqs/), retrieved 2024-06-13
                       area_ha = 0.12 * 100, # Thomas et al. 2023
                       mean_depth_m = 256888 / (0.12 * 1e6), # Thomas et al. 2023
                       max_depth_m = 6, # Thomas et al. 2023
                       residence_time_yr = 3.3, # Thomas et al. 2023
                       known_manipulations = NA)

SUGG_info <- data.frame(lake_id = "SUGG",
                        lake_name = "Suggs Lake",
                        institution = "NEON",
                        latitude = 29.68778, # Thomas et al. 2023
                        longitude = -82.017745, # Thomas et al. 2023
                        elevation_m = 28.68, # USGS National Map
                        area_ha = 0.31 * 100,  # Thomas et al. 2023
                        mean_depth_m = 415356 / (0.31 * 1e6), # Thomas et al. 2023
                        max_depth_m = 3, # Thomas et al. 2023
                        residence_time_yr = 1.6, # Thomas et al. 2023
                        known_manipulations = NA)

CRAM_info <- data.frame(lake_id = "CRAM",
                        lake_name = "Crampton Lake",
                        institution = "NEON",
                        latitude = 46.209675, # Thomas et al. 2023
                        longitude = -89.473688, # Thomas et al. 2023
                        elevation_m = 510.55, # USGS National Map
                        area_ha = 0.26 * 100, # Thomas et al. 2023
                        mean_depth_m = 889734 / (0.26 * 1e6), # Thomas et al. 2023
                        max_depth_m = 19, # Thomas et al. 2023
                        residence_time_yr = 4.9, # Thomas et al. 2023
                        known_manipulations = NA)

LIRO_info <- data.frame(lake_id = "LIRO",
                        lake_name = "Little Rock Lake",
                        institution = "NEON",
                        latitude = 45.998269, # Thomas et al. 2023
                        longitude = -89.704767, # Thomas et al. 2023
                        elevation_m = 495.18, # USGS National Map
                        area_ha = 0.19 * 100, # Thomas et al. 2023
                        mean_depth_m = 466757 / (0.19 * 1e6), # Thomas et al. 2023
                        max_depth_m = 10, # Thomas et al. 2023
                        residence_time_yr = 3.4, # Thomas et al. 2023
                        known_manipulations = NA)

PRLA_info <- data.frame(lake_id = "PRLA",
                        lake_name = "Prairie Lake",
                        institution = "NEON",
                        latitude = 47.15909, # Thomas et al. 2023
                        longitude = -99.11388, # Thomas et al. 2023
                        elevation_m = 562.77, # USGS National Map
                        area_ha = 0.23 * 100, # Thomas et al. 2023
                        mean_depth_m = 389429 / (0.23 * 1e6), # Thomas et al. 2023
                        max_depth_m = 4, # Thomas et al. 2023
                        residence_time_yr = 3.8, # Thomas et al. 2023
                        known_manipulations = NA)

PRPO_info <- data.frame(lake_id = "PRPO",
                        lake_name = "Prairie Pothole",
                        institution = "NEON",
                        latitude = 47.129839, # Thomas et al. 2023
                        longitude = -99.253147, # Thomas et al. 2023
                        elevation_m = 586.87, # USGS National Map
                        area_ha = 0.11 * 100, # Thomas et al. 2023
                        mean_depth_m = 158520 / (0.11 * 1e6), # Thomas et al. 2023
                        max_depth_m = 4, # Thomas et al. 2023
                        residence_time_yr = 3.2, # Thomas et al. 2023
                        known_manipulations = NA)

TOOK_info <- data.frame(lake_id = "TOOK",
                        lake_name = "Toolik Lake",
                        institution = "NEON",
                        latitude = 68.630692, # Aho et al. 2023 (https://doi.org/10.1029/2023GL104987)
                        longitude = -149.61064, # Aho et al. 2023
                        elevation_m = 715.3, # USGS National Map
                        area_ha = 1.48 * 100, # Aho et al. 2023
                        mean_depth_m = 8.5, # Aho et al. 2023
                        max_depth_m = 25, # Cory et al. 2007 (https://doi.org/10.1029/2006JG000343)
                        residence_time_yr = 1, # Cory et al. 2007
                        known_manipulations = NA)


######################
#### Green Lake 4 ####
######################

GL4_info <- data.frame(lake_id = "GL4",
                       lake_name = "Green Lake 4",
                       institution = "NWT-LTER",
                       latitude = 40.05545, # Geographic Coverage of knb-lter-nwt.188.5 in EDI
                       longitude = -105.62091, # Geographic Coverage of knb-lter-nwt.188.5 in EDI
                       elevation_m = 3560.76, # USGS National Map 
                       area_ha = 5.3, # Baron and Caine 2001 (https://doi.org/10.1046/j.1365-2427.2000.00517.x)
                       mean_depth_m = 4.1, # Baron and Caine 2001
                       max_depth_m = 13.0, # Baron and Caine 2001
                       residence_time_yr = 21.4 / 365, # Flanagan et al. 2008 (https://doi.org/10.1657/1938.4246-41.2.191)
                       known_manipulations = NA)

##############
#### WVWA ####
##############

# Bathymetry: Carey et al. 2022 (https://doi.org/10.6073/pasta/352735344150f7e77d2bc18b69a22412)

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
                       longitude = -79.8375, #converted from Upadhyay et al. 2013
                       elevation_m = 507.61, # USGS National Map
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
                       longitude = -79.816, #Doubek et al. 2018
                       elevation_m = 584.3, # USGS National Map
                       area_ha = BVR_sa_ha,
                       mean_depth_m = BVR_mean_depth,
                       max_depth_m = BVR_max_depth,
                       residence_time_yr = 0.9, #converted from Doubek et al. 2018
                       known_manipulations = NA)

###################
#### NTL Lakes ####
###################

# Many attributes derived from the following data package:
#Lottig, N.R. and H.A. Dugan. 2024. North Temperate Lakes-LTER 
#Core Research Lakes Information ver 1. Environmental Data Initiative. 
#https://doi.org/10.6073/pasta/b9080c962f552029ee2b43aec1410328 (Accessed 2024-06-24).

packageId <- "knb-lter-ntl.434.1"
res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[1])
data <- readr::read_csv(file = raw, show_col_types = FALSE)

lakename <- "Allequash Lake"
AL_info <- data.frame(lake_id = "AL",
                       lake_name = lakename,
                       institution = "NTL-LTER",
                       latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                       longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                       elevation_m = 494.03, # USGS National Map
                       area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                       mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                       max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                       residence_time_yr = 0.5, # Webster et al. 1996 (https://doi.org/10.4319/lo.1996.41.5.0977)
                       known_manipulations = NA)

lakename <- "Big Muskellunge Lake"
BM_info <- data.frame(lake_id = "BM",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 499.32, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 8, # Webster et al. 1996
                      known_manipulations = NA)

lakename <- "Crystal Lake"
CR_info <- data.frame(lake_id = "CR",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 500.47, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 12.7, # Webster et al. 1996
                      known_manipulations = "Thermal manipulation [2012-2013], Invasive smelt removal [2002-2009], Cisco introduction [2020-present]")
# Thermal manipulation: Lawson et al. 2015 (https://doi.org/10.1139/cjfas-2014-0346)
# Smelt removal: Gaeta et al. 2014 (https://doi.org/10.1007/s10750-014-1916-3)
# Cisco introduction: Mrnak et al. 2022 (https://doi.org/10.1080/23308249.2022.2078951)

lakename <- "Sparkling Lake"
SP_info <- data.frame(lake_id = "SP",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 494.16, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 10.4, # Webster et al. 1996
                      known_manipulations = "Invasive crayfish removal [2001-2008], Invasive smelt removal [2002-2009], Cisco introduction [2020-present]") 
# Crayfish removal: Martin Perales et al. 2021 (https://doi.org/10.1111/fwb.13818)
# Smelt removal: Gaeta et al. 2014
# Cisco introduction: Mrnak et al. 2022

lakename <- "Trout Lake"
TR_info <- data.frame(lake_id = "TR",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 491.71, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 4.5, # Webster et al. 1996
                      known_manipulations = NA)

lakename <- "Fish Lake"
FI_info <- data.frame(lake_id = "FI",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)],
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 262.05, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = NA, # closed basin system, residence time is unknown
                      known_manipulations = NA)

lakename <- "Lake Mendota"
ME_info <- data.frame(lake_id = "ME",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)],
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 258.95, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 4.3, # Lathrop and Carpenter 2014 (https://doi.org/10.5268/IW-4.1.680)
                      known_manipulations = "Piscivore stocking [1987-1999]") # Lathrop et al. 2002 (https://doi.org/10.1046/j.1365-2427.2002.01011.x)

lakename = "Lake Monona"
MO_info <- data.frame(lake_id = "MO",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)],
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 257.42, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 0.7,  # Lathrop and Carpenter 2014
                      known_manipulations = NA)

lakename = "Lake Wingra"
WI_info <- data.frame(lake_id = "WI",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 258.39, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 0.44, # Rast and Lee 1977 p.344 (https://books.google.com/books?id=zELaRGW0IrcC&q=Lake+Wingra&source=gbs_word_cloud_r&cad=3#v=snippet&q=Lake%20Wingra&f=false)
                      known_manipulations = "Carp removal [2007-2009]") #Lin and Wu 2013 (https://doi.org/10.1051/limn/2013049)

lakename <- "Crystal Bog"
CB_info <- data.frame(lake_id = "CB",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 501.49, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 2.6, # Watras and Hanson 2023 (https://doi.org/10.1002/eco.2591)
                      known_manipulations = NA)

lakename <- "Trout Bog"
TB_info <- data.frame(lake_id = "TB",
                      lake_name = lakename,
                      institution = "NTL-LTER",
                      latitude = data$waterbody_lat_decdeg[which(data$waterbody_name == lakename)], 
                      longitude = data$waterbody_lon_decdeg[which(data$waterbody_name == lakename)],
                      elevation_m = 493.5, # USGS National Map
                      area_ha = data$waterbody_area_ha[which(data$waterbody_name == lakename)],
                      mean_depth_m = data$avg_depth_m[which(data$waterbody_name == lakename)],
                      max_depth_m = data$max_depth_m[which(data$waterbody_name == lakename)],
                      residence_time_yr = 6.4, # Watras and Hanson 2023 
                      known_manipulations = NA)

#################################
#### Pulling it all together ####
#################################

lake_objects <- ls(pattern = "info")

for (obj in lake_objects){
  output_df <- rbind(output_df, get(obj))
}

write.csv(output_df, file = "Lake_Info.csv", row.names = FALSE)

