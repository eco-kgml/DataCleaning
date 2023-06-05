# Package ID: knb-lter-ntl.35.31 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: Chlorophyll - Trout Lake Area 1981 - current.
# Data set creator:  John Magnuson - University of Wisconsin 
# Data set creator:  Stephen Carpenter - University of Wisconsin 
# Data set creator:  Emily Stanley - University of Wisconsin 
# Metadata Provider:  NTL Information Manager - University of Wisconsin 
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/35/31/a38bab3c7d90f4c24f3f603d7fac8c2e" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

                   
 dt1 <-read.csv(infile1,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "lakeid",     
                    "year4",     
                    "daynum",     
                    "sampledate",     
                    "rep",     
                    "sta",     
                    "depth",     
                    "chlor",     
                    "phaeo",     
                    "flagchlor",     
                    "flagphaeo"    ), check.names=TRUE)
               
unlink(infile1)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt1$lakeid)!="factor") dt1$lakeid<- as.factor(dt1$lakeid)
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]               
if (class(dt1$year4)=="character") dt1$year4 <-as.numeric(dt1$year4)
if (class(dt1$daynum)=="factor") dt1$daynum <-as.numeric(levels(dt1$daynum))[as.integer(dt1$daynum) ]               
if (class(dt1$daynum)=="character") dt1$daynum <-as.numeric(dt1$daynum)                                   
# attempting to convert dt1$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp1sampledate<-as.Date(dt1$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sampledate) == length(tmp1sampledate[!is.na(tmp1sampledate)])){dt1$sampledate <- tmp1sampledate } else {print("Date conversion failed for dt1$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1sampledate) 
if (class(dt1$rep)!="factor") dt1$rep<- as.factor(dt1$rep)
if (class(dt1$sta)!="factor") dt1$sta<- as.factor(dt1$sta)
if (class(dt1$depth)=="factor") dt1$depth <-as.numeric(levels(dt1$depth))[as.integer(dt1$depth) ]               
if (class(dt1$depth)=="character") dt1$depth <-as.numeric(dt1$depth)
if (class(dt1$chlor)=="factor") dt1$chlor <-as.numeric(levels(dt1$chlor))[as.integer(dt1$chlor) ]               
if (class(dt1$chlor)=="character") dt1$chlor <-as.numeric(dt1$chlor)
if (class(dt1$phaeo)=="factor") dt1$phaeo <-as.numeric(levels(dt1$phaeo))[as.integer(dt1$phaeo) ]               
if (class(dt1$phaeo)=="character") dt1$phaeo <-as.numeric(dt1$phaeo)
if (class(dt1$flagchlor)!="factor") dt1$flagchlor<- as.factor(dt1$flagchlor)
if (class(dt1$flagphaeo)!="factor") dt1$flagphaeo<- as.factor(dt1$flagphaeo)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(lakeid)
summary(year4)
summary(daynum)
summary(sampledate)
summary(rep)
summary(sta)
summary(depth)
summary(chlor)
summary(phaeo)
summary(flagchlor)
summary(flagphaeo) 
                # Get more details on character variables
                 
summary(as.factor(dt1$lakeid)) 
summary(as.factor(dt1$rep)) 
summary(as.factor(dt1$sta)) 
summary(as.factor(dt1$flagchlor)) 
summary(as.factor(dt1$flagphaeo))
detach(dt1)               
        




