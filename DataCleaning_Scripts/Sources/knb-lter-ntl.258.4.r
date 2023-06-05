# Package ID: knb-lter-ntl.258.4 Cataloging System:https://pasta.edirepository.org.
# Data set title: Lake Mendota Phosphorus Entrainment at North Temperate Lakes LTER 2005.
# Data set creator:  Amy Kamarainen - NTL LTER 
# Data set creator:  Stephen Carpenter - University of Wisconsin 
# Data set creator:  Chin Wu - University of Wisconsin 
# Data set creator:  Hengliang Yuan - NTL LTER 
# Metadata Provider:    - North Temperate Lakes LTER 
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/8548f0911f194b0950900dd75242a69a" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

                   
 dt1 <-read.csv(infile1,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile1)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt1$buoyid)!="factor") dt1$buoyid<- as.factor(dt1$buoyid)                                   
# attempting to convert dt1$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp1sampledate<-as.Date(dt1$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sampledate) == length(tmp1sampledate[!is.na(tmp1sampledate)])){dt1$sampledate <- tmp1sampledate } else {print("Date conversion failed for dt1$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1sampledate) 
if (class(dt1$depth)=="factor") dt1$depth <-as.numeric(levels(dt1$depth))[as.integer(dt1$depth) ]               
if (class(dt1$depth)=="character") dt1$depth <-as.numeric(dt1$depth)
if (class(dt1$wtemp)=="factor") dt1$wtemp <-as.numeric(levels(dt1$wtemp))[as.integer(dt1$wtemp) ]               
if (class(dt1$wtemp)=="character") dt1$wtemp <-as.numeric(dt1$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt1$buoyid))
detach(dt1)               
         

inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/f9040d326e7c3b39ea041f4402409f36" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")

                   
 dt2 <-read.csv(infile2,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile2)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt2$buoyid)!="factor") dt2$buoyid<- as.factor(dt2$buoyid)                                   
# attempting to convert dt2$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp2sampledate<-as.Date(dt2$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp2sampledate) == length(tmp2sampledate[!is.na(tmp2sampledate)])){dt2$sampledate <- tmp2sampledate } else {print("Date conversion failed for dt2$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp2sampledate) 
if (class(dt2$depth)=="factor") dt2$depth <-as.numeric(levels(dt2$depth))[as.integer(dt2$depth) ]               
if (class(dt2$depth)=="character") dt2$depth <-as.numeric(dt2$depth)
if (class(dt2$wtemp)=="factor") dt2$wtemp <-as.numeric(levels(dt2$wtemp))[as.integer(dt2$wtemp) ]               
if (class(dt2$wtemp)=="character") dt2$wtemp <-as.numeric(dt2$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt2)                            
attach(dt2)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt2$buoyid))
detach(dt2)               
         

inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/c94c990105890fb608fa458d544e218b" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")

                   
 dt3 <-read.csv(infile3,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile3)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt3$buoyid)!="factor") dt3$buoyid<- as.factor(dt3$buoyid)                                   
# attempting to convert dt3$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp3sampledate<-as.Date(dt3$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3sampledate) == length(tmp3sampledate[!is.na(tmp3sampledate)])){dt3$sampledate <- tmp3sampledate } else {print("Date conversion failed for dt3$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp3sampledate) 
if (class(dt3$depth)=="factor") dt3$depth <-as.numeric(levels(dt3$depth))[as.integer(dt3$depth) ]               
if (class(dt3$depth)=="character") dt3$depth <-as.numeric(dt3$depth)
if (class(dt3$wtemp)=="factor") dt3$wtemp <-as.numeric(levels(dt3$wtemp))[as.integer(dt3$wtemp) ]               
if (class(dt3$wtemp)=="character") dt3$wtemp <-as.numeric(dt3$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt3)                            
attach(dt3)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt3$buoyid))
detach(dt3)               
         

inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/0960ff9138e0cc28f64d19306634fc40" 
infile4 <- tempfile()
try(download.file(inUrl4,infile4,method="curl"))
if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")

                   
 dt4 <-read.csv(infile4,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile4)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt4$buoyid)!="factor") dt4$buoyid<- as.factor(dt4$buoyid)                                   
