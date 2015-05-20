select day as data_date
     , a.campaign_id as campaign_id
     , a.line_item_id as line_item_id 
     , a.flight_id as flight_id
     , a.rfiImps as rfiImps
     , a.vImps as vImps
     , a.vPct as vPct
     , af.objective_impressions as objective_impressions
     , f.flight_label as flight_label
     , f.flight_start_date as flight_start_date 
     , f.flight_end_date as flight_end_date 
     , li.line_item_label as line_item_label
     , c.campaign_label as campaign_label
     , concat(c.campaign_label, " - ", a.campaign_id) as campaign_label_id

from

(select day
     , campaign_id
     , line_item_id
     , flight_id
     , round(sum(rfi_server_views),0) as rfiImps
     , round(sum(adv_server_views),0) as vImps
     , round(sum(adv_server_views),0) / round(sum(rfi_server_views),0) as vPct

from apollo_mv

where day >= date_sub(curdate(), interval 120 day)
  and day <= date_sub(curdate(), interval 0 day)

group by day
       , campaign_id
       , line_item_id
       , flight_id

) a
       
INNER JOIN 

(select id
      , rfi_flight_version.label as flight_label
      , rfi_flight_version.start_date as flight_start_date
      , rfi_flight_version.end_date as flight_end_date
from rfi_flight, rfi_flight_version
where rfi_flight.current_version_id = rfi_flight_version.version_id) f

on a.flight_id = f.id

INNER JOIN 

(select id, rfi_line_item_version.label as line_item_label
from rfi_line_item, rfi_line_item_version
where rfi_line_item.current_version_id = rfi_line_item_version.version_id) li

on a.line_item_id = li.id

INNER JOIN 

(select id
      , rfi_campaign_version.label as campaign_label
from rfi_campaign, rfi_campaign_version
where rfi_campaign.current_version_id = rfi_campaign_version.version_id) c

on a.campaign_id = c.id

INNER JOIN 

(select rfi_assigned_flight_version.flight_id
      , rfi_assigned_flight_version.line_item_id
      , rfi_assigned_flight_version.objective_impressions
      
from rfi_assigned_flight, rfi_assigned_flight_version 

where rfi_assigned_flight.current_version_id = rfi_assigned_flight_version.version_id) af

on a.flight_id = af.flight_id
and a.line_item_id = af.line_item_id

where flight_end_date >= curdate()