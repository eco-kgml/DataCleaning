# Package ID: knb-lter-ntl.129.34 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: High Frequency Data: Meteorological, Dissolved Oxygen, Chlorophyll, Phycocyanin - Lake Mendota Buoy 2006 - current.
# Data set creator:  John Magnuson - University of Wisconsin 
# Data set creator:  Stephen Carpenter - University of Wisconsin 
# Data set creator:  Emily Stanley - University of Wisconsin 
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/129/34/cba9ed12834b8f315d6b10675bb60c5a" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

                   
 dt1 <-read.csv(infile1,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "year4",     
                    "sampledate",     
                    "avg_air_temp",     
                    "flag_avg_air_temp",     
                    "avg_rel_hum",     
                    "flag_avg_rel_hum",     
                    "avg_wind_speed",     
                    "flag_avg_wind_speed",     
                    "avg_wind_dir",     
                    "flag_avg_wind_dir",     
                    "avg_chlor_rfu",     
                    "flag_avg_chlor_rfu",     
                    "avg_phyco_rfu",     
                    "flag_avg_phyco_rfu",     
                    "avg_par",     
                    "flag_avg_par",     
                    "avg_par_below",     
                    "flag_avg_par_below",     
                    "avg_do_wtemp",     
                    "flag_avg_do_wtemp",     
                    "avg_do_sat",     
                    "flag_avg_do_sat",     
                    "avg_do_raw",     
                    "flag_avg_do_raw",     
                    "avg_pco2_ppm",     
                    "flag_avg_pco2_ppm",     
                    "avg_ph",     
                    "flag_avg_ph",     
                    "avg_fdom",     
                    "flag_avg_fdom",     
                    "avg_turbidity",     
                    "flag_avg_turbidity",     
                    "avg_spec_cond",     
                    "flag_avg_spec_cond"    ), check.names=TRUE)
               