# attempting to convert dt4$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp4sampledate<-as.Date(dt4$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp4sampledate) == length(tmp4sampledate[!is.na(tmp4sampledate)])){dt4$sampledate <- tmp4sampledate } else {print("Date conversion failed for dt4$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp4sampledate) 
if (class(dt4$depth)=="factor") dt4$depth <-as.numeric(levels(dt4$depth))[as.integer(dt4$depth) ]               
if (class(dt4$depth)=="character") dt4$depth <-as.numeric(dt4$depth)
if (class(dt4$wtemp)=="factor") dt4$wtemp <-as.numeric(levels(dt4$wtemp))[as.integer(dt4$wtemp) ]               
if (class(dt4$wtemp)=="character") dt4$wtemp <-as.numeric(dt4$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt4)                            
attach(dt4)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt4$buoyid))
detach(dt4)               
         

inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/362bd5dc3aade44bc9ee80703e8bb1d1" 
infile5 <- tempfile()
try(download.file(inUrl5,infile5,method="curl"))
if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")

                   
 dt5 <-read.csv(infile5,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile5)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt5$buoyid)!="factor") dt5$buoyid<- as.factor(dt5$buoyid)                                   
# attempting to convert dt5$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp5sampledate<-as.Date(dt5$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp5sampledate) == length(tmp5sampledate[!is.na(tmp5sampledate)])){dt5$sampledate <- tmp5sampledate } else {print("Date conversion failed for dt5$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp5sampledate) 
if (class(dt5$depth)=="factor") dt5$depth <-as.numeric(levels(dt5$depth))[as.integer(dt5$depth) ]               
if (class(dt5$depth)=="character") dt5$depth <-as.numeric(dt5$depth)
if (class(dt5$wtemp)=="factor") dt5$wtemp <-as.numeric(levels(dt5$wtemp))[as.integer(dt5$wtemp) ]               
if (class(dt5$wtemp)=="character") dt5$wtemp <-as.numeric(dt5$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt5)                            
attach(dt5)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt5$buoyid))
detach(dt5)               
         

inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/3fcb82b4c05211523c5a11b475a1923e" 
infile6 <- tempfile()
try(download.file(inUrl6,infile6,method="curl"))
if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")

                   
 dt6 <-read.csv(infile6,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile6)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt6$buoyid)!="factor") dt6$buoyid<- as.factor(dt6$buoyid)                                   
# attempting to convert dt6$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp6sampledate<-as.Date(dt6$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp6sampledate) == length(tmp6sampledate[!is.na(tmp6sampledate)])){dt6$sampledate <- tmp6sampledate } else {print("Date conversion failed for dt6$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp6sampledate) 
if (class(dt6$depth)=="factor") dt6$depth <-as.numeric(levels(dt6$depth))[as.integer(dt6$depth) ]               
if (class(dt6$depth)=="character") dt6$depth <-as.numeric(dt6$depth)
if (class(dt6$wtemp)=="factor") dt6$wtemp <-as.numeric(levels(dt6$wtemp))[as.integer(dt6$wtemp) ]               
if (class(dt6$wtemp)=="character") dt6$wtemp <-as.numeric(dt6$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt6)                            
attach(dt6)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt6$buoyid))
detach(dt6)               
         

inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/1cb5c5154d15e71bfc5abc1914b563d0" 
infile7 <- tempfile()
try(download.file(inUrl7,infile7,method="curl"))
if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")

                   
 dt7 <-read.csv(infile7,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile7)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt7$buoyid)!="factor") dt7$buoyid<- as.factor(dt7$buoyid)                                   
# attempting to convert dt7$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp7sampledate<-as.Date(dt7$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp7sampledate) == length(tmp7sampledate[!is.na(tmp7sampledate)])){dt7$sampledate <- tmp7sampledate } else {print("Date conversion failed for dt7$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp7sampledate) 
if (class(dt7$depth)=="factor") dt7$depth <-as.numeric(levels(dt7$depth))[as.integer(dt7$depth) ]               
if (class(dt7$depth)=="character") dt7$depth <-as.numeric(dt7$depth)
if (class(dt7$wtemp)=="factor") dt7$wtemp <-as.numeric(levels(dt7$wtemp))[as.integer(dt7$wtemp) ]               
if (class(dt7$wtemp)=="character") dt7$wtemp <-as.numeric(dt7$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt7)                            
attach(dt7)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt7$buoyid))
detach(dt7)               
         

