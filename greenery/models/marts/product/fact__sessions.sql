{{ config(materialized='table') }}

select 
    session_id
    ,{{ agg_events('page_view',sum) }} as count__page_view
    ,{{ agg_events('add_to_cart',sum) }} as count__add_to_cart
    ,{{ agg_events('checkout',sum) }} as count__checkout
    ,{{ agg_events('package_shipped',sum) }} as count__package_shipped
    ,min(CREATED_AT) as start_time
    ,max(created_at) as end_time
    ,concat(TIMEDIFF(minute, min(created_at), max(CREATED_AT)),' minutes') AS session_length
from {{ ref('stg_postgres__events') }} events
group by 1