unlink(infile1)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]               
if (class(dt1$year4)=="character") dt1$year4 <-as.numeric(dt1$year4)                                   
# attempting to convert dt1$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp1sampledate<-as.Date(dt1$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sampledate) == length(tmp1sampledate[!is.na(tmp1sampledate)])){dt1$sampledate <- tmp1sampledate } else {print("Date conversion failed for dt1$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1sampledate) 
if (class(dt1$avg_air_temp)=="factor") dt1$avg_air_temp <-as.numeric(levels(dt1$avg_air_temp))[as.integer(dt1$avg_air_temp) ]               
if (class(dt1$avg_air_temp)=="character") dt1$avg_air_temp <-as.numeric(dt1$avg_air_temp)
if (class(dt1$flag_avg_air_temp)!="factor") dt1$flag_avg_air_temp<- as.factor(dt1$flag_avg_air_temp)
if (class(dt1$avg_rel_hum)=="factor") dt1$avg_rel_hum <-as.numeric(levels(dt1$avg_rel_hum))[as.integer(dt1$avg_rel_hum) ]               
if (class(dt1$avg_rel_hum)=="character") dt1$avg_rel_hum <-as.numeric(dt1$avg_rel_hum)
if (class(dt1$flag_avg_rel_hum)!="factor") dt1$flag_avg_rel_hum<- as.factor(dt1$flag_avg_rel_hum)
if (class(dt1$avg_wind_speed)=="factor") dt1$avg_wind_speed <-as.numeric(levels(dt1$avg_wind_speed))[as.integer(dt1$avg_wind_speed) ]               
if (class(dt1$avg_wind_speed)=="character") dt1$avg_wind_speed <-as.numeric(dt1$avg_wind_speed)
if (class(dt1$flag_avg_wind_speed)!="factor") dt1$flag_avg_wind_speed<- as.factor(dt1$flag_avg_wind_speed)
if (class(dt1$avg_wind_dir)=="factor") dt1$avg_wind_dir <-as.numeric(levels(dt1$avg_wind_dir))[as.integer(dt1$avg_wind_dir) ]               
if (class(dt1$avg_wind_dir)=="character") dt1$avg_wind_dir <-as.numeric(dt1$avg_wind_dir)
if (class(dt1$flag_avg_wind_dir)!="factor") dt1$flag_avg_wind_dir<- as.factor(dt1$flag_avg_wind_dir)
if (class(dt1$avg_chlor_rfu)=="factor") dt1$avg_chlor_rfu <-as.numeric(levels(dt1$avg_chlor_rfu))[as.integer(dt1$avg_chlor_rfu) ]               
if (class(dt1$avg_chlor_rfu)=="character") dt1$avg_chlor_rfu <-as.numeric(dt1$avg_chlor_rfu)
if (class(dt1$flag_avg_chlor_rfu)!="factor") dt1$flag_avg_chlor_rfu<- as.factor(dt1$flag_avg_chlor_rfu)
if (class(dt1$avg_phyco_rfu)=="factor") dt1$avg_phyco_rfu <-as.numeric(levels(dt1$avg_phyco_rfu))[as.integer(dt1$avg_phyco_rfu) ]               
if (class(dt1$avg_phyco_rfu)=="character") dt1$avg_phyco_rfu <-as.numeric(dt1$avg_phyco_rfu)
if (class(dt1$flag_avg_phyco_rfu)!="factor") dt1$flag_avg_phyco_rfu<- as.factor(dt1$flag_avg_phyco_rfu)
if (class(dt1$avg_par)=="factor") dt1$avg_par <-as.numeric(levels(dt1$avg_par))[as.integer(dt1$avg_par) ]               
if (class(dt1$avg_par)=="character") dt1$avg_par <-as.numeric(dt1$avg_par)
if (class(dt1$flag_avg_par)!="factor") dt1$flag_avg_par<- as.factor(dt1$flag_avg_par)
if (class(dt1$avg_par_below)=="factor") dt1$avg_par_below <-as.numeric(levels(dt1$avg_par_below))[as.integer(dt1$avg_par_below) ]               
if (class(dt1$avg_par_below)=="character") dt1$avg_par_below <-as.numeric(dt1$avg_par_below)
if (class(dt1$flag_avg_par_below)!="factor") dt1$flag_avg_par_below<- as.factor(dt1$flag_avg_par_below)
if (class(dt1$avg_do_wtemp)=="factor") dt1$avg_do_wtemp <-as.numeric(levels(dt1$avg_do_wtemp))[as.integer(dt1$avg_do_wtemp) ]               
if (class(dt1$avg_do_wtemp)=="character") dt1$avg_do_wtemp <-as.numeric(dt1$avg_do_wtemp)
if (class(dt1$flag_avg_do_wtemp)!="factor") dt1$flag_avg_do_wtemp<- as.factor(dt1$flag_avg_do_wtemp)
if (class(dt1$avg_do_sat)=="factor") dt1$avg_do_sat <-as.numeric(levels(dt1$avg_do_sat))[as.integer(dt1$avg_do_sat) ]               
if (class(dt1$avg_do_sat)=="character") dt1$avg_do_sat <-as.numeric(dt1$avg_do_sat)
if (class(dt1$flag_avg_do_sat)!="factor") dt1$flag_avg_do_sat<- as.factor(dt1$flag_avg_do_sat)
if (class(dt1$avg_do_raw)=="factor") dt1$avg_do_raw <-as.numeric(levels(dt1$avg_do_raw))[as.integer(dt1$avg_do_raw) ]               
if (class(dt1$avg_do_raw)=="character") dt1$avg_do_raw <-as.numeric(dt1$avg_do_raw)
if (class(dt1$flag_avg_do_raw)!="factor") dt1$flag_avg_do_raw<- as.factor(dt1$flag_avg_do_raw)
if (class(dt1$avg_pco2_ppm)=="factor") dt1$avg_pco2_ppm <-as.numeric(levels(dt1$avg_pco2_ppm))[as.integer(dt1$avg_pco2_ppm) ]               
if (class(dt1$avg_pco2_ppm)=="character") dt1$avg_pco2_ppm <-as.numeric(dt1$avg_pco2_ppm)
if (class(dt1$flag_avg_pco2_ppm)!="factor") dt1$flag_avg_pco2_ppm<- as.factor(dt1$flag_avg_pco2_ppm)
if (class(dt1$avg_ph)=="factor") dt1$avg_ph <-as.numeric(levels(dt1$avg_ph))[as.integer(dt1$avg_ph) ]               
if (class(dt1$avg_ph)=="character") dt1$avg_ph <-as.numeric(dt1$avg_ph)
if (class(dt1$flag_avg_ph)!="factor") dt1$flag_avg_ph<- as.factor(dt1$flag_avg_ph)
if (class(dt1$avg_fdom)=="factor") dt1$avg_fdom <-as.numeric(levels(dt1$avg_fdom))[as.integer(dt1$avg_fdom) ]               
if (class(dt1$avg_fdom)=="character") dt1$avg_fdom <-as.numeric(dt1$avg_fdom)
if (class(dt1$flag_avg_fdom)!="factor") dt1$flag_avg_fdom<- as.factor(dt1$flag_avg_fdom)
if (class(dt1$avg_turbidity)=="factor") dt1$avg_turbidity <-as.numeric(levels(dt1$avg_turbidity))[as.integer(dt1$avg_turbidity) ]               
if (class(dt1$avg_turbidity)=="character") dt1$avg_turbidity <-as.numeric(dt1$avg_turbidity)
if (class(dt1$flag_avg_turbidity)!="factor") dt1$flag_avg_turbidity<- as.factor(dt1$flag_avg_turbidity)
if (class(dt1$avg_spec_cond)=="factor") dt1$avg_spec_cond <-as.numeric(levels(dt1$avg_spec_cond))[as.integer(dt1$avg_spec_cond) ]               
if (class(dt1$avg_spec_cond)=="character") dt1$avg_spec_cond <-as.numeric(dt1$avg_spec_cond)
if (class(dt1$flag_avg_spec_cond)!="factor") dt1$flag_avg_spec_cond<- as.factor(dt1$flag_avg_spec_cond)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(year4)
summary(sampledate)
summary(avg_air_temp)
summary(flag_avg_air_temp)
summary(avg_rel_hum)
summary(flag_avg_rel_hum)
summary(avg_wind_speed)
summary(flag_avg_wind_speed)
summary(avg_wind_dir)
summary(flag_avg_wind_dir)
summary(avg_chlor_rfu)
summary(flag_avg_chlor_rfu)
summary(avg_phyco_rfu)
summary(flag_avg_phyco_rfu)
summary(avg_par)
summary(flag_avg_par)
summary(avg_par_below)
summary(flag_avg_par_below)
summary(avg_do_wtemp)
summary(flag_avg_do_wtemp)
summary(avg_do_sat)
summary(flag_avg_do_sat)
summary(avg_do_raw)
summary(flag_avg_do_raw)
summary(avg_pco2_ppm)
summary(flag_avg_pco2_ppm)
summary(avg_ph)
summary(flag_avg_ph)
summary(avg_fdom)
summary(flag_avg_fdom)
summary(avg_turbidity)
summary(flag_avg_turbidity)
summary(avg_spec_cond)
summary(flag_avg_spec_cond) 
                # Get more details on character variables
                 