inUrl8  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/c352f4a5f20dad54761ecd6413df6f55" 
infile8 <- tempfile()
try(download.file(inUrl8,infile8,method="curl"))
if (is.na(file.size(infile8))) download.file(inUrl8,infile8,method="auto")

                   
 dt8 <-read.csv(infile8,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile8)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt8$buoyid)!="factor") dt8$buoyid<- as.factor(dt8$buoyid)                                   
# attempting to convert dt8$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp8sampledate<-as.Date(dt8$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp8sampledate) == length(tmp8sampledate[!is.na(tmp8sampledate)])){dt8$sampledate <- tmp8sampledate } else {print("Date conversion failed for dt8$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp8sampledate) 
if (class(dt8$depth)=="factor") dt8$depth <-as.numeric(levels(dt8$depth))[as.integer(dt8$depth) ]               
if (class(dt8$depth)=="character") dt8$depth <-as.numeric(dt8$depth)
if (class(dt8$wtemp)=="factor") dt8$wtemp <-as.numeric(levels(dt8$wtemp))[as.integer(dt8$wtemp) ]               
if (class(dt8$wtemp)=="character") dt8$wtemp <-as.numeric(dt8$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt8)                            
attach(dt8)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt8$buoyid))
detach(dt8)               
         

inUrl9  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/e273dd9c7c93a538823a52d6dd236076" 
infile9 <- tempfile()
try(download.file(inUrl9,infile9,method="curl"))
if (is.na(file.size(infile9))) download.file(inUrl9,infile9,method="auto")

                   
 dt9 <-read.csv(infile9,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile9)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt9$buoyid)!="factor") dt9$buoyid<- as.factor(dt9$buoyid)                                   
# attempting to convert dt9$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp9sampledate<-as.Date(dt9$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp9sampledate) == length(tmp9sampledate[!is.na(tmp9sampledate)])){dt9$sampledate <- tmp9sampledate } else {print("Date conversion failed for dt9$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp9sampledate) 
if (class(dt9$depth)=="factor") dt9$depth <-as.numeric(levels(dt9$depth))[as.integer(dt9$depth) ]               
if (class(dt9$depth)=="character") dt9$depth <-as.numeric(dt9$depth)
if (class(dt9$wtemp)=="factor") dt9$wtemp <-as.numeric(levels(dt9$wtemp))[as.integer(dt9$wtemp) ]               
if (class(dt9$wtemp)=="character") dt9$wtemp <-as.numeric(dt9$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt9)                            
attach(dt9)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt9$buoyid))
detach(dt9)               
         

inUrl10  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/432c317f5aec3aea51e8d182c12e17d1" 
infile10 <- tempfile()
try(download.file(inUrl10,infile10,method="curl"))
if (is.na(file.size(infile10))) download.file(inUrl10,infile10,method="auto")

                   
 dt10 <-read.csv(infile10,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile10)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt10$buoyid)!="factor") dt10$buoyid<- as.factor(dt10$buoyid)                                   
# attempting to convert dt10$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp10sampledate<-as.Date(dt10$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp10sampledate) == length(tmp10sampledate[!is.na(tmp10sampledate)])){dt10$sampledate <- tmp10sampledate } else {print("Date conversion failed for dt10$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp10sampledate) 
if (class(dt10$depth)=="factor") dt10$depth <-as.numeric(levels(dt10$depth))[as.integer(dt10$depth) ]               
if (class(dt10$depth)=="character") dt10$depth <-as.numeric(dt10$depth)
if (class(dt10$wtemp)=="factor") dt10$wtemp <-as.numeric(levels(dt10$wtemp))[as.integer(dt10$wtemp) ]               
if (class(dt10$wtemp)=="character") dt10$wtemp <-as.numeric(dt10$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt10)                            
attach(dt10)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt10$buoyid))
detach(dt10)               
         

