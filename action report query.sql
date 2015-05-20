-- action report query 

SELECT
a.data_date as day
, dim_lookup('actions_dim',a.conversion_action_version_id,'name') as action_name
, a.conversion_action_id as Action_ID
, dim_lookup('actions_dim',a.conversion_action_version_id,'action_type_name') as type
, sum(a.click_through) + sum(a.view_through) as credited_conversions
, sum(a.click_through) as click_through
, dim_lookup('actions_dim',a.conversion_action_version_id,'click_fraction_attributed') as click_attr
, sum(a.view_through) as view_through
, dim_lookup('actions_dim',a.conversion_action_version_id,'view_fraction_attributed') as view_attr
, sum(b.view_through) as alien
FROM rfi_aggregate_conversion_action a
INNER JOIN rfi_aggregate_conversion_action b
ON a.data_date = b.data_date AND a.conversion_action_id = b.conversion_action_id
WHERE a.data_date >= 'YYYYMMDD'
and a.conversion_action_id = 
and a.campaign_id is not NULL
and b.campaign_id is NULL
GROUP BY
a.data_date
, dim_lookup('actions_dim',a.conversion_action_version_id,'name')
, a.conversion_action_id
, dim_lookup('actions_dim',a.conversion_action_version_id,'action_type_name')
, dim_lookup('actions_dim',a.conversion_action_version_id,'click_fraction_attributed')
, dim_lookup('actions_dim',a.conversion_action_version_id,'view_fraction_attributed') ;