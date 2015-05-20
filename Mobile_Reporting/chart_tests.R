mobile_as_ran_data <- read.csv("C:/Users/john/Google Drive/R Directory/projects/Mobile Product Reporting/mobile_as_ran_data.csv")

#date fromatting
library(lubridate)
mobile_as_ran_data$date <- ymd(mobile_as_ran_data$date)

mobile_as_ran_data$month<-month(mobile_as_ran_data$date, label = TRUE)
library(plyr)
mobile_as_ran_data_m <- ddply(mobile_as_ran_data, .(month,device), summarize, revenue=sum(revenue))
# transform
library(plyr)
dv <- ddply(mobile_as_ran_data_m, "month", transform,
            percent_weight = revenue / sum(revenue) * 100)
# Create Chart
p <- ggplot(dv, aes(x=month, y=percent_weight, fill=device)) 
p + geom_bar(stat="identity") + theme_minimal()+ scale_fill_brewer(
  palette = "Blues") 

# Create Chart 2
p <- ggplot(dv, aes(x=month, y=revenue, fill=month)) 
p + geom_bar(stat="identity") + theme_minimal()+ scale_fill_brewer(
  palette = "Blues") + facet_wrap(~ device) 


device_lookup <- read.csv("C:/Users/john/Google Drive/R Directory/projects/Mobile Product Reporting/device_lookup.csv")
dv<-merge(dv2, device_lookup, by="device")
device_by_type <- ddply(dv, .(month,device_type), summarize, revenue=sum(revenue))
library(reshape2)
device_by_type2 <- dcast(device_by_type,month ~ device_type, value.var ="revenue")


#get data
library(RODBC)
conn <- odbcConnect("rfi_meta_data")
query_file <- 'daily_revenue_query.txt'
query <- readChar(query_file, file.info(query_file)$size)
daily_revenue <- sqlQuery(conn,query)
daily_revenue$date<-as.Date(daily_revenue$date, format="%Y/%m/%d")
# Date Formatting, adding month & year
library(lubridate)
daily_revenue$date<-ymd(daily_revenue$date)
daily_revenue$month<-month(daily_revenue$date, label=TRUE)
daily_revenue$year<-year(daily_revenue$date)
# aggregate to monthly
library(plyr)
monthly_revenue2 <- ddply(daily_revenue, .(month,year), numcolwise(sum))
head(monthly_revenue2)
# Then, Reshape
library(reshape)
monthly_revenue2_melt <-melt(monthly_revenue2, id.vars = c("month","year"),
                             variable.name = "type", 
                             value.name = "value")
# create grouped bar chart
ggplot(monthly_revenue2_melt, aes(x=month, y=value, fill=type)) +
  geom_bar(position="dodge", stat="identity",colour="black")+ theme(axis.text.x = element_text(angle=15, hjust=1))+ theme_minimal()+ scale_fill_brewer(
    palette = "Blues") 


library(RODBC)
conn <- odbcConnect("rfi_meta_data")
query_file <- 'daily_revenue_query.txt'
query <- readChar(query_file, file.info(query_file)$size)
daily_revenue <- sqlQuery(conn,query)
daily_revenue$date<-as.Date(daily_revenue$date, format="%Y/%m/%d")
# Date Formatting, adding month & year
library(lubridate)
daily_revenue$date<-ymd(daily_revenue$date)
daily_revenue$month<-month(daily_revenue$date, label=TRUE)
daily_revenue$year<-year(daily_revenue$date)
# aggregate to monthly
library(plyr)
monthly_revenue2 <- ddply(daily_revenue, .(month,year), numcolwise(sum))
head(monthly_revenue2)
summary(monthly_revenue2)
# convert revenue to millions
monthly_revenue2$revenue<-monthly_revenue2$revenue/1000
monthly_revenue2$cost<-monthly_revenue2$cost/1000
# Then, Reshape
library(reshape)
monthly_revenue2_melt <-melt(monthly_revenue2, id.vars = "month",
                             variable.name = "type", 
                             value.name = "value")
# create grouped bar chart
ggplot(monthly_revenue2_melt, aes(x=month, y=value, fill=variable)) +
  geom_bar(position="dodge", stat="identity",colour="black")+ theme(axis.text.x = element_text(angle=15, hjust=1))+ theme_minimal()+ scale_fill_brewer(
    palette = "Blues") 