inUrl11  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/3a0b2937c3cf4e4de11dda6d09c64162" 
infile11 <- tempfile()
try(download.file(inUrl11,infile11,method="curl"))
if (is.na(file.size(infile11))) download.file(inUrl11,infile11,method="auto")

                   
 dt11 <-read.csv(infile11,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile11)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt11$buoyid)!="factor") dt11$buoyid<- as.factor(dt11$buoyid)                                   
# attempting to convert dt11$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp11sampledate<-as.Date(dt11$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp11sampledate) == length(tmp11sampledate[!is.na(tmp11sampledate)])){dt11$sampledate <- tmp11sampledate } else {print("Date conversion failed for dt11$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp11sampledate) 
if (class(dt11$depth)=="factor") dt11$depth <-as.numeric(levels(dt11$depth))[as.integer(dt11$depth) ]               
if (class(dt11$depth)=="character") dt11$depth <-as.numeric(dt11$depth)
if (class(dt11$wtemp)=="factor") dt11$wtemp <-as.numeric(levels(dt11$wtemp))[as.integer(dt11$wtemp) ]               
if (class(dt11$wtemp)=="character") dt11$wtemp <-as.numeric(dt11$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt11)                            
attach(dt11)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt11$buoyid))
detach(dt11)               
         

inUrl12  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/b1cbc8c354368b76ac22ccbaab245f62" 
infile12 <- tempfile()
try(download.file(inUrl12,infile12,method="curl"))
if (is.na(file.size(infile12))) download.file(inUrl12,infile12,method="auto")

                   
 dt12 <-read.csv(infile12,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile12)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt12$buoyid)!="factor") dt12$buoyid<- as.factor(dt12$buoyid)                                   
# attempting to convert dt12$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp12sampledate<-as.Date(dt12$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp12sampledate) == length(tmp12sampledate[!is.na(tmp12sampledate)])){dt12$sampledate <- tmp12sampledate } else {print("Date conversion failed for dt12$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp12sampledate) 
if (class(dt12$depth)=="factor") dt12$depth <-as.numeric(levels(dt12$depth))[as.integer(dt12$depth) ]               
if (class(dt12$depth)=="character") dt12$depth <-as.numeric(dt12$depth)
if (class(dt12$wtemp)=="factor") dt12$wtemp <-as.numeric(levels(dt12$wtemp))[as.integer(dt12$wtemp) ]               
if (class(dt12$wtemp)=="character") dt12$wtemp <-as.numeric(dt12$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt12)                            
attach(dt12)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt12$buoyid))
detach(dt12)               
         

inUrl13  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/48e04bf426b50e91b34da946a6d3ee16" 
infile13 <- tempfile()
try(download.file(inUrl13,infile13,method="curl"))
if (is.na(file.size(infile13))) download.file(inUrl13,infile13,method="auto")

                   
 dt13 <-read.csv(infile13,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "sample_time",     
                    "depth",     
                    "wtemp"    ), check.names=TRUE)
               
unlink(infile13)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt13$buoyid)!="factor") dt13$buoyid<- as.factor(dt13$buoyid)                                   
# attempting to convert dt13$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp13sampledate<-as.Date(dt13$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp13sampledate) == length(tmp13sampledate[!is.na(tmp13sampledate)])){dt13$sampledate <- tmp13sampledate } else {print("Date conversion failed for dt13$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp13sampledate) 
if (class(dt13$depth)=="factor") dt13$depth <-as.numeric(levels(dt13$depth))[as.integer(dt13$depth) ]               
if (class(dt13$depth)=="character") dt13$depth <-as.numeric(dt13$depth)
if (class(dt13$wtemp)=="factor") dt13$wtemp <-as.numeric(levels(dt13$wtemp))[as.integer(dt13$wtemp) ]               
if (class(dt13$wtemp)=="character") dt13$wtemp <-as.numeric(dt13$wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt13)                            
attach(dt13)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(sample_time)
summary(depth)
summary(wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt13$buoyid))
detach(dt13)               
         

inUrl14  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/8d4ffbed1c311d4de7ff50fc07f944a2" 
infile14 <- tempfile()
try(download.file(inUrl14,infile14,method="curl"))
if (is.na(file.size(infile14))) download.file(inUrl14,infile14,method="auto")

                   
 dt14 <-read.csv(infile14,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "depth",     
                    "rep",     
                    "tp"    ), check.names=TRUE)
               
