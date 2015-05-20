mercury.storm.tactic.data <- read.csv("C:/Users/john/Google Drive/R Directory/temp data/mercury storm tactic data.csv")
mercury_data<-mercury.storm.tactic.data
rm(mercury.storm.tactic.data)
mercury_data$cpa_bid<-as.numeric(mercury_data$cpa_bid)
mercury_data$cpm_bid<-as.numeric(mercury_data$cpm_bid)
summary(mercury_data)

g<- ggplot(mercury_data,aes(x=cpm_bid, y=cpa_bid))+
  geom_point()+scale_y_continuous()
# +facet_wrap(~date.logtime.)
g  
  qplot(mercury_data,x=cpm_bid,y=cpa_bid)
