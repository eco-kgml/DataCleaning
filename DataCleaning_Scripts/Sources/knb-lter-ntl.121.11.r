# Package ID: knb-lter-ntl.121.11 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: High Frequency Water Temperature Data - Trout Lake Buoy2 - ADCP 2005 - 2006.
# Data set creator:  John Magnuson - University of Wisconsin 
# Data set creator:  Stephen Carpenter - University of Wisconsin 
# Data set creator:  Emily Stanley - University of Wisconsin 
# Metadata Provider:    - North Temperate Lakes LTER 
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/121/11/d94f1ccf1cab0a0cb69d8fdda253b610" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

                   
 dt1 <-read.csv(infile1,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "year4",     
                    "month",     
                    "daynum",     
                    "depth",     
                    "avg_wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile1)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                                                   
# attempting to convert dt1$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp1sampledate<-as.Date(dt1$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sampledate) == length(tmp1sampledate[!is.na(tmp1sampledate)])){dt1$sampledate <- tmp1sampledate } else {print("Date conversion failed for dt1$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1sampledate) 
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]               
if (class(dt1$year4)=="character") dt1$year4 <-as.numeric(dt1$year4)
if (class(dt1$month)=="factor") dt1$month <-as.numeric(levels(dt1$month))[as.integer(dt1$month) ]               
if (class(dt1$month)=="character") dt1$month <-as.numeric(dt1$month)
if (class(dt1$daynum)=="factor") dt1$daynum <-as.numeric(levels(dt1$daynum))[as.integer(dt1$daynum) ]               
if (class(dt1$daynum)=="character") dt1$daynum <-as.numeric(dt1$daynum)
if (class(dt1$depth)=="factor") dt1$depth <-as.numeric(levels(dt1$depth))[as.integer(dt1$depth) ]               
if (class(dt1$depth)=="character") dt1$depth <-as.numeric(dt1$depth)
if (class(dt1$avg_wtemp)=="factor") dt1$avg_wtemp <-as.numeric(levels(dt1$avg_wtemp))[as.integer(dt1$avg_wtemp) ]               
if (class(dt1$avg_wtemp)=="character") dt1$avg_wtemp <-as.numeric(dt1$avg_wtemp)
if (class(dt1$flag_wtemp)!="factor") dt1$flag_wtemp<- as.factor(dt1$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(year4)
summary(month)
summary(daynum)
summary(depth)
summary(avg_wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt1$flag_wtemp))
detach(dt1)               
         

inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/121/11/21ee275e60ce9f205a03a2e5cf55e135" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")

                   
 dt2 <-read.csv(infile2,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "year4",     
                    "month",     
                    "daynum",     
                    "hour",     
                    "depth",     
                    "avg_wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile2)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                                                   
# attempting to convert dt2$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp2sampledate<-as.Date(dt2$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp2sampledate) == length(tmp2sampledate[!is.na(tmp2sampledate)])){dt2$sampledate <- tmp2sampledate } else {print("Date conversion failed for dt2$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp2sampledate) 
if (class(dt2$year4)=="factor") dt2$year4 <-as.numeric(levels(dt2$year4))[as.integer(dt2$year4) ]               
if (class(dt2$year4)=="character") dt2$year4 <-as.numeric(dt2$year4)
if (class(dt2$month)=="factor") dt2$month <-as.numeric(levels(dt2$month))[as.integer(dt2$month) ]               
if (class(dt2$month)=="character") dt2$month <-as.numeric(dt2$month)
if (class(dt2$daynum)=="factor") dt2$daynum <-as.numeric(levels(dt2$daynum))[as.integer(dt2$daynum) ]               
if (class(dt2$daynum)=="character") dt2$daynum <-as.numeric(dt2$daynum)
if (class(dt2$depth)=="factor") dt2$depth <-as.numeric(levels(dt2$depth))[as.integer(dt2$depth) ]               
if (class(dt2$depth)=="character") dt2$depth <-as.numeric(dt2$depth)
if (class(dt2$avg_wtemp)=="factor") dt2$avg_wtemp <-as.numeric(levels(dt2$avg_wtemp))[as.integer(dt2$avg_wtemp) ]               
if (class(dt2$avg_wtemp)=="character") dt2$avg_wtemp <-as.numeric(dt2$avg_wtemp)
if (class(dt2$flag_wtemp)!="factor") dt2$flag_wtemp<- as.factor(dt2$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt2)                            
attach(dt2)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(year4)
summary(month)
summary(daynum)
summary(hour)
summary(depth)
summary(avg_wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt2$flag_wtemp))
detach(dt2)               
         

inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/121/11/3a68e167ef08cfe6f18286b0082c7544" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")

                   
 dt3 <-read.csv(infile3,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "year4",     
                    "month",     
                    "daynum",     
                    "sample_time",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp",     
                    "data_freq"    ), check.names=TRUE)
               
unlink(infile3)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                                                   
# attempting to convert dt3$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp3sampledate<-as.Date(dt3$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3sampledate) == length(tmp3sampledate[!is.na(tmp3sampledate)])){dt3$sampledate <- tmp3sampledate } else {print("Date conversion failed for dt3$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp3sampledate) 
if (class(dt3$year4)=="factor") dt3$year4 <-as.numeric(levels(dt3$year4))[as.integer(dt3$year4) ]               
if (class(dt3$year4)=="character") dt3$year4 <-as.numeric(dt3$year4)
if (class(dt3$month)=="factor") dt3$month <-as.numeric(levels(dt3$month))[as.integer(dt3$month) ]               
if (class(dt3$month)=="character") dt3$month <-as.numeric(dt3$month)
if (class(dt3$daynum)=="factor") dt3$daynum <-as.numeric(levels(dt3$daynum))[as.integer(dt3$daynum) ]               
if (class(dt3$daynum)=="character") dt3$daynum <-as.numeric(dt3$daynum)
if (class(dt3$depth)=="factor") dt3$depth <-as.numeric(levels(dt3$depth))[as.integer(dt3$depth) ]               
if (class(dt3$depth)=="character") dt3$depth <-as.numeric(dt3$depth)
if (class(dt3$wtemp)=="factor") dt3$wtemp <-as.numeric(levels(dt3$wtemp))[as.integer(dt3$wtemp) ]               
if (class(dt3$wtemp)=="character") dt3$wtemp <-as.numeric(dt3$wtemp)
if (class(dt3$flag_wtemp)!="factor") dt3$flag_wtemp<- as.factor(dt3$flag_wtemp)
if (class(dt3$data_freq)=="factor") dt3$data_freq <-as.numeric(levels(dt3$data_freq))[as.integer(dt3$data_freq) ]               
if (class(dt3$data_freq)=="character") dt3$data_freq <-as.numeric(dt3$data_freq)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt3)                            
attach(dt3)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(year4)
summary(month)
summary(daynum)
summary(sample_time)
summary(depth)
summary(wtemp)
summary(flag_wtemp)
summary(data_freq) 
                # Get more details on character variables
                 
summary(as.factor(dt3$flag_wtemp))
detach(dt3)               
        