summary(as.factor(dt1$flag_avg_air_temp)) 
summary(as.factor(dt1$flag_avg_rel_hum)) 
summary(as.factor(dt1$flag_avg_wind_speed)) 
summary(as.factor(dt1$flag_avg_wind_dir)) 
summary(as.factor(dt1$flag_avg_chlor_rfu)) 
summary(as.factor(dt1$flag_avg_phyco_rfu)) 
summary(as.factor(dt1$flag_avg_par)) 
summary(as.factor(dt1$flag_avg_par_below)) 
summary(as.factor(dt1$flag_avg_do_wtemp)) 
summary(as.factor(dt1$flag_avg_do_sat)) 
summary(as.factor(dt1$flag_avg_do_raw)) 
summary(as.factor(dt1$flag_avg_pco2_ppm)) 
summary(as.factor(dt1$flag_avg_ph)) 
summary(as.factor(dt1$flag_avg_fdom)) 
summary(as.factor(dt1$flag_avg_turbidity)) 
summary(as.factor(dt1$flag_avg_spec_cond))
detach(dt1)               
         

inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/129/34/72494d432fe1e977f5326100a733cece" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")

                   
 dt2 <-read.csv(infile2,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "year4",     
                    "sampledate",     
                    "hour",     
                    "avg_air_temp",     
                    "flag_avg_air_temp",     
                    "avg_rel_hum",     
                    "flag_avg_rel_hum",     
                    "avg_wind_speed",     
                    "flag_avg_wind_speed",     
                    "avg_wind_dir",     
                    "flag_avg_wind_dir",     
                    "avg_chlor_rfu",     
                    "flag_avg_chlor_rfu",     
                    "avg_phyco_rfu",     
                    "flag_avg_phyco_rfu",     
                    "avg_par",     
                    "flag_avg_par",     
                    "avg_par_below",     
                    "flag_avg_par_below",     
                    "avg_do_wtemp",     
                    "flag_avg_do_wtemp",     
                    "avg_do_sat",     
                    "flag_avg_do_sat",     
                    "avg_do_raw",     
                    "flag_avg_do_raw",     
                    "avg_pco2_ppm",     
                    "flag_avg_pco2_ppm",     
                    "avg_ph",     
                    "flag_avg_ph",     
                    "avg_fdom",     
                    "flag_avg_fdom",     
                    "avg_turbidity",     
                    "flag_avg_turbidity",     
                    "avg_spec_cond",     
                    "flag_avg_spec_cond"    ), check.names=TRUE)
               
