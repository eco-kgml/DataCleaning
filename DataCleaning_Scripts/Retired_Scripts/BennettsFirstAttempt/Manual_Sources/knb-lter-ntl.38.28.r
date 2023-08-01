# Package ID: knb-lter-ntl.38.28 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: Chlorophyll - Madison Lakes Area 1995 - current.
# Data set creator:  John Magnuson - University of Wisconsin 
# Data set creator:  Stephen Carpenter - University of Wisconsin 
# Data set creator:  Emily Stanley - University of Wisconsin 
# Metadata Provider:  NTL Information Manager - University of Wisconsin 
# Contact:    -  NTL LTER  - ntl.infomgr@gmail.com
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/38/28/66796c3bc77617e7cc95c4b09d4995c5" 
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
                    "sampledate",     
                    "depth_range_m",     
                    "rep",     
                    "tri_chl_spec",     
                    "mono_chl_spec",     
                    "phaeo_spec",     
                    "uncorrect_chl_fluor",     
                    "correct_chl_fluor",     
                    "phaeo_fluor",     
                    "flag_spec",     
                    "flag_fluor"    ), check.names=TRUE)
               
unlink(infile1)
		    
# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
                
if (class(dt1$lakeid)!="factor") dt1$lakeid<- as.factor(dt1$lakeid)
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]               
if (class(dt1$year4)=="character") dt1$year4 <-as.numeric(dt1$year4)                                   
# attempting to convert dt1$sampledate dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp1sampledate<-as.Date(dt1$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sampledate) == length(tmp1sampledate[!is.na(tmp1sampledate)])){dt1$sampledate <- tmp1sampledate } else {print("Date conversion failed for dt1$sampledate. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1sampledate) 
if (class(dt1$depth_range_m)!="factor") dt1$depth_range_m<- as.factor(dt1$depth_range_m)
if (class(dt1$rep)!="factor") dt1$rep<- as.factor(dt1$rep)
if (class(dt1$tri_chl_spec)=="factor") dt1$tri_chl_spec <-as.numeric(levels(dt1$tri_chl_spec))[as.integer(dt1$tri_chl_spec) ]               
if (class(dt1$tri_chl_spec)=="character") dt1$tri_chl_spec <-as.numeric(dt1$tri_chl_spec)
if (class(dt1$mono_chl_spec)=="factor") dt1$mono_chl_spec <-as.numeric(levels(dt1$mono_chl_spec))[as.integer(dt1$mono_chl_spec) ]               
if (class(dt1$mono_chl_spec)=="character") dt1$mono_chl_spec <-as.numeric(dt1$mono_chl_spec)
if (class(dt1$phaeo_spec)=="factor") dt1$phaeo_spec <-as.numeric(levels(dt1$phaeo_spec))[as.integer(dt1$phaeo_spec) ]               
if (class(dt1$phaeo_spec)=="character") dt1$phaeo_spec <-as.numeric(dt1$phaeo_spec)
if (class(dt1$uncorrect_chl_fluor)=="factor") dt1$uncorrect_chl_fluor <-as.numeric(levels(dt1$uncorrect_chl_fluor))[as.integer(dt1$uncorrect_chl_fluor) ]               
if (class(dt1$uncorrect_chl_fluor)=="character") dt1$uncorrect_chl_fluor <-as.numeric(dt1$uncorrect_chl_fluor)
if (class(dt1$correct_chl_fluor)=="factor") dt1$correct_chl_fluor <-as.numeric(levels(dt1$correct_chl_fluor))[as.integer(dt1$correct_chl_fluor) ]               
if (class(dt1$correct_chl_fluor)=="character") dt1$correct_chl_fluor <-as.numeric(dt1$correct_chl_fluor)
if (class(dt1$phaeo_fluor)=="factor") dt1$phaeo_fluor <-as.numeric(levels(dt1$phaeo_fluor))[as.integer(dt1$phaeo_fluor) ]               
if (class(dt1$phaeo_fluor)=="character") dt1$phaeo_fluor <-as.numeric(dt1$phaeo_fluor)
if (class(dt1$flag_spec)!="factor") dt1$flag_spec<- as.factor(dt1$flag_spec)
if (class(dt1$flag_fluor)!="factor") dt1$flag_fluor<- as.factor(dt1$flag_fluor)
                
# Convert Missing Values to NA for non-dates
                


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(lakeid)
summary(year4)
summary(sampledate)
summary(depth_range_m)
summary(rep)
summary(tri_chl_spec)
summary(mono_chl_spec)
summary(phaeo_spec)
summary(uncorrect_chl_fluor)
summary(correct_chl_fluor)
summary(phaeo_fluor)
summary(flag_spec)
summary(flag_fluor) 
                # Get more details on character variables
                 
summary(as.factor(dt1$lakeid)) 
summary(as.factor(dt1$depth_range_m)) 
summary(as.factor(dt1$rep)) 
summary(as.factor(dt1$flag_spec)) 
summary(as.factor(dt1$flag_fluor))
detach(dt1)               
        




