library(dygraphs)
actions_graphs <- cbind(action_report$viewthrough,action_report$total_conversions)
dygraph(nhtemp)

action_report

plot(b, main="graph")
?plot()
plot(cars)
View(cars)

library(dygraphs)
data()
View(longley)

# subset action report to two x-y columns
b<-subset(action_report,action_name == "Ski.com - Retargeting Pixel" & campaign_name == "alien", select=c( total_conversions, conversion_day))
#convert newly created yearmon field to POSTIXlt
b$conversion_day <- strptime(
  b$conversion_day
  , "%Y-%m-%d"
)
class(as.xts(b$conversion_day[1]))
xtsible(b$conversion_day)
dygraph(b, main = "chart") 
dyRangeSelector()
?dygraph()
as.POSIXct(b$conversion_day)
b$conversion_day<-as.POSIXlt
unclass(as.POSIXct(b$conversion_day[1]))
b$conversion_day[1]
unclass()
class(nhtemp)
str(nhtemp)
head(nhtemp)
View(nhtemp)
nhtemp
library(dygraphs)
dygraph(nhtemp, main = "New Haven Temperatures") %>% 
  dyRangeSelector(dateWindow = c("1920-01-01", "1960-01-01"))

b$conversion_day <- as.ts(b$conversion_day)
class(as.xts(b$conversion_day[1]))
c<-xts(x = b[,-1], order.by=b$conversion_day)

library(xts)
sample.xts['2007']  # all of 2007
sample.xts['2007-03/']  # March 2007 to the end of the data set
View(ts(1:10, frequency = 4, start = c(1959, 2))) # 2nd Quarter of 1959

as.Date(b$conversion_day[1])
min(b$conversion_day)
b$conversion_day$year[1]
b$conversion_day[7]
max(b$conversion_day)
unclass(as.POSIXlt(b$conversion_day)[7])
as.POSIXct(b$conversion_day)[1]
max(b$conversion_day)-min(b$conversion_day)

ts_test<-ts(data=b$total_conversions, frequency=365, start=c(min(as.Date(b$conversion_day)),1), end=c(max(as.Date(b$conversion_day)))) 
class(ts_test)
?ts
View(gnp)
gnp <- ts(cumsum(1 + round(rnorm(100), 2)),
          start = c(1954, 7), frequency = 12)
plot(data) # using 'plot.ts' for time-series plot

data<-rnorm(3650, m=10, sd=2)
head(data)
data_ts<-as.ts(data, frequency=365, start=c(1919, 1))
data_ts <- ts(data, frequency=365, start=c(1919, 1))
attributes(data_ts)
dcomp<-decompose(data_ts, type=c("additive"))
data_ts$tsp
dcomp<-decompose(data_ts, type=c("additive"))
plot.ts(dcomp)

c<-b$total_conversions
min(b$conversion_day$year)
d<-b
d$year <- d$conversion_day$year
d$yday <- d$conversion_day$yday
as.Date(d$conversion_day$year[1])
?POSIXlt
d$conversion_day<- strptime(d$conversion_day,"%Y-%m-%d") 
class(max(d$conversion_day))
max(d$conversion_day)
max(d$conversion_day)

# Good STUFF!!! 
c<-b$total_conversions
c<- ts(data=c, start =c(1990,1), frequency=365)
?ts()
dygraph(Y_new)
decompose(c)
c_dcomp<-decompose(c)
plot(c_dcomp)
View(c)
c <- as.xts(b,order.by=b$conversion_day)
class(c)
?as.xts(0)
?xts()
Y_new <- xts(x = b[,-1], order.by = b$conversion_day)
View(Y_new)

library(dygraphs)
dygraph(presidents, main = "Presidential Approval") %>%
  dyAxis("y", valueRange = c(0, 100)) %>%
  dyEvent(date = "1950-6-30", "Korea", labelLoc = "bottom") %>%
  dyEvent(date = "1965-2-09", "Vietnam", labelLoc = "bottom")
class(presidents)
attributes(presidents)