unlink(infile2)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt2$year4)=="factor") dt2$year4 <-as.numeric(levels(dt2$year4))[as.integer(dt2$year4) ]               
if (class(dt2$year4)=="character") dt2$year4 <-as.numeric(dt2$year4)                                   
# attempting to convert dt2$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp2sampledate<-as.Date(dt2$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp2sampledate) == length(tmp2sampledate[!is.na(tmp2sampledate)])){dt2$sampledate <- tmp2sampledate } else {print("Date conversion failed for dt2$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp2sampledate) 
if (class(dt2$hour)=="factor") dt2$hour <-as.numeric(levels(dt2$hour))[as.integer(dt2$hour) ]               
if (class(dt2$hour)=="character") dt2$hour <-as.numeric(dt2$hour)
if (class(dt2$avg_air_temp)=="factor") dt2$avg_air_temp <-as.numeric(levels(dt2$avg_air_temp))[as.integer(dt2$avg_air_temp) ]               
if (class(dt2$avg_air_temp)=="character") dt2$avg_air_temp <-as.numeric(dt2$avg_air_temp)
if (class(dt2$flag_avg_air_temp)!="factor") dt2$flag_avg_air_temp<- as.factor(dt2$flag_avg_air_temp)
if (class(dt2$avg_rel_hum)=="factor") dt2$avg_rel_hum <-as.numeric(levels(dt2$avg_rel_hum))[as.integer(dt2$avg_rel_hum) ]               
if (class(dt2$avg_rel_hum)=="character") dt2$avg_rel_hum <-as.numeric(dt2$avg_rel_hum)
if (class(dt2$flag_avg_rel_hum)!="factor") dt2$flag_avg_rel_hum<- as.factor(dt2$flag_avg_rel_hum)
if (class(dt2$avg_wind_speed)=="factor") dt2$avg_wind_speed <-as.numeric(levels(dt2$avg_wind_speed))[as.integer(dt2$avg_wind_speed) ]               
if (class(dt2$avg_wind_speed)=="character") dt2$avg_wind_speed <-as.numeric(dt2$avg_wind_speed)
if (class(dt2$flag_avg_wind_speed)!="factor") dt2$flag_avg_wind_speed<- as.factor(dt2$flag_avg_wind_speed)
if (class(dt2$avg_wind_dir)=="factor") dt2$avg_wind_dir <-as.numeric(levels(dt2$avg_wind_dir))[as.integer(dt2$avg_wind_dir) ]               
if (class(dt2$avg_wind_dir)=="character") dt2$avg_wind_dir <-as.numeric(dt2$avg_wind_dir)
if (class(dt2$flag_avg_wind_dir)!="factor") dt2$flag_avg_wind_dir<- as.factor(dt2$flag_avg_wind_dir)
if (class(dt2$avg_chlor_rfu)=="factor") dt2$avg_chlor_rfu <-as.numeric(levels(dt2$avg_chlor_rfu))[as.integer(dt2$avg_chlor_rfu) ]               
if (class(dt2$avg_chlor_rfu)=="character") dt2$avg_chlor_rfu <-as.numeric(dt2$avg_chlor_rfu)
if (class(dt2$flag_avg_chlor_rfu)!="factor") dt2$flag_avg_chlor_rfu<- as.factor(dt2$flag_avg_chlor_rfu)
if (class(dt2$avg_phyco_rfu)=="factor") dt2$avg_phyco_rfu <-as.numeric(levels(dt2$avg_phyco_rfu))[as.integer(dt2$avg_phyco_rfu) ]               
if (class(dt2$avg_phyco_rfu)=="character") dt2$avg_phyco_rfu <-as.numeric(dt2$avg_phyco_rfu)
if (class(dt2$flag_avg_phyco_rfu)!="factor") dt2$flag_avg_phyco_rfu<- as.factor(dt2$flag_avg_phyco_rfu)
if (class(dt2$avg_par)=="factor") dt2$avg_par <-as.numeric(levels(dt2$avg_par))[as.integer(dt2$avg_par) ]               
if (class(dt2$avg_par)=="character") dt2$avg_par <-as.numeric(dt2$avg_par)
if (class(dt2$flag_avg_par)!="factor") dt2$flag_avg_par<- as.factor(dt2$flag_avg_par)
if (class(dt2$avg_par_below)=="factor") dt2$avg_par_below <-as.numeric(levels(dt2$avg_par_below))[as.integer(dt2$avg_par_below) ]               
if (class(dt2$avg_par_below)=="character") dt2$avg_par_below <-as.numeric(dt2$avg_par_below)
if (class(dt2$flag_avg_par_below)!="factor") dt2$flag_avg_par_below<- as.factor(dt2$flag_avg_par_below)
if (class(dt2$avg_do_wtemp)=="factor") dt2$avg_do_wtemp <-as.numeric(levels(dt2$avg_do_wtemp))[as.integer(dt2$avg_do_wtemp) ]               
if (class(dt2$avg_do_wtemp)=="character") dt2$avg_do_wtemp <-as.numeric(dt2$avg_do_wtemp)
if (class(dt2$flag_avg_do_wtemp)!="factor") dt2$flag_avg_do_wtemp<- as.factor(dt2$flag_avg_do_wtemp)
if (class(dt2$avg_do_sat)=="factor") dt2$avg_do_sat <-as.numeric(levels(dt2$avg_do_sat))[as.integer(dt2$avg_do_sat) ]               
if (class(dt2$avg_do_sat)=="character") dt2$avg_do_sat <-as.numeric(dt2$avg_do_sat)
if (class(dt2$flag_avg_do_sat)!="factor") dt2$flag_avg_do_sat<- as.factor(dt2$flag_avg_do_sat)
if (class(dt2$avg_do_raw)=="factor") dt2$avg_do_raw <-as.numeric(levels(dt2$avg_do_raw))[as.integer(dt2$avg_do_raw) ]               
if (class(dt2$avg_do_raw)=="character") dt2$avg_do_raw <-as.numeric(dt2$avg_do_raw)
if (class(dt2$flag_avg_do_raw)!="factor") dt2$flag_avg_do_raw<- as.factor(dt2$flag_avg_do_raw)
if (class(dt2$avg_pco2_ppm)=="factor") dt2$avg_pco2_ppm <-as.numeric(levels(dt2$avg_pco2_ppm))[as.integer(dt2$avg_pco2_ppm) ]               
if (class(dt2$avg_pco2_ppm)=="character") dt2$avg_pco2_ppm <-as.numeric(dt2$avg_pco2_ppm)
if (class(dt2$flag_avg_pco2_ppm)!="factor") dt2$flag_avg_pco2_ppm<- as.factor(dt2$flag_avg_pco2_ppm)
if (class(dt2$avg_ph)=="factor") dt2$avg_ph <-as.numeric(levels(dt2$avg_ph))[as.integer(dt2$avg_ph) ]               
if (class(dt2$avg_ph)=="character") dt2$avg_ph <-as.numeric(dt2$avg_ph)
if (class(dt2$flag_avg_ph)!="factor") dt2$flag_avg_ph<- as.factor(dt2$flag_avg_ph)
if (class(dt2$avg_fdom)=="factor") dt2$avg_fdom <-as.numeric(levels(dt2$avg_fdom))[as.integer(dt2$avg_fdom) ]               
if (class(dt2$avg_fdom)=="character") dt2$avg_fdom <-as.numeric(dt2$avg_fdom)
if (class(dt2$flag_avg_fdom)!="factor") dt2$flag_avg_fdom<- as.factor(dt2$flag_avg_fdom)
if (class(dt2$avg_turbidity)=="factor") dt2$avg_turbidity <-as.numeric(levels(dt2$avg_turbidity))[as.integer(dt2$avg_turbidity) ]               
if (class(dt2$avg_turbidity)=="character") dt2$avg_turbidity <-as.numeric(dt2$avg_turbidity)
if (class(dt2$flag_avg_turbidity)!="factor") dt2$flag_avg_turbidity<- as.factor(dt2$flag_avg_turbidity)
if (class(dt2$avg_spec_cond)=="factor") dt2$avg_spec_cond <-as.numeric(levels(dt2$avg_spec_cond))[as.integer(dt2$avg_spec_cond) ]               
if (class(dt2$avg_spec_cond)=="character") dt2$avg_spec_cond <-as.numeric(dt2$avg_spec_cond)
if (class(dt2$flag_avg_spec_cond)!="factor") dt2$flag_avg_spec_cond<- as.factor(dt2$flag_avg_spec_cond)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt2)                            
attach(dt2)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(year4)
summary(sampledate)
summary(hour)
summary(avg_air_temp)
summary(flag_avg_air_temp)
summary(avg_rel_hum)
summary(flag_avg_rel_hum)
summary(avg_wind_speed)
summary(flag_avg_wind_speed)
summary(avg_wind_dir)
summary(flag_avg_wind_dir)
summary(avg_chlor_rfu)
summary(flag_avg_chlor_rfu)
summary(avg_phyco_rfu)
summary(flag_avg_phyco_rfu)
summary(avg_par)
summary(flag_avg_par)
summary(avg_par_below)
summary(flag_avg_par_below)
summary(avg_do_wtemp)
summary(flag_avg_do_wtemp)
summary(avg_do_sat)
summary(flag_avg_do_sat)
summary(avg_do_raw)
summary(flag_avg_do_raw)
summary(avg_pco2_ppm)
summary(flag_avg_pco2_ppm)
summary(avg_ph)
summary(flag_avg_ph)
summary(avg_fdom)
summary(flag_avg_fdom)
summary(avg_turbidity)
summary(flag_avg_turbidity)
summary(avg_spec_cond)
summary(flag_avg_spec_cond) 
                # Get more details on character variables
                 
