# Package ID: knb-lter-ntl.130.30 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: High Frequency Water Temperature Data - Lake  Mendota Buoy 2006 - current.
# Data set creator:  John Magnuson - University of Wisconsin 
# Data set creator:  Stephen Carpenter - University of Wisconsin 
# Data set creator:  Emily Stanley - University of Wisconsin 
# Metadata Provider:  NTL Information Manager - University of Wisconsin 
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/a5919fc36f07fcf99765f084d18f5174" 
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
                    "wtemp",     
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
if (class(dt1$wtemp)=="factor") dt1$wtemp <-as.numeric(levels(dt1$wtemp))[as.integer(dt1$wtemp) ]               
if (class(dt1$wtemp)=="character") dt1$wtemp <-as.numeric(dt1$wtemp)
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
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt1$flag_wtemp))
detach(dt1)               
         

inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/63d0587cf326e83f57b054bf2ad0f7fe" 
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
                    "wtemp",     
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
if (class(dt2$wtemp)=="factor") dt2$wtemp <-as.numeric(levels(dt2$wtemp))[as.integer(dt2$wtemp) ]               
if (class(dt2$wtemp)=="character") dt2$wtemp <-as.numeric(dt2$wtemp)
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
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt2$flag_wtemp))
detach(dt2)               
         

inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/71831f38a4e590e6ec34d49b64b38313" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")

                   
 dt3 <-read.csv(infile3,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile3)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt3$depth)=="factor") dt3$depth <-as.numeric(levels(dt3$depth))[as.integer(dt3$depth) ]               
if (class(dt3$depth)=="character") dt3$depth <-as.numeric(dt3$depth)
if (class(dt3$wtemp)=="factor") dt3$wtemp <-as.numeric(levels(dt3$wtemp))[as.integer(dt3$wtemp) ]               
if (class(dt3$wtemp)=="character") dt3$wtemp <-as.numeric(dt3$wtemp)
if (class(dt3$flag_wtemp)!="factor") dt3$flag_wtemp<- as.factor(dt3$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt3)                            
attach(dt3)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt3$flag_wtemp))
detach(dt3)               
         

inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/91e2fc216c289b007503b31a0b46fb64" 
infile4 <- tempfile()
try(download.file(inUrl4,infile4,method="curl"))
if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")

                   
 dt4 <-read.csv(infile4,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile4)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt4$depth)=="factor") dt4$depth <-as.numeric(levels(dt4$depth))[as.integer(dt4$depth) ]               
if (class(dt4$depth)=="character") dt4$depth <-as.numeric(dt4$depth)
if (class(dt4$wtemp)=="factor") dt4$wtemp <-as.numeric(levels(dt4$wtemp))[as.integer(dt4$wtemp) ]               
if (class(dt4$wtemp)=="character") dt4$wtemp <-as.numeric(dt4$wtemp)
if (class(dt4$flag_wtemp)!="factor") dt4$flag_wtemp<- as.factor(dt4$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt4)                            
attach(dt4)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt4$flag_wtemp))
detach(dt4)               
         

inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/9739be632846ac2eaa7910278fa831b8" 
infile5 <- tempfile()
try(download.file(inUrl5,infile5,method="curl"))
if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")

                   
 dt5 <-read.csv(infile5,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile5)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt5$depth)=="factor") dt5$depth <-as.numeric(levels(dt5$depth))[as.integer(dt5$depth) ]               
if (class(dt5$depth)=="character") dt5$depth <-as.numeric(dt5$depth)
if (class(dt5$wtemp)=="factor") dt5$wtemp <-as.numeric(levels(dt5$wtemp))[as.integer(dt5$wtemp) ]               
if (class(dt5$wtemp)=="character") dt5$wtemp <-as.numeric(dt5$wtemp)
if (class(dt5$flag_wtemp)!="factor") dt5$flag_wtemp<- as.factor(dt5$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt5)                            
attach(dt5)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt5$flag_wtemp))
detach(dt5)               
         

inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/28d5e476384c8808e1999460093d96dc" 
infile6 <- tempfile()
try(download.file(inUrl6,infile6,method="curl"))
if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")

                   
 dt6 <-read.csv(infile6,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile6)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt6$depth)=="factor") dt6$depth <-as.numeric(levels(dt6$depth))[as.integer(dt6$depth) ]               
if (class(dt6$depth)=="character") dt6$depth <-as.numeric(dt6$depth)
if (class(dt6$wtemp)=="factor") dt6$wtemp <-as.numeric(levels(dt6$wtemp))[as.integer(dt6$wtemp) ]               
if (class(dt6$wtemp)=="character") dt6$wtemp <-as.numeric(dt6$wtemp)
if (class(dt6$flag_wtemp)!="factor") dt6$flag_wtemp<- as.factor(dt6$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt6)                            
attach(dt6)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt6$flag_wtemp))
detach(dt6)               
         

inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/3dbc4013a2e0d147bf8f098e90159c0c" 
infile7 <- tempfile()
try(download.file(inUrl7,infile7,method="curl"))
if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")

                   
 dt7 <-read.csv(infile7,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile7)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt7$depth)=="factor") dt7$depth <-as.numeric(levels(dt7$depth))[as.integer(dt7$depth) ]               
if (class(dt7$depth)=="character") dt7$depth <-as.numeric(dt7$depth)
if (class(dt7$wtemp)=="factor") dt7$wtemp <-as.numeric(levels(dt7$wtemp))[as.integer(dt7$wtemp) ]               
if (class(dt7$wtemp)=="character") dt7$wtemp <-as.numeric(dt7$wtemp)
if (class(dt7$flag_wtemp)!="factor") dt7$flag_wtemp<- as.factor(dt7$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt7)                            
attach(dt7)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt7$flag_wtemp))
detach(dt7)               
         

inUrl8  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/09dc2d104f729077978cb2d042019e84" 
infile8 <- tempfile()
try(download.file(inUrl8,infile8,method="curl"))
if (is.na(file.size(infile8))) download.file(inUrl8,infile8,method="auto")

                   
 dt8 <-read.csv(infile8,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile8)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt8$depth)=="factor") dt8$depth <-as.numeric(levels(dt8$depth))[as.integer(dt8$depth) ]               
if (class(dt8$depth)=="character") dt8$depth <-as.numeric(dt8$depth)
if (class(dt8$wtemp)=="factor") dt8$wtemp <-as.numeric(levels(dt8$wtemp))[as.integer(dt8$wtemp) ]               
if (class(dt8$wtemp)=="character") dt8$wtemp <-as.numeric(dt8$wtemp)
if (class(dt8$flag_wtemp)!="factor") dt8$flag_wtemp<- as.factor(dt8$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt8)                            
attach(dt8)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt8$flag_wtemp))
detach(dt8)               
         

inUrl9  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/fd68691b4dd9d51f42390e4e5855ca65" 
infile9 <- tempfile()
try(download.file(inUrl9,infile9,method="curl"))
if (is.na(file.size(infile9))) download.file(inUrl9,infile9,method="auto")

                   
 dt9 <-read.csv(infile9,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile9)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt9$depth)=="factor") dt9$depth <-as.numeric(levels(dt9$depth))[as.integer(dt9$depth) ]               
if (class(dt9$depth)=="character") dt9$depth <-as.numeric(dt9$depth)
if (class(dt9$wtemp)=="factor") dt9$wtemp <-as.numeric(levels(dt9$wtemp))[as.integer(dt9$wtemp) ]               
if (class(dt9$wtemp)=="character") dt9$wtemp <-as.numeric(dt9$wtemp)
if (class(dt9$flag_wtemp)!="factor") dt9$flag_wtemp<- as.factor(dt9$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt9)                            
attach(dt9)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt9$flag_wtemp))
detach(dt9)               
         

