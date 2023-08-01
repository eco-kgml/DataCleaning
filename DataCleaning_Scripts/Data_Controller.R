library(EDIutils)
library(tidyverse)
library(data.table)
library(arrow)

filepath <- paste0(getwd(), "/DataCleaning_Scripts/data")

# Mendota

## Mendota_A

source("DataCleaning_Scripts/Mendota_A.R")
for (i in unique(Mendota$variable)){
  subset_Mendota <- Mendota["variable" == i,]
  write_parquet(x = Mendota, sink = paste0(filepath, "/Mendota_A_", i, ".parquet"))
}
rm(data, res, raw, Mendota, subset_Mendota)
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

