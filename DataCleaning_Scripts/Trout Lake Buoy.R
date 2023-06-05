df <- data.frame(matrix(ncol = 6, nrow = 0))
colnames(df) <- c("datetime", "lake", "depth", "varbiable", "observation", "flag")

library(lubridate)

# Trout Lake Temp ####
# https://portal.edirepository.org/nis/codeGeneration?packageId=knb-lter-ntl.121.11&statisticalFileType=r
source("Sources/knb-lter-ntl.121.11.r")
TroutLakeTemp1 <- dt1 # Unknown Time
TroutLakeTemp2 <- dt2
TroutLakeTemp3 <- dt3

TroutLakeTemp2$hour <- gsub("\\s", "0", format(TroutLakeTemp2$hour, width=max(nchar(TroutLakeTemp2$hour)), justify = "right"))
TroutLakeTemp3$sample_time <- gsub("\\s", "0", format(TroutLakeTemp3$sample_time, width=max(nchar(TroutLakeTemp3$sample_time)), justify = "right"))
TroutLakeTemp2$datetime <- paste(TroutLakeTemp2$sampledate, TroutLakeTemp2$hour)
TroutLakeTemp2$datetime <- strptime(TroutLakeTemp2$datetime, format='%Y-%m-%d %H%M')
TroutLakeTemp3$datetime <- paste(TroutLakeTemp3$sampledate, TroutLakeTemp3$sample_time)
TroutLakeTemp3$datetime <- strptime(TroutLakeTemp3$datetime, format='%Y-%m-%d %H%M')

TroutLakeTemp4 <- data.frame("datetime" = TroutLakeTemp2$datetime,
                             "lake" = rep("TroutLake", nrow(TroutLakeTemp2)),
                             "depth" = TroutLakeTemp2$depth,
                             "variable" = rep("temp_C", nrow(TroutLakeTemp2)),
                             "observation" = TroutLakeTemp2$avg_wtemp,
                             "flag" = TroutLakeTemp2$flag_wtemp)
df <- rbind(df, TroutLakeTemp4)

TroutLakeTemp4 <- data.frame("datetime" = TroutLakeTemp3$datetime,
                             "lake" = rep("TroutLake", nrow(TroutLakeTemp3)),
                             "depth" = TroutLakeTemp3$depth,
                             "variable" = rep("temp_C", nrow(TroutLakeTemp3)),
                             "observation" = TroutLakeTemp3$wtemp,
                             "flag" = TroutLakeTemp3$flag_wtemp)
df <- rbind(df, TroutLakeTemp4)