inUrl10  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/90948288600352ffed0129a9733906bb" 
infile10 <- tempfile()
try(download.file(inUrl10,infile10,method="curl"))
if (is.na(file.size(infile10))) download.file(inUrl10,infile10,method="auto")

                   
 dt10 <-read.csv(infile10,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile10)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt10$depth)=="factor") dt10$depth <-as.numeric(levels(dt10$depth))[as.integer(dt10$depth) ]               
if (class(dt10$depth)=="character") dt10$depth <-as.numeric(dt10$depth)
if (class(dt10$wtemp)=="factor") dt10$wtemp <-as.numeric(levels(dt10$wtemp))[as.integer(dt10$wtemp) ]               
if (class(dt10$wtemp)=="character") dt10$wtemp <-as.numeric(dt10$wtemp)
if (class(dt10$flag_wtemp)!="factor") dt10$flag_wtemp<- as.factor(dt10$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt10)                            
attach(dt10)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt10$flag_wtemp))
detach(dt10)               
         

inUrl11  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/5b9493e070b212bd30f7d85495ee7c22" 
infile11 <- tempfile()
try(download.file(inUrl11,infile11,method="curl"))
if (is.na(file.size(infile11))) download.file(inUrl11,infile11,method="auto")

                   
 dt11 <-read.csv(infile11,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile11)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt11$depth)=="factor") dt11$depth <-as.numeric(levels(dt11$depth))[as.integer(dt11$depth) ]               
if (class(dt11$depth)=="character") dt11$depth <-as.numeric(dt11$depth)
if (class(dt11$wtemp)=="factor") dt11$wtemp <-as.numeric(levels(dt11$wtemp))[as.integer(dt11$wtemp) ]               
if (class(dt11$wtemp)=="character") dt11$wtemp <-as.numeric(dt11$wtemp)
if (class(dt11$flag_wtemp)!="factor") dt11$flag_wtemp<- as.factor(dt11$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt11)                            
attach(dt11)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt11$flag_wtemp))
detach(dt11)               
         

inUrl12  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/c7538c460f8d0cbd90ec2892b8ce3025" 
infile12 <- tempfile()
try(download.file(inUrl12,infile12,method="curl"))
if (is.na(file.size(infile12))) download.file(inUrl12,infile12,method="auto")

                   
 dt12 <-read.csv(infile12,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile12)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt12$depth)=="factor") dt12$depth <-as.numeric(levels(dt12$depth))[as.integer(dt12$depth) ]               
if (class(dt12$depth)=="character") dt12$depth <-as.numeric(dt12$depth)
if (class(dt12$wtemp)=="factor") dt12$wtemp <-as.numeric(levels(dt12$wtemp))[as.integer(dt12$wtemp) ]               
if (class(dt12$wtemp)=="character") dt12$wtemp <-as.numeric(dt12$wtemp)
if (class(dt12$flag_wtemp)!="factor") dt12$flag_wtemp<- as.factor(dt12$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt12)                            
attach(dt12)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt12$flag_wtemp))
detach(dt12)               
         

inUrl13  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/c8d6f2eadf414c3e58f89f839c03df47" 
infile13 <- tempfile()
try(download.file(inUrl13,infile13,method="curl"))
if (is.na(file.size(infile13))) download.file(inUrl13,infile13,method="auto")

                   
 dt13 <-read.csv(infile13,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile13)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt13$depth)=="factor") dt13$depth <-as.numeric(levels(dt13$depth))[as.integer(dt13$depth) ]               
if (class(dt13$depth)=="character") dt13$depth <-as.numeric(dt13$depth)
if (class(dt13$wtemp)=="factor") dt13$wtemp <-as.numeric(levels(dt13$wtemp))[as.integer(dt13$wtemp) ]               
if (class(dt13$wtemp)=="character") dt13$wtemp <-as.numeric(dt13$wtemp)
if (class(dt13$flag_wtemp)!="factor") dt13$flag_wtemp<- as.factor(dt13$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt13)                            
attach(dt13)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt13$flag_wtemp))
detach(dt13)               
         

