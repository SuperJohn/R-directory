


## USing ODBC FOR MYSQL
library(RODBC)
conn <- odbcConnect("RFI_analytics")
query1 <- sqlQuery(conn, "select * from rfi_meta_data.campaign limit 1000") 
str(query1)
head(query1)
View(query1)
odbcClose(conn)

library(sqldf)
View(a<- sqldf("select distinct(last_trip_date)  from uber_data order by last_trip_date desc limit 10"))
View(head(uber_data))

library(RODBC)
conn <- odbcConnect("rfi_meta_data")

action <- sqlQuery(conn,action_report_query)
apollo <- sqlQuery(conn,apollo_mv)
View(head(actions))
View(head(apollo))

library(RODBC)
conn <- odbcConnect("rfi_meta_data")
query1 <- sqlQuery(conn, sprintf(action_report_query, '20525217,20524903')) 
View(sprintf(action_report_query, '20525217,20524903'))
View(query1)
odbcClose(conn)

## AWESOME ACTION REPORTS with SMOOTHING!!! 
library(ggplot2)
library(ggthemes)
a <- ggplot(subset(query1,campaign_name == "alien"), aes(x = conversion_day, y = total_conversions, colour = action_name)) + stat_smooth(level = 0.99) + geom_point() + theme_pander()

ggplot(subset(query1,campaign_name != "alien"), aes(x = conversion_day, y = total_conversions, colour = action_name)) + stat_smooth(level = 0.99) + geom_point() 

b <- ggplot(action, aes(x = conversion_day, y = total_conversions))+ facet_grid(.~campaign_name)
c <- ggplot(subset(query1,campaign_name = "alien"), aes(x = conversion_day, y = total_conversions, colour = action_name)) + facet_grid(campaign_name~.)
a + geom_line()
a + geom_line(colour = "green")
## vertical
a + stat_smooth(level = 0.99) + geom_point()                                                 
b + stat_smooth(level = 0.99) + geom_point()
a

## horizontal
c +  stat_smooth(level = 0.99) + geom_point()

# Multiple Graphs
a <-  ggplot(subset(query1,campaign_name == "alien"), aes(x = conversion_day, y = total_conversions, colour = action_name)) + stat_smooth(level = 0.99) + geom_point() + xlab("alien")

b <-  ggplot(subset(query1,campaign_name != "alien"), aes(x = conversion_day, y = total_conversions, colour = action_name)) + stat_smooth(level = 0.99) + geom_point() + xlab("credited")

library(gridExtra)
grid.arrange(a,b,ncol=1)

library(ggplot2)
arrange_ggplot2(a,b,ncol=1)

## More Action Reports - Qplot Alternative
qplot(conversion_day,total_conversions , data = actions,colour = action_name, geom="jitter")

## COOL BINOMIAL WITH LOGISITIC REGRESSION AND SMOOTHING!
data("kyphosis", package="rpart")
qplot(Age, as.numeric(Kyphosis) - 1, data = kyphosis) +
  stat_smooth(method="glm", family="binomial")

qplot(Age, as.numeric(Kyphosis) - 1, data=kyphosis) +
  stat_smooth(method="glm", family="binomial", formula = y ~ ns(x, 2))

## RODBCext for parameterized queries
library(RODBC)
conn <- odbcConnect("RFI_analytics")
library(RODBCext) 
sql_a <- sqlPrepare(conn, )

## Test for multiple lines
library(ggplot2)

jobsAFAM1 <- data.frame(
  data_date = runif(5,1,100),
  Percent.Change = runif(5,1,100)
)

jobsAFAM2 <- data.frame(
  data_date = runif(5,1,100),
  Percent.Change = runif(5,1,100)
)

p <- ggplot() + 
  geom_line(data = jobsAFAM1, aes(x = data_date, y = Percent.Change, color = "red")) +
  geom_line(data = jobsAFAM2, aes(x = data_date, y = Percent.Change, color = "blue"))  +
  xlab('data_date') +
  ylab('percent.change')
p

## Multiple Lines Example 2
df1<-data.frame(x=1:10,y=rnorm(10))
df2<-data.frame(x=1:10,y=rnorm(10))

ggplot(df1,aes(x,y))+geom_line(aes(color="First line"))+
  geom_line(data=df2,aes(color="Second line"))+
  labs(color="Legend text")

## Multiple Lines Example 3
plot(rain$Tokyo,type="b",lwd=2,
     xaxt="n",ylim=c(0,300),col="black",
     xlab="Month",ylab="Rainfall (mm)",
     main="Monthly Rainfall in major cities")
axis(1,at=1:length(rain$Month),labels=rain$Month)
lines(rain$Berlin,col="red",type="b",lwd=2)
lines(rain$NewYork,col="orange",type="b",lwd=2)
lines(rain$London,col="purple",type="b",lwd=2)

legend("topright",legend=c("Tokyo","Berlin","New York","London"),
       lty=1,lwd=2,pch=21,col=c("black","red","orange","purple"),
       ncol=2,bty="n",cex=0.8,
       text.col=c("black","red","orange","purple"),
       inset=0.01)