## load data
library(RODBC)
conn <- odbcConnect("rfi_meta_data")
model_calibration_query<-("
SELECT model_health_metric_calibration.day AS data_date 
, campaign_id
, model_id 
, round(SUM(actions_predicted),2) as actions_predicted
, round(SUM(actions_observed),0) as actions_observed
, round(sum(views),0) as impressions
FROM `model_health_metric_calibration`
WHERE DAY BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND CURDATE()
and campaign_id = 46985
GROUP BY DAY
, campaign_id
, model_id
ORDER BY DAY DESC
")
model_calibration_data <- sqlQuery(conn, model_calibration_query) 

# data type conversions
model_calibration_data$model_id <-factor(model_calibration_data$model_id)
model_calibration_data$campaign_id <-factor(model_calibration_data$campaign_id)
model_calibration_data$data_date <- strptime(
  model_calibration_data$data_date
  , "%d/%m/%Y"
)

# actions predicted by model
a<-ggplot(model_calibration_data, aes(x=data_date,y=actions_predicted)) 
a + geom_line(aes(colour=model_id))


# impressions by model
a<-ggplot(model_calibration_data, aes(x=data_date,y=impressions))
a + geom_line(aes(colour=model_id))
a + geom_bar(stat="identity",fill=model_calibration_data$model_id)

#,position="dodge"
a + geom_bar(aes(weight=impressions,binwidth=1))
?geom_bar()
a + geom_bar() + stat_summary(geom="ribbon", fun.ymin="min", fun.ymax="max")

ggplot(model_calibration_data,aes(x=data_date,fill=model_id)) + geom_bar()

ggplot(model_calibration_data,stat="identity",aes(x=data_date,y=impressions)) + geom_bar()


+ geom_area(aes(ymin=0,ymax=action_predicted))
  
qplot(data_date, action_predicted, data=model_calibration_data, geom=c("area","line"))

ggplot(model_calibration_data[1:30,],aes(x=data_date,y=impressions))+geom_line(aes(colour=model_id))

summary(model_calibration_data)
# data type conversions
model_calibration_data$data_date <- strptime(
  model_calibration_data$data_date
  , "%d/%m/%Y"
)
model_calibration_data$model_id <-factor(model_calibration_data$model_id)