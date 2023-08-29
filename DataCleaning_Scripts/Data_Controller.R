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

## Mendota_A

source("DataCleaning_Scripts/Mendota_A.R")
write_dataset(Mendota, filepath, basename_template ="Mendota_A_{i}.parquet", max_rows_per_file = 1500000)
rm(data, res, raw, Mendota)
gc()

## Mendota_B

source("DataCleaning_Scripts/Mendota_B.R")
write_parquet(x = Mendota, sink = paste0(filepath, "/Mendota_B.parquet"))
rm(data, res, raw, Mendota)
gc()

## Mendota_C

source("DataCleaning_Scripts/Mendota_C.R")
write_parquet(x = Mendota, sink = paste0(filepath, "/Mendota_C.parquet"))
rm(data, res, raw, Mendota)
gc()

# Trout

source("DataCleaning_Scripts/Trout.R")
write_parquet(x = Trout, sink = paste0(filepath, "/Trout.parquet"))
rm(data, res, raw, Trout)
gc()

# Sparkling

source("DataCleaning_Scripts/Sparkling.R")
write_parquet(x = Sparkling, sink = paste0(filepath, "/Sparkling.parquet"))
rm(data, res, raw, Sparkling)
gc()

# Trout Bog
source("DataCleaning_Scripts/Trout_Bog.R")
write_parquet(x = Trout_Bog, sink = paste0(filepath, "/Trout_Bog.parquet"))
rm(data, res, raw, Trout_Bog)
gc()

# FCR

source("DataCleaning_Scripts/FCR.R")
write_parquet(x = FCR, sink = paste0(filepath, "/FCR.parquet"))
rm(FCR)
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
