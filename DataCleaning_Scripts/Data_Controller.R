#Control the collection of data from external sources
#Author: Bennett McAfee

start_time <- Sys.time()

library(EDIutils, quietly = TRUE)
library(tidyverse, quietly = TRUE)
library(data.table, quietly = TRUE)
library(arrow, quietly = TRUE)

filepath <- paste0(getwd(), "/DataCleaning_Scripts/data")

provenance <- c()

# Mendota

## Mendota Chemistry and Meteorology

print(paste("Gathering Mendota high frequency chemistry data at", Sys.time()))
source("DataCleaning_Scripts/Mendota_A.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_A_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

## Mendota Temperature

print(paste("Gathering Mendota high frequency temperature data at", Sys.time()))
source("DataCleaning_Scripts/Mendota_B.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_B_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

print(paste("Gathering Mendota high frequency temperature data at", Sys.time()))
source("DataCleaning_Scripts/Mendota_C.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_C_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

## NTL_HF_Ice

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

# Trout

print(paste("Gathering Trout Lake high frequency data at", Sys.time()))
source("DataCleaning_Scripts/Trout.R")
write_parquet(x = Trout, sink = paste0(filepath, "/HighFrequency", "/Trout.parquet"))
rm(data, res, raw, Trout)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

# Sparkling

print(paste("Gathering Sparkling Lake high frequency data at", Sys.time()))
source("DataCleaning_Scripts/Sparkling.R")
write_parquet(x = Sparkling, sink = paste0(filepath, "/HighFrequency", "/Sparkling.parquet"))
rm(data, res, raw, Sparkling)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

# Trout Bog

print(paste("Gathering Trout Bog high frequency data at", Sys.time()))
source("DataCleaning_Scripts/Trout_Bog.R")
write_parquet(x = Trout_Bog, sink = paste0(filepath, "/HighFrequency", "/Trout_Bog.parquet"))
rm(data, res, raw, Trout_Bog)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

# FCR

print(paste("Gathering FCR data at", Sys.time()))
source("DataCleaning_Scripts/FCR.R")
write_parquet(x = FCR, sink = paste0(filepath, "/FCR.parquet"))
rm(FCR)
gc()
file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

# NEON

# print(paste("Gathering NEON data at", Sys.time()))
# source("DataCleaning_Scripts/NEON_Lakes.R")
# write_parquet(x = NEON_Lakes, sink = paste0(filepath, "/NEON_Lakes.parquet"))
# rm(NEON_Lakes)
# gc()
# file.remove(list.files(tempdir(), full.names = TRUE, pattern = "^vroom"))

# Provenace
provenance <- unique(provenance)

write.csv(provenance, file = paste0(filepath, "/provenance.csv"), row.names = FALSE)

# Confirming Proper Data Collection
end_time <- Sys.time()
time_taken <- difftime(end_time, start_time)

data_hf <- arrow::open_dataset(sources = paste0(filepath, "/HighFrequency"))
data_lf <- arrow::open_dataset(sources = paste0(filepath, "/LowFrequency"))

print(paste((nrow(data_hf) + nrow(data_lf)), "observations collected in", round(as.numeric(time_taken),2), units(time_taken), "from the following data sources:"))
print(unique(provenance))

if ("beepr" %in% installed.packages()){ # Optional Notification of completion
  beepr::beep(sound = 4)
}
