{{ config(materialized='table') }}

select session_id, 
sum(case when event_type = 'page_view' then 1 else 0 end) as count__page_view,
sum(case when event_type = 'add_to_cart' then 1 else 0 end) as count__add_to_cart,
sum(case when event_type = 'checkout' then 1 else 0 end) as count__checkout,
sum(case when event_type = 'package_shipped' then 1 else 0 end) as count__package_shipped,
min(CREATED_AT) as start_time, 
max(created_at) as end_time, 
concat(TIMEDIFF(minute, min(created_at), max(CREATED_AT)),' minutes') AS session_length
from {{ ref('stg_postgres__events') }} events
group by 1


