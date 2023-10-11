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

## Mendota

source("DataCleaning_Scripts/Mendota.R")
write_dataset(Mendota, paste0(filepath, "/HighFrequency"), basename_template ="Mendota_A_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()

## NTL_HF_Ice

source("DataCleaning_Scripts/NTL_HF_Ice.R")
write_parquet(x = NTL, sink = paste0(filepath, "/HighFrequency", "/Mendota_B.parquet"))
rm(data, res, raw, NTL)
gc()

## NTL Low Frequency

source("DataCleaning_Scripts/NTL.R")
write_parquet(x = NTL, sink = paste0(filepath, "/LowFrequency", "/NTL.parquet"))
rm(data, res, raw, NTL)
gc()

# Trout

source("DataCleaning_Scripts/Trout.R")
write_parquet(x = Trout, sink = paste0(filepath, "/HighFrequency", "/Trout.parquet"))
rm(data, res, raw, Trout)
gc()

# Sparkling

source("DataCleaning_Scripts/Sparkling.R")
write_parquet(x = Sparkling, sink = paste0(filepath, "/HighFrequency", "/Sparkling.parquet"))
rm(data, res, raw, Sparkling)
gc()

# Trout Bog
source("DataCleaning_Scripts/Trout_Bog.R")
write_parquet(x = Trout_Bog, sink = paste0(filepath, "/HighFrequency", "/Trout_Bog.parquet"))
rm(data, res, raw, Trout_Bog)
gc()

# FCR

source("DataCleaning_Scripts/FCR.R")
write_parquet(x = FCR, sink = paste0(filepath, "/FCR.parquet"))
rm(FCR)
gc()

# NEON
source("DataCleaning_Scripts/NEON_Lakes.R")
write_parquet(x = NEON_Lakes, sink = paste0(filepath, "/NEON_Lakes.parquet"))
rm(NEON_Lakes)
gc()

# Confirming Proper Data Collection
end_time <- Sys.time()
time_taken <- difftime(end_time, start_time)

data <- arrow::open_dataset(sources = filepath)
data

print(paste(nrow(data), "observations collected in", round(as.numeric(time_taken),2), units(time_taken), "from the following EDI data products:"))
print(unique(provenance))

if ("beepr" %in% installed.packages()){ # Optional Notification of completion
  beepr::beep(sound = 4)
}
