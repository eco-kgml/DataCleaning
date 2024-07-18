####################################################################################
#### Data Controller ###############################################################
#### Calls the data harmonization scripts and converts tables to Parquet format ####
#### Author: Bennett McAfee ########################################################
####################################################################################

start_time <- Sys.time()

library(EDIutils, quietly = TRUE)
library(tidyverse, quietly = TRUE)
library(data.table, quietly = TRUE)
library(arrow, quietly = TRUE)

filepath <- paste0(getwd(), "/DataCleaning_Scripts/data")

provenance <- c()

################################
#### Mendota High-Frequency ####
################################

## Mendota Chemistry and Meteorology

print(paste("Gathering Mendota high frequency chemistry data at", Sys.time()))
source("DataCleaning_Scripts/Mendota_A.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_A_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

## Mendota Temperature

print(paste("Gathering Mendota high frequency temperature data (1/2) at", Sys.time()))
source("DataCleaning_Scripts/Mendota_B.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_B_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

print(paste("Gathering Mendota high frequency temperature data (2/2) at", Sys.time()))
source("DataCleaning_Scripts/Mendota_C.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_C_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

###############################
#### NTL-LTER General Data ####
###############################

## NTL HF Under-Ice data

print(paste("Gathering NTL-LTER high frequency under-ice data at", Sys.time()))
source("DataCleaning_Scripts/NTL_HF_Ice.R")
write_parquet(x = NTL, sink = paste0(filepath, "/HighFrequency", "/Mendota_B.parquet"))
rm(data, res, raw, NTL)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

## NTL Low Frequency

print(paste("Gathering NTL-LTER low frequency data at", Sys.time()))
source("DataCleaning_Scripts/NTL.R")
write_parquet(x = NTL, sink = paste0(filepath, "/LowFrequency", "/NTL.parquet"))
rm(data, res, raw, NTL)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

###################################
#### Trout Lake High Frequency ####
###################################

print(paste("Gathering Trout Lake high frequency data (1/3) at", Sys.time()))
source("DataCleaning_Scripts/Trout.R")
write_parquet(x = Trout, sink = paste0(filepath, "/HighFrequency", "/Trout.parquet"))
rm(data, res, raw, Trout)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

print(paste("Gathering Trout Lake high frequency data (2/3) at", Sys.time()))
source("DataCleaning_Scripts/Trout_B.R")
write_parquet(x = Trout, sink = paste0(filepath, "/HighFrequency", "/Trout_B.parquet"))
rm(data, res, raw, Trout)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

print(paste("Gathering Trout Lake high frequency data (3/3) at", Sys.time()))
source("DataCleaning_Scripts/Trout_C.R")
write_parquet(x = Trout, sink = paste0(filepath, "/HighFrequency", "/Trout_C.parquet"))
rm(data, res, raw, Trout)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

#######################################
#### Sparkling Lake High Frequency ####
#######################################

print(paste("Gathering Sparkling Lake high frequency data (1/3) at", Sys.time()))
source("DataCleaning_Scripts/Sparkling.R")
write_parquet(x = Sparkling, sink = paste0(filepath, "/HighFrequency", "/Sparkling.parquet"))
rm(data, res, raw, Sparkling)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

print(paste("Gathering Sparkling Lake high frequency data (2/3) at", Sys.time()))
source("DataCleaning_Scripts/Sparkling_B.R")
write_parquet(x = Sparkling, sink = paste0(filepath, "/HighFrequency", "/Sparkling_B.parquet"))
rm(data, res, raw, Sparkling)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

print(paste("Gathering Sparkling Lake high frequency data (3/3) at", Sys.time()))
source("DataCleaning_Scripts/Sparkling_C.R")
write_parquet(x = Sparkling, sink = paste0(filepath, "/HighFrequency", "/Sparkling_C.parquet"))
rm(data, res, raw, Sparkling)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

##################################
#### Trout Bog High Frequency ####
##################################

print(paste("Gathering Trout Bog high frequency data at", Sys.time()))
source("DataCleaning_Scripts/Trout_Bog.R")
write_parquet(x = Trout_Bog, sink = paste0(filepath, "/HighFrequency", "/Trout_Bog.parquet"))
rm(data, res, raw, Trout_Bog)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

####################################
#### Crystal Bog High Frequency ####
####################################

print(paste("Gathering Crystal Bog high frequency data at", Sys.time()))
source("DataCleaning_Scripts/Crystal_Bog.R")
write_parquet(x = Crystal_Bog, sink = paste0(filepath, "/HighFrequency", "/Crystal_Bog.parquet"))
rm(data, res, raw, Crystal_Bog)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

###############################################
#### Western Virginia Water Authority Data ####
###############################################

print(paste("Gathering WVWA data at", Sys.time()))
source("DataCleaning_Scripts/WVWA.R")
write_parquet(x = WVWA_HF, sink = paste0(filepath, "/HighFrequency", "/WVWA_HF.parquet"))
write_parquet(x = WVWA_LF, sink = paste0(filepath, "/LowFrequency", "/WVWA_LF.parquet"))
rm(WVWA_LF, WVWA_HF)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

###############################
#### Niwot Ridge LTER Data ####
###############################

## NWT Low Frequency

print(paste("Gathering NWT-LTER Low frequency data at", Sys.time()))
source("DataCleaning_Scripts/NWT.R")
write_parquet(x = NWT, sink = paste0(filepath, "/LowFrequency", "/NWT_LF.parquet"))
rm(data, res, raw, NWT)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

## NWT High Frequency

print(paste("Gathering NWT-LTER high frequency data at", Sys.time()))
source("DataCleaning_Scripts/NWT_HF.R")
write_parquet(x = NWT, sink = paste0(filepath, "/HighFrequency", "/NWT_HF.parquet"))
rm(data, res, raw, NWT)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

###################
#### NEON Data ####
###################

## NEON Low Frequency

print(paste("Gathering NEON low frequency data at", Sys.time()))
source("DataCleaning_Scripts/NEON.R")
write_parquet(x = NEON_Lakes, sink = paste0(filepath, "/LowFrequency", "/NEON_LF.parquet"))
rm(NEON_Lakes)
gc()

## NEON High Frequency

print(paste("Gathering NEON high frequency data at", Sys.time()))
source("DataCleaning_Scripts/NEON_HF.R")
write_dataset(NEON_Lakes, paste0(filepath, "/HighFrequency"), basename_template ="NEON_A_{i}.parquet", max_rows_per_file = 1500000)
rm(NEON_Lakes)
gc()

## NEON very High Frequency

print(paste("Gathering NEON very high frequency data at", Sys.time()))
source("DataCleaning_Scripts/NEON_HF_B.R")
write_dataset(NEON_Lakes, paste0(filepath, "/HighFrequency"), basename_template ="NEON_B_{i}.parquet", max_rows_per_file = 1500000)
rm(NEON_Lakes)
gc()

source("DataCleaning_Scripts/NEON_HF_C.R")
write_dataset(NEON_Lakes, paste0(filepath, "/HighFrequency"), basename_template ="NEON_C_{i}.parquet", max_rows_per_file = 1500000)
rm(NEON_Lakes)
gc()

#################
#### Wrap-Up ####
#################

## Provenace tracking

provenance <- unique(provenance)

write.csv(provenance, file = paste0(filepath, "/provenance.csv"), row.names = FALSE)

## Confirming Proper Data Collection
end_time <- Sys.time()
time_taken <- difftime(end_time, start_time)

data_hf <- arrow::open_dataset(sources = paste0(filepath, "/HighFrequency"))
data_lf <- arrow::open_dataset(sources = paste0(filepath, "/LowFrequency"))

print(paste((nrow(data_hf) + nrow(data_lf)), "observations collected in", round(as.numeric(time_taken),2), units(time_taken), "from the following data sources:"))
print(unique(provenance))

if ("beepr" %in% installed.packages()){ # Optional Notification of completion
  beepr::beep(sound = 4)
}