inUrl14  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/f0e3980071c6e4c28b89b2ad85a5dd27" 
infile14 <- tempfile()
try(download.file(inUrl14,infile14,method="curl"))
if (is.na(file.size(infile14))) download.file(inUrl14,infile14,method="auto")

                   
 dt14 <-read.csv(infile14,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile14)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt14$depth)=="factor") dt14$depth <-as.numeric(levels(dt14$depth))[as.integer(dt14$depth) ]               
if (class(dt14$depth)=="character") dt14$depth <-as.numeric(dt14$depth)
if (class(dt14$wtemp)=="factor") dt14$wtemp <-as.numeric(levels(dt14$wtemp))[as.integer(dt14$wtemp) ]               
if (class(dt14$wtemp)=="character") dt14$wtemp <-as.numeric(dt14$wtemp)
if (class(dt14$flag_wtemp)!="factor") dt14$flag_wtemp<- as.factor(dt14$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt14)                            
attach(dt14)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt14$flag_wtemp))
detach(dt14)               
         

inUrl15  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/e489b2c22108262efd8992c603a5a455" 
infile15 <- tempfile()
try(download.file(inUrl15,infile15,method="curl"))
if (is.na(file.size(infile15))) download.file(inUrl15,infile15,method="auto")

                   
 dt15 <-read.csv(infile15,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile15)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt15$depth)=="factor") dt15$depth <-as.numeric(levels(dt15$depth))[as.integer(dt15$depth) ]               
if (class(dt15$depth)=="character") dt15$depth <-as.numeric(dt15$depth)
if (class(dt15$wtemp)=="factor") dt15$wtemp <-as.numeric(levels(dt15$wtemp))[as.integer(dt15$wtemp) ]               
if (class(dt15$wtemp)=="character") dt15$wtemp <-as.numeric(dt15$wtemp)
if (class(dt15$flag_wtemp)!="factor") dt15$flag_wtemp<- as.factor(dt15$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt15)                            
attach(dt15)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt15$flag_wtemp))
detach(dt15)               
         

inUrl16  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/130/30/8356ed90a889b5d21956a41a1562d64e" 
infile16 <- tempfile()
try(download.file(inUrl16,infile16,method="curl"))
if (is.na(file.size(infile16))) download.file(inUrl16,infile16,method="auto")

                   
 dt16 <-read.csv(infile16,header=F 
          ,skip=1
            ,sep=","  
        , col.names=c(
                    "sampledate",     
                    "sampletime",     
                    "depth",     
                    "wtemp",     
                    "flag_wtemp"    ), check.names=TRUE)
               
unlink(infile16)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                                                   
# attempting to convert dt16$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp16sampledate<-as.Date(dt16$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp16sampledate) == length(tmp16sampledate[!is.na(tmp16sampledate)])){dt16$sampledate <- tmp16sampledate } else {print("Date conversion failed for dt16$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp16sampledate) 
if (class(dt16$depth)=="factor") dt16$depth <-as.numeric(levels(dt16$depth))[as.integer(dt16$depth) ]               
if (class(dt16$depth)=="character") dt16$depth <-as.numeric(dt16$depth)
if (class(dt16$wtemp)=="factor") dt16$wtemp <-as.numeric(levels(dt16$wtemp))[as.integer(dt16$wtemp) ]               
if (class(dt16$wtemp)=="character") dt16$wtemp <-as.numeric(dt16$wtemp)
if (class(dt16$flag_wtemp)!="factor") dt16$flag_wtemp<- as.factor(dt16$flag_wtemp)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt16)                            
attach(dt16)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(sampledate)
summary(sampletime)
summary(depth)
summary(wtemp)
summary(flag_wtemp) 
                # Get more details on character variables
                 
summary(as.factor(dt16$flag_wtemp))
detach(dt16)               
        




