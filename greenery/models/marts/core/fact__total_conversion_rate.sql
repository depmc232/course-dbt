{{ config(materialized='table') }}

with all_sessions as (
    select 
        count(distinct session_id) as total_sessions 
    from {{ ref('stg_postgres__events') }} events
),
purchases as (
    select 
        {{ agg_events('checkout',sum) }} as purchase_events 
    from {{ ref('stg_postgres__events') }} events
)

select 
    total_sessions
    ,purchase_events
    ,purchase_events/total_sessions as conversion_rate 
from all_sessions 
join purchases

    