summary(as.factor(dt2$flag_avg_air_temp)) 
summary(as.factor(dt2$flag_avg_rel_hum)) 
summary(as.factor(dt2$flag_avg_wind_speed)) 
summary(as.factor(dt2$flag_avg_wind_dir)) 
summary(as.factor(dt2$flag_avg_chlor_rfu)) 
summary(as.factor(dt2$flag_avg_phyco_rfu)) 
summary(as.factor(dt2$flag_avg_par)) 
summary(as.factor(dt2$flag_avg_par_below)) 
summary(as.factor(dt2$flag_avg_do_wtemp)) 
summary(as.factor(dt2$flag_avg_do_sat)) 
summary(as.factor(dt2$flag_avg_do_raw)) 
summary(as.factor(dt2$flag_avg_pco2_ppm)) 
summary(as.factor(dt2$flag_avg_ph)) 
summary(as.factor(dt2$flag_avg_fdom)) 
summary(as.factor(dt2$flag_avg_turbidity)) 
summary(as.factor(dt2$flag_avg_spec_cond))
detach(dt2)               
         

inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/129/34/b4becc2c76260ef599b0cc96b2bb9779" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")

                   
 dt3 <-read.csv(infile3,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "year4",     
                    "sampledate",     
                    "sampletime",     
                    "air_temp",     
                    "flag_air_temp",     
                    "rel_hum",     
                    "flag_rel_hum",     
                    "wind_speed",     
                    "flag_wind_speed",     
                    "wind_dir",     
                    "flag_wind_dir",     
                    "chlor_rfu",     
                    "flag_chlor_rfu",     
                    "phyco_rfu",     
                    "flag_phyco_rfu",     
                    "do_raw",     
                    "flag_do_raw",     
                    "do_sat",     
                    "flag_do_sat",     
                    "do_wtemp",     
                    "flag_do_wtemp",     
                    "pco2_ppm",     
                    "flag_pco2_ppm",     
                    "par",     
                    "flag_par",     
                    "par_below",     
                    "flag_par_below",     
                    "ph",     
                    "flag_ph",     
                    "fdom",     
                    "flag_fdom",     
                    "turbidity",     
                    "flag_turbidity",     
                    "spec_cond",     
                    "flag_spec_cond"    ), check.names=TRUE)
               
