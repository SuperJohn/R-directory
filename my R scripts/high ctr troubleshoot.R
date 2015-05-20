campaign_id <- "52673"
ctr_threshold <- .002
## 52673 51513

sites_by_ctr_query <-("select line_item_id
, period
, refresh_time
, description as site
, sum(views) as impressions
, sum(clicks) as clicks
from campaign_insights_new
where campaign_id = %s 
and feature = 'site'
and description <> '_TOTAL_'
group by line_item_id
, period
, refresh_time
, description")
?sprintf()
library(RODBC)
conn <- odbcConnect("modeling db")
sites_by_ctr <- sqlQuery(conn, sprintf(sites_by_ctr_query, campaign_id)) 

## format query data
library(sqldf)
sites_by_ctr_formatted<-sqldf('select site, sum(impressions) as impressions, sum(clicks) as clicks,sum(clicks)/sum(impressions) as ctr from sites_by_ctr where period=7 group by site order by ctr asc')

# add rank column
sites_by_ctr_formatted$rank<-rank(sites_by_ctr_formatted$ctr, ties.method="first")
sites_by_ctr_formatted$ctr_2<-sites_by_ctr_formatted$ctr*100

# add cum clicks column
for (loop in (1:nrow(sites_by_ctr_formatted)))
{sites_by_ctr_formatted[loop,"cum_clicks"] <- sum(sites_by_ctr_formatted[1:loop,"clicks"])}
# add cum imps column
for (loop in (1:nrow(sites_by_ctr_formatted)))
{sites_by_ctr_formatted[loop,"cum_imps"] <- sum(sites_by_ctr_formatted[1:loop,"impressions"])}
# add cumulative ctr by rank column !! needs work
for (loop in (1:nrow(sites_by_ctr_formatted)))
{sites_by_ctr_formatted[loop,"cum_ctr"] <- sum(sites_by_ctr_formatted[1:loop,"clicks"])/sum(sites_by_ctr_formatted[1:loop,"impressions"])}
## add is_mobile column
sites_by_ctr_formatted$is_mobile<-grepl('mob.app',sites_by_ctr_formatted$site)

# plot cumulative ctr by rank
library(ggplot2)
ggplot(data=sites_by_ctr_formatted,aes(x=rank, y=cum_ctr))+geom_bar(stat="identity")
# Return sites above threshold
subset(sites_by_ctr_formatted,cum_ctr>ctr_threshold, select=c(is_mobile,site,ctr))

library(ggplot2)
ggplot(data=subset(sites_by_ctr_formatted,cum_ctr>ctr_threshold, select=c(site,ctr,clicks))
,aes(x=site, y=ctr,label=clicks))+geom_bar(stat="identity")+coord_flip()+geom_text(hjust=0, vjust=0)



