
## ACTION REPORT QUERY
action
action_report_query <- ("SELECT   c.campaign_name AS campaign_name
                        , c.action_name AS action_name
                        , c.conversion_day AS conversion_day
                        , SUM(c.click_through) as click_through
                        , SUM(view_through) as view_through
                        , SUM(c.click_through) + SUM(view_through) AS total_conversions 
                        
                        FROM ( 	
                          SELECT cav.name AS action_name	
                          , IF(b.campaign_id=0,'alien',c.label) AS campaign_name
                          , b.*
                            FROM	
                          (	
                            SELECT  ca.current_version_id AS current_version_id	
                            , a.click_through + a.view_through AS total_conversions
                            , a.* 
                              FROM rfi_meta_data.rfi_aggregate_conversion_action_agg a	
                            LEFT JOIN rfi_conversion_action ca ON a.conversion_action_id=ca.id
                            WHERE a.conversion_action_id IN (%s) 	
                            AND conversion_day BETWEEN DATE_SUB(NOW(), INTERVAL 90 DAY) AND NOW()
                            #NAME?
                          ) b	
                          LEFT JOIN rfi_conversion_action_version cav ON cav.version_id=b.current_version_id	
                          LEFT JOIN campaign c ON b.campaign_id=c.id	
                        ) c	
                        
                        GROUP BY c.campaign_name	
                        , c.action_name
                        , c.conversion_day
                        ORDER BY conversion_day DESC"	) 

sprintf(action_report_query, '20525217')

apollo_mv <- "SELECT sum(a.adv_impressions) as adv_impressions, sum(a.spend) as spend, sum(a.adv_clicks) as adv_clicks, 
sum(a.adv_thisday_conversions) as adv_thisday_conversions, 
sum(a.adv_thisday_client_revenue) as adv_thisday_client_revenue, ru_am.full_name as account_manager, 
ru_analyst.full_name as analyst, cv.label as campaign, a.campaign_id, rd.label as advertiser, a.date, a.week FROM
(SELECT
 sum(adv_server_views) as adv_impressions, sum(cost_to_advertiser) as spend, sum(adv_clicks) as adv_clicks, 
 sum(adv_thisday_conversions) as adv_thisday_conversions, 
 sum(adv_thisday_client_revenue) as adv_thisday_client_revenue, amv.campaign_id as campaign_id, 
 amv.advertiser_id as advertiser_id, substr(amv.day,1,10) as date, 
 CONCAT(LPAD(CAST(WEEK(amv.day, 6) as CHAR), 2, '0'), ' (', STR_TO_DATE(CONCAT(YEARWEEK(amv.day),' Sunday'), '%X%V %W'), ')') as week
 FROM apollo_mv_agg amv 
 WHERE amv.day BETWEEN DATE_SUB(NOW(), INTERVAL 30 DAY) AND NOW() 
 AND amv.sub_network_id in (1,2,3,4,5,7,9,11,13,17,25)
 GROUP BY amv.campaign_id, amv.advertiser_id, substr(amv.day,1,10), 
 CONCAT(LPAD(CAST(WEEK(amv.day, 6) as CHAR), 2, '0'), ' (', STR_TO_DATE(CONCAT(YEARWEEK(amv.day),' Sunday'), '%X%V %W'), ')') ORDER BY null) a
LEFT JOIN role_assignments ra_am ON a.campaign_id=ra_am.object_id AND ra_am.object_type=Campaign AND ra_am.role=account_manager
LEFT JOIN rfi_user ru_am ON ra_am.assignee_id=ru_am.id
LEFT JOIN role_assignments ra_analyst ON a.campaign_id=ra_analyst.object_id AND ra_analyst.object_type=Campaign AND ra_analyst.role= analyst
LEFT JOIN rfi_user ru_analyst ON ra_analyst.assignee_id=ru_analyst.id
LEFT JOIN rfi_campaign_version cv ON a.campaign_id=cv.campaign_id
LEFT JOIN rfi_campaign ON rfi_campaign.current_version_id=cv.version_id
LEFT JOIN rfi_definer rd ON a.advertiser_id=rd.id
WHERE (cv.campaign_id IS NULL OR rfi_campaign.current_version_id IS NOT NULL) AND 
((ru_analyst.full_name like '%John Houghton%'))
GROUP BY ru_am.full_name, ru_analyst.full_name, cv.label, a.campaign_id, rd.label, a.date, a.week ORDER BY null"