unlink(infile3)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt3$year4)=="factor") dt3$year4 <-as.numeric(levels(dt3$year4))[as.integer(dt3$year4) ]               
if (class(dt3$year4)=="character") dt3$year4 <-as.numeric(dt3$year4)                                   
# attempting to convert dt3$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp3sampledate<-as.Date(dt3$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3sampledate) == length(tmp3sampledate[!is.na(tmp3sampledate)])){dt3$sampledate <- tmp3sampledate } else {print("Date conversion failed for dt3$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp3sampledate) 
if (class(dt3$air_temp)=="factor") dt3$air_temp <-as.numeric(levels(dt3$air_temp))[as.integer(dt3$air_temp) ]               
if (class(dt3$air_temp)=="character") dt3$air_temp <-as.numeric(dt3$air_temp)
if (class(dt3$flag_air_temp)!="factor") dt3$flag_air_temp<- as.factor(dt3$flag_air_temp)
if (class(dt3$rel_hum)=="factor") dt3$rel_hum <-as.numeric(levels(dt3$rel_hum))[as.integer(dt3$rel_hum) ]               
if (class(dt3$rel_hum)=="character") dt3$rel_hum <-as.numeric(dt3$rel_hum)
if (class(dt3$flag_rel_hum)!="factor") dt3$flag_rel_hum<- as.factor(dt3$flag_rel_hum)
if (class(dt3$wind_speed)=="factor") dt3$wind_speed <-as.numeric(levels(dt3$wind_speed))[as.integer(dt3$wind_speed) ]               
if (class(dt3$wind_speed)=="character") dt3$wind_speed <-as.numeric(dt3$wind_speed)
if (class(dt3$flag_wind_speed)!="factor") dt3$flag_wind_speed<- as.factor(dt3$flag_wind_speed)
if (class(dt3$wind_dir)=="factor") dt3$wind_dir <-as.numeric(levels(dt3$wind_dir))[as.integer(dt3$wind_dir) ]               
if (class(dt3$wind_dir)=="character") dt3$wind_dir <-as.numeric(dt3$wind_dir)
if (class(dt3$flag_wind_dir)!="factor") dt3$flag_wind_dir<- as.factor(dt3$flag_wind_dir)
if (class(dt3$chlor_rfu)=="factor") dt3$chlor_rfu <-as.numeric(levels(dt3$chlor_rfu))[as.integer(dt3$chlor_rfu) ]               
if (class(dt3$chlor_rfu)=="character") dt3$chlor_rfu <-as.numeric(dt3$chlor_rfu)
if (class(dt3$flag_chlor_rfu)!="factor") dt3$flag_chlor_rfu<- as.factor(dt3$flag_chlor_rfu)
if (class(dt3$phyco_rfu)=="factor") dt3$phyco_rfu <-as.numeric(levels(dt3$phyco_rfu))[as.integer(dt3$phyco_rfu) ]               
if (class(dt3$phyco_rfu)=="character") dt3$phyco_rfu <-as.numeric(dt3$phyco_rfu)
if (class(dt3$flag_phyco_rfu)!="factor") dt3$flag_phyco_rfu<- as.factor(dt3$flag_phyco_rfu)
if (class(dt3$do_raw)=="factor") dt3$do_raw <-as.numeric(levels(dt3$do_raw))[as.integer(dt3$do_raw) ]               
if (class(dt3$do_raw)=="character") dt3$do_raw <-as.numeric(dt3$do_raw)
if (class(dt3$flag_do_raw)!="factor") dt3$flag_do_raw<- as.factor(dt3$flag_do_raw)
if (class(dt3$do_sat)=="factor") dt3$do_sat <-as.numeric(levels(dt3$do_sat))[as.integer(dt3$do_sat) ]               
if (class(dt3$do_sat)=="character") dt3$do_sat <-as.numeric(dt3$do_sat)
if (class(dt3$flag_do_sat)!="factor") dt3$flag_do_sat<- as.factor(dt3$flag_do_sat)
if (class(dt3$do_wtemp)=="factor") dt3$do_wtemp <-as.numeric(levels(dt3$do_wtemp))[as.integer(dt3$do_wtemp) ]               
if (class(dt3$do_wtemp)=="character") dt3$do_wtemp <-as.numeric(dt3$do_wtemp)
if (class(dt3$flag_do_wtemp)!="factor") dt3$flag_do_wtemp<- as.factor(dt3$flag_do_wtemp)
if (class(dt3$pco2_ppm)=="factor") dt3$pco2_ppm <-as.numeric(levels(dt3$pco2_ppm))[as.integer(dt3$pco2_ppm) ]               
if (class(dt3$pco2_ppm)=="character") dt3$pco2_ppm <-as.numeric(dt3$pco2_ppm)
if (class(dt3$flag_pco2_ppm)!="factor") dt3$flag_pco2_ppm<- as.factor(dt3$flag_pco2_ppm)
if (class(dt3$par)=="factor") dt3$par <-as.numeric(levels(dt3$par))[as.integer(dt3$par) ]               
if (class(dt3$par)=="character") dt3$par <-as.numeric(dt3$par)
if (class(dt3$flag_par)!="factor") dt3$flag_par<- as.factor(dt3$flag_par)
if (class(dt3$par_below)=="factor") dt3$par_below <-as.numeric(levels(dt3$par_below))[as.integer(dt3$par_below) ]               
if (class(dt3$par_below)=="character") dt3$par_below <-as.numeric(dt3$par_below)
if (class(dt3$flag_par_below)!="factor") dt3$flag_par_below<- as.factor(dt3$flag_par_below)
if (class(dt3$ph)=="factor") dt3$ph <-as.numeric(levels(dt3$ph))[as.integer(dt3$ph) ]               
if (class(dt3$ph)=="character") dt3$ph <-as.numeric(dt3$ph)
if (class(dt3$flag_ph)!="factor") dt3$flag_ph<- as.factor(dt3$flag_ph)
if (class(dt3$fdom)=="factor") dt3$fdom <-as.numeric(levels(dt3$fdom))[as.integer(dt3$fdom) ]               
if (class(dt3$fdom)=="character") dt3$fdom <-as.numeric(dt3$fdom)
if (class(dt3$flag_fdom)!="factor") dt3$flag_fdom<- as.factor(dt3$flag_fdom)
if (class(dt3$turbidity)=="factor") dt3$turbidity <-as.numeric(levels(dt3$turbidity))[as.integer(dt3$turbidity) ]               
if (class(dt3$turbidity)=="character") dt3$turbidity <-as.numeric(dt3$turbidity)
if (class(dt3$flag_turbidity)!="factor") dt3$flag_turbidity<- as.factor(dt3$flag_turbidity)
if (class(dt3$spec_cond)=="factor") dt3$spec_cond <-as.numeric(levels(dt3$spec_cond))[as.integer(dt3$spec_cond) ]               
if (class(dt3$spec_cond)=="character") dt3$spec_cond <-as.numeric(dt3$spec_cond)
if (class(dt3$flag_spec_cond)!="factor") dt3$flag_spec_cond<- as.factor(dt3$flag_spec_cond)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt3)                            
attach(dt3)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(year4)
summary(sampledate)
summary(sampletime)
summary(air_temp)
summary(flag_air_temp)
summary(rel_hum)
summary(flag_rel_hum)
summary(wind_speed)
summary(flag_wind_speed)
summary(wind_dir)
summary(flag_wind_dir)
summary(chlor_rfu)
summary(flag_chlor_rfu)
summary(phyco_rfu)
summary(flag_phyco_rfu)
summary(do_raw)
summary(flag_do_raw)
summary(do_sat)
summary(flag_do_sat)
summary(do_wtemp)
summary(flag_do_wtemp)
summary(pco2_ppm)
summary(flag_pco2_ppm)
summary(par)
summary(flag_par)
summary(par_below)
summary(flag_par_below)
summary(ph)
summary(flag_ph)
summary(fdom)
summary(flag_fdom)
summary(turbidity)
summary(flag_turbidity)
summary(spec_cond)
summary(flag_spec_cond) 
                # Get more details on character variables
                 
summary(as.factor(dt3$flag_air_temp)) 
summary(as.factor(dt3$flag_rel_hum)) 
summary(as.factor(dt3$flag_wind_speed)) 
summary(as.factor(dt3$flag_wind_dir)) 
summary(as.factor(dt3$flag_chlor_rfu)) 
summary(as.factor(dt3$flag_phyco_rfu)) 
summary(as.factor(dt3$flag_do_raw)) 
summary(as.factor(dt3$flag_do_sat)) 
summary(as.factor(dt3$flag_do_wtemp)) 
summary(as.factor(dt3$flag_pco2_ppm)) 
summary(as.factor(dt3$flag_par)) 
summary(as.factor(dt3$flag_par_below)) 
summary(as.factor(dt3$flag_ph)) 
summary(as.factor(dt3$flag_fdom)) 
summary(as.factor(dt3$flag_turbidity)) 
summary(as.factor(dt3$flag_spec_cond))
detach(dt3)               
        




