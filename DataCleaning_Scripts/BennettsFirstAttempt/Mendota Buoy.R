df <- data.frame(matrix(ncol = 6, nrow = 0))
colnames(df) <- c("datetime", "lake", "depth", "varbiable", "observation", "flag")

library(lubridate)

# Lake Mendota Temp ####
# https://portal.edirepository.org/nis/codeGeneration?packageId=knb-lter-ntl.390.3&statisticalFileType=r
source("Sources/knb-lter-ntl.390.3.r")
MendotaTemp1 <- dt1
MendotaTemp1 <- MendotaTemp1[MendotaTemp1$lake == "Mendota",]
MendotaTemp2 <- data.frame("datetime" = strptime(MendotaTemp1$Sampledate, format = '%Y-%m-%d %H:%M:%S'),
                           "lake" = MendotaTemp1$lake,
                           "depth" = MendotaTemp1$depth_m,
                           "variable" = rep("temp_C", nrow(MendotaTemp1)),
                           "observation" = MendotaTemp1$temperature,
                           "flag" = rep(NA, nrow(MendotaTemp1)))
df <- rbind(df, MendotaTemp2)

# https://portal.edirepository.org/nis/codeGeneration?packageId=knb-lter-ntl.129.34&statisticalFileType=r ####
source("Sources/knb-lter-ntl.129.34.r")
MendotaTemp3 <- subset(dt3, select = c("sampledate", "sampletime", "chlor_rfu", "flag_chlor_rfu", "phyco_rfu", "flag_phyco_rfu", "do_raw", "flag_do_raw", "do_wtemp", "flag_do_wtemp", "fdom", "flag_fdom"))
MendotaTemp3$datetime <- paste(MendotaTemp3$sampledate, MendotaTemp3$sampletime)
MendotaTemp3$datetime <- strptime(MendotaTemp3$datetime, format = "%Y-%m-%d %H:%M:%S")
MendotaTemp3_a <- data.frame("datetime" = MendotaTemp3$datetime,
                             "lake" = rep("Mendota", nrow(MendotaTemp3)),
                             "depth" = rep(0, nrow(MendotaTemp3)),
                             "variable" = rep("chlor_rfu", nrow(MendotaTemp3)),
                             "observation" = MendotaTemp3$chlor_rfu,
                             "flag" = MendotaTemp3$flag_chlor_rfu)
MendotaTemp3_b <- data.frame("datetime" = MendotaTemp3$datetime,
                             "lake" = rep("Mendota", nrow(MendotaTemp3)),
                             "depth" = rep(0, nrow(MendotaTemp3)),
                             "variable" = rep("phyco_rfu", nrow(MendotaTemp3)),
                             "observation" = MendotaTemp3$phyco_rfu,
                             "flag" = MendotaTemp3$phyco_rfu)
MendotaTemp3_c <- data.frame("datetime" = MendotaTemp3$datetime,
                             "lake" = rep("Mendota", nrow(MendotaTemp3)),
                             "depth" = rep(0, nrow(MendotaTemp3)),
                             "variable" = rep("do_mgl", nrow(MendotaTemp3)),
                             "observation" = MendotaTemp3$do_raw,
                             "flag" = MendotaTemp3$flag_do_raw)
MendotaTemp3_d <- data.frame("datetime" = MendotaTemp3$datetime,
                             "lake" = rep("Mendota", nrow(MendotaTemp3)),
                             "depth" = rep(0, nrow(MendotaTemp3)),
                             "variable" = rep("temp_C", nrow(MendotaTemp3)),
                             "observation" = MendotaTemp3$do_wtemp,
                             "flag" = MendotaTemp3$flag_do_wtemp)
MendotaTemp3_e <- data.frame("datetime" = MendotaTemp3$datetime,
                             "lake" = rep("Mendota", nrow(MendotaTemp3)),
                             "depth" = rep(0, nrow(MendotaTemp3)),
                             "variable" = rep("fdom_rfu", nrow(MendotaTemp3)),
                             "observation" = MendotaTemp3$fdom,
                             "flag" = MendotaTemp3$flag_fdom)
df <- rbind(df, MendotaTemp3_a)
df <- rbind(df, MendotaTemp3_b)
df <- rbind(df, MendotaTemp3_c)
df <- rbind(df, MendotaTemp3_d)
df <- rbind(df, MendotaTemp3_e)
df <- df[!is.na(df$observation),]

# https://portal.edirepository.org/nis/codeGeneration?packageId=knb-lter-ntl.130.30&statisticalFileType=r ####

# https://portal.edirepository.org/nis/codeGeneration?packageId=knb-lter-ntl.258.4&statisticalFileType=r ####

