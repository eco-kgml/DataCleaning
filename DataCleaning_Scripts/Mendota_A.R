#Read in Mendota High Frequency data from EDI
#Author: Bennett McAfee

library(EDIutils)
library(tidyverse)

# Creating data table
Mendota <- data.frame(matrix(ncol = 7, nrow = 0))
colnames(Mendota) <- c("datetime", "lake", "depth", "varbiable", "unit", "observation", "flag")

#### Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2023. North Temperate Lakes LTER: High Frequency Data: Meteorological, 
#### Dissolved Oxygen, Chlorophyll, Phycocyanin - Lake Mendota Buoy 2006 - current ver 35. Environmental Data Initiative. 
#### https://doi.org/10.6073/pasta/9dd19de5dad366b697b73d28674186fc (Accessed 2023-06-09).

scope = "knb-lter-ntl"
identifier = 129
revision = list_data_package_revisions(scope = scope,identifier = identifier, filter = "newest")
packageId = paste0(scope, ".", identifier, ".", revision)

res <- read_data_entity_names(packageId = packageId)
raw <- read_data_entity(packageId = packageId, entityId = res$entityId[3])
data <- readr::read_csv(file = raw)

if (exists("provenance")){
  provenance <- append(provenance, packageId)
}

data <- subset(data, select = c("sampledate", "sampletime", "chlor_rfu", "flag_chlor_rfu", "phyco_rfu", "flag_phyco_rfu", "do_raw", "flag_do_raw", "do_wtemp", "flag_do_wtemp", "fdom", "flag_fdom"))
data$datetime <- paste(data$sampledate, data$sampletime)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data_a <- data.frame("datetime" = data$datetime,
                     "lake" = rep("ME", nrow(data)),
                     "depth" = rep(0, nrow(data)),
                     "variable" = rep("chla", nrow(data)),
                     "unit" = rep("RFU", nrow(data)),
                     "observation" = data$chlor_rfu,
                     "flag" = data$flag_chlor_rfu)
Mendota <- rbind(Mendota, data_a)
rm(data_a)
data_b <- data.frame("datetime" = data$datetime,
                     "lake" = rep("ME", nrow(data)),
                     "depth" = rep(0, nrow(data)),
                     "variable" = rep("phyco", nrow(data)),
                     "unit" = rep("RFU", nrow(data)),
                     "observation" = data$phyco_rfu,
                     "flag" = data$phyco_rfu)
Mendota <- rbind(Mendota, data_b)
rm(data_b)
data_c <- data.frame("datetime" = data$datetime,
                     "lake" = rep("ME", nrow(data)),
                     "depth" = rep(0, nrow(data)),
                     "variable" = rep("do", nrow(data)),
                     "unit" = rep("MilliGM-PER-L", nrow(data)),
                     "observation" = data$do_raw,
                     "flag" = data$flag_do_raw)
Mendota <- rbind(Mendota, data_c)
rm(data_c)
data_d <- data.frame("datetime" = data$datetime,
                     "lake" = rep("ME", nrow(data)),
                     "depth" = rep(0, nrow(data)),
                     "variable" = rep("temp", nrow(data)),
                     "unit" = rep("DEG_C", nrow(data)),
                     "observation" = data$do_wtemp,
                     "flag" = data$flag_do_wtemp)
Mendota <- rbind(Mendota, data_d)
rm(data_d)
data_e <- data.frame("datetime" = data$datetime,
                     "lake" = rep("ME", nrow(data)),
                     "depth" = rep(0, nrow(data)),
                     "variable" = rep("fdom", nrow(data)),
                     "unit" = rep("RFU", nrow(data)),
                     "observation" = data$fdom,
                     "flag" = data$flag_fdom)
Mendota <- rbind(Mendota, data_e)
rm(data_e)

Mendota <- Mendota[!is.na(Mendota$observation),]