unlink(infile14)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt14$buoyid)!="factor") dt14$buoyid<- as.factor(dt14$buoyid)                                   
# attempting to convert dt14$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp14sampledate<-as.Date(dt14$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp14sampledate) == length(tmp14sampledate[!is.na(tmp14sampledate)])){dt14$sampledate <- tmp14sampledate } else {print("Date conversion failed for dt14$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp14sampledate) 
if (class(dt14$depth)=="factor") dt14$depth <-as.numeric(levels(dt14$depth))[as.integer(dt14$depth) ]               
if (class(dt14$depth)=="character") dt14$depth <-as.numeric(dt14$depth)
if (class(dt14$rep)!="factor") dt14$rep<- as.factor(dt14$rep)
if (class(dt14$tp)=="factor") dt14$tp <-as.numeric(levels(dt14$tp))[as.integer(dt14$tp) ]               
if (class(dt14$tp)=="character") dt14$tp <-as.numeric(dt14$tp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt14)                            
attach(dt14)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(depth)
summary(rep)
summary(tp) 
                # Get more details on character variables
                 
summary(as.factor(dt14$buoyid)) 
summary(as.factor(dt14$rep))
detach(dt14)               
         

inUrl15  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/486ad40bb6db8710133cca007f9e4ce4" 
infile15 <- tempfile()
try(download.file(inUrl15,infile15,method="curl"))
if (is.na(file.size(infile15))) download.file(inUrl15,infile15,method="auto")

                   
 dt15 <-read.csv(infile15,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "sampledate",     
                    "depth",     
                    "rep",     
                    "srp"    ), check.names=TRUE)
               
unlink(infile15)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt15$buoyid)!="factor") dt15$buoyid<- as.factor(dt15$buoyid)                                   
# attempting to convert dt15$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp15sampledate<-as.Date(dt15$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp15sampledate) == length(tmp15sampledate[!is.na(tmp15sampledate)])){dt15$sampledate <- tmp15sampledate } else {print("Date conversion failed for dt15$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp15sampledate) 
if (class(dt15$depth)=="factor") dt15$depth <-as.numeric(levels(dt15$depth))[as.integer(dt15$depth) ]               
if (class(dt15$depth)=="character") dt15$depth <-as.numeric(dt15$depth)
if (class(dt15$rep)!="factor") dt15$rep<- as.factor(dt15$rep)
if (class(dt15$srp)=="factor") dt15$srp <-as.numeric(levels(dt15$srp))[as.integer(dt15$srp) ]               
if (class(dt15$srp)=="character") dt15$srp <-as.numeric(dt15$srp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt15)                            
attach(dt15)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(sampledate)
summary(depth)
summary(rep)
summary(srp) 
                # Get more details on character variables
                 
summary(as.factor(dt15$buoyid)) 
summary(as.factor(dt15$rep))
detach(dt15)               
         

inUrl16  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/258/4/38c3f0c32c2a5049a3b2ad1fd68820e1" 
infile16 <- tempfile()
try(download.file(inUrl16,infile16,method="curl"))
if (is.na(file.size(infile16))) download.file(inUrl16,infile16,method="auto")

                   
 dt16 <-read.csv(infile16,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "buoyid",     
                    "latitude",     
                    "longitude"    ), check.names=TRUE)
               
unlink(infile16)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt16$buoyid)!="factor") dt16$buoyid<- as.factor(dt16$buoyid)
if (class(dt16$latitude)=="factor") dt16$latitude <-as.numeric(levels(dt16$latitude))[as.integer(dt16$latitude) ]               
if (class(dt16$latitude)=="character") dt16$latitude <-as.numeric(dt16$latitude)
if (class(dt16$longitude)=="factor") dt16$longitude <-as.numeric(levels(dt16$longitude))[as.integer(dt16$longitude) ]               
if (class(dt16$longitude)=="character") dt16$longitude <-as.numeric(dt16$longitude)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt16)                            
attach(dt16)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(buoyid)
summary(latitude)
summary(longitude) 
                # Get more details on character variables
                 
summary(as.factor(dt16$buoyid))
detach(dt16)               
        




