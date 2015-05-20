testtest<- read.csv(skip=1,file="http://cdec.water.ca.gov/cgi-progs/queryCSV?station_id=MHP&dur_code=H&sensor_num=18&start_date=2015/01/05&end_date=2015/01/12")

?read.csv()


mammoth_precip <- read.csv(file = "noaa_mammoth_precip.csv", header = TRUE) 
## converting snow (mm) to snow(in) by adding snow_in column
mammoth_precip$snow_in <-mammoth_precip$SNOW *0.0393701
## converting SNWD (mm) to SNWD(in) by adding snwd_in column
mammoth_precip$snwd_in <-mammoth_precip$SNWD *0.0393701
# Exploratory Analysis
View(mammoth_precip)
str(mammoth_precip)
levels(mammoth_precip$STATION_NAME)

# convert date to POSIXlt
mammoth_precip$DATE <- strptime(
  mammoth_precip$DATE 
  , "%Y%m%d"
)
# ALTERNATE convert to POSIXct using lubridate (not preferred)
library(lubridate)
mammoth_precip_filt$DATE <- ymd(mammoth_precip_filt$DATE)

# Create new table, filtered by NAs and only including relevant columns
mammoth_precip_filt <- subset(mammoth_precip,PRCP != -9999 & SNWD!= -9999 & SNOW != -9999,  select = c(STATION_NAME,DATE,PRCP,SNWD,SNOW,TMAX,TMIN,snow_in,snwd_in))
# Some Exploratory analysis on the filtered dataset 
summary(mammoth_precip_filt)
str(mammoth_precip_filt)
nrow(mammoth_precip)-nrow(mammoth_precip_filt)

# EXLORATORY: trying to create yearmonth column with some exploratory calls
class(mammoth_precip_filt$DATE)
mammoth_precip_filt$DATE[1]
unclass(mammoth_precip_filt$DATE[1])
mammoth_precip_filt$DATE[1][["year"]]
format(mammoth_precip_filt$DATE[1], "%Y")
mammoth_precip_filt$DATE[1][["mon"]]
unique(mammoth_precip_filt$DATE[["mon"]])

# EXEC: one way to create yearmonth - returns as character 
mammoth_precip_filt$yearmonth <- paste(format(mammoth_precip_filt$DATE, "%Y"),format(mammoth_precip_filt$DATE, "%m"),sep = "-")
# second way to create yearmonth - returns as character - formatting prefferable
mammoth_precip_filt$yearmonth <- format(mammoth_precip_filt$DATE, "%Y-%m")
class(mammoth_precip_filt$yearmonth)

# Plot Boxplot with temperature records by years and months (Stack Overflow)

## http://stackoverflow.com/questions/13232600/plot-boxplot-in-r-with-temperature-records-by-years-and-months

## Aggregating by Year/Month - method 1 - returns integers
mammoth_precip_filt.agg <- aggregate (snow_in ~ mammoth_precip_filt$DATE[["year"]] + mammoth_precip_filt$DATE[["mon"]], mammoth_precip_filt, FUN = mean )

# Just aggregated by year
mammoth_precip_filt.agg <- aggregate (SNWD ~ mammoth_precip_filt$DATE[["year"]], mammoth_precip_filt, FUN = mean )

## MEthod 2 returns characters - more desirable format
mammoth_precip_filt.agg <- aggregate (SNWD ~ format(mammoth_precip_filt$DATE, "%Y") + format(mammoth_precip_filt$DATE, "%m"), mammoth_precip_filt, FUN = mean )

## Exec: ULTIMATE - Using aggregate for multiple aggregations (SOF)
## ## http://stackoverflow.com/questions/12064202/using-aggregate-for-multiple-aggregations
mammoth_precip_filt2 <- subset(mammoth_precip,PRCP != -9999 & SNWD!= -9999 & SNOW != -9999,  select = c(DATE,SNWD,SNOW,TMAX,TMIN,snow_in,snwd_in))
test1 <- aggregate(. ~  format(mammoth_precip_filt$DATE, "%Y")+format(mammoth_precip_filt$DATE, "%m"),data = mammoth_precip_filt,FUN=function(x) c(mn = mean(x), n=length(x) ) )

### I think I can get rid of this -> library(plyr)
names(mammoth_precip_filt.agg)[1] <- "year"
names(mammoth_precip_filt.agg)[2] <- "month"
mammoth_precip_filt.agg$yearmon <- paste(mammoth_precip_filt.agg$year,mammoth_precip_filt.agg$month, "01",sep = "-")
?format()
mammoth_precip_filt.agg$yearmonth <- format(mammoth_precip_filt.agg$year,"%Y-%m", trim = FALSE)
#convert newly created yearmon field to POSTIXlt
mammoth_precip_filt.agg$yearmon <- strptime(
  mammoth_precip_filt.agg$yearmon
  , "%Y-%m-%d"
)

## Exploratory on new aggregation
str(mammoth_precip_filt.agg)
View(mammoth_precip_filt.agg)

## aggregate example from Stack Overflow

x <- as.POSIXct(c("2011-02-01", "2011-02-01", "2011-02-01"))
mo <- strftime(x, "%m")
yr <- strftime(x, "%Y")
amt <- runif(3)
dd <- data.frame(mo, yr, amt)
dd.agg <- aggregate(amt ~ mo + yr, dd, FUN = sum)
dd.agg$date <- as.POSIXct(paste(dd.agg$yr, dd.agg$mo, "01", sep = "-"))

## Visualization 
library(ggplot2)
p <- ggplot(mammoth_precip_filt.agg, aes(factor(month),snow_in))
p + geom_boxplot()
p + geom_boxplot() + geom_jitter()

## Scaping web weather data
snowdata1<-"http://patrol.mammothmountain.com/pages/StormSummary/04-05snowtable.txt"
View(read.table(file=snowdata1, skip=13, sep=" ", header=TRUE))
url.show(snowdata1)
?url.show()
?scan()
