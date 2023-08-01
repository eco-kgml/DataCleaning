# Package ID: knb-lter-ntl.390.3 Cataloging System:https://pasta.edirepository.org.
# Data set title: High Frequency Under-Ice Water Temperature Buoy Data - Crystal Bog, Trout Bog, and Lake Mendota, Wisconsin, USA 2016-2020.
# Data set creator:  Noah Lottig - Center for Limnology 
# Contact:  Noah Lottig -  Center for Limnology  - nrlottig@wisc.edu
# Contact:  Emily Stanley -  Center for Limnology  - ehstanley@wisc.edu
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/390/3/019ebce25b5d257110919ea1fb6936d6" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

                   
 dt1 <-read.csv(infile1,header=F 
          ,skip=1
            ,sep=","  
                ,quot='"' 
        , col.names=c(
                    "Sampledate",     
                    "lake",     
                    "depth_m",     
                    "temperature"    ), check.names=TRUE)
               
unlink(infile1)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                                                   
# attempting to convert dt1$Sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1Sampledate<-as.POSIXct(dt1$Sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1Sampledate) == length(tmp1Sampledate[!is.na(tmp1Sampledate)])){dt1$Sampledate <- tmp1Sampledate } else {print("Date conversion failed for dt1$Sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1Sampledate) 
if (class(dt1$lake)!="factor") dt1$lake<- as.factor(dt1$lake)
if (class(dt1$depth_m)=="factor") dt1$depth_m <-as.numeric(levels(dt1$depth_m))[as.integer(dt1$depth_m) ]               
if (class(dt1$depth_m)=="character") dt1$depth_m <-as.numeric(dt1$depth_m)
if (class(dt1$temperature)=="factor") dt1$temperature <-as.numeric(levels(dt1$temperature))[as.integer(dt1$temperature) ]               
if (class(dt1$temperature)=="character") dt1$temperature <-as.numeric(dt1$temperature)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(Sampledate)
summary(lake)
summary(depth_m)
summary(temperature) 
                # Get more details on character variables
                 
summary(as.factor(dt1$lake))
detach(dt1)               
        




