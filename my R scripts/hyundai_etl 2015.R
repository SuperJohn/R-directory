## SET VARIABLES
hyundaiCPM_2015 <-  3.38 
hyundaiCPM_2014 <-3.83
hyundaiFBXCPM_2014 <-.85
hyundaiFBXCPM_2015 <-.85

# load data
hyundai_data <- read.csv(file="hyundai_data.csv")

#load lookup
hyundai_lookup <- read.csv("My R Data/hyundai_lookup.csv")

# transition date to date format
hyundai_data$Date<-as.POSIXlt(hyundai_data$Date,format="%m/%d/%Y")

# create year column
hyundai_data$year2 <- format(hyundai_data$Date,"%Y")

# total conversions column
hyundai_data$conversions_calc<- if()
  
# break out market code
# requires exception handling by year
  
  for (i in 1:20){
  if(hyundai_data$Year[i] == 2014)
  {hyundai_data$market_code2<-substr(hyundai_data$Placement,1,3)
  }else{
    hyundai_data$market_code2<-substr(hyundai_data$Placement,5,8)}
  }
warnings()

View(substr)
?subset()

# add Region Name lookup
# needs more work
m2<-merge(x=hyundai_data,y=hyundai_lookup,by.x="market_code",by.y="Code")


