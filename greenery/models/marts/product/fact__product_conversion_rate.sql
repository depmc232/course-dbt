{{ config(materialized='table') }}

with all_product_views as (
    select 
        product_id
        ,count(distinct session_id) total_product_sessions
    from {{ ref('stg_postgres__events') }} events
    where event_type='page_view'
    group by 1
),
all_product_purchases as (
    select 
        oi.product_id
        ,count(distinct e.session_id) as product_purchase_events
    from {{ ref('stg_postgres__events') }} events e
    left join {{ ref('stg_postgres__order_items') }} oi 
        using(order_id)
    where e.event_type='checkout'
    group by 1
),
products as (
    select 
    distinct product_id
    ,name
    {{ ref('stg_postgres__products') }}
)
select
    product_id
    ,name as product_name
    ,total_product_sessions
    ,product_purchase_events
    ,product_purchase_events/total_product_sessions as product_conversion_rate
from all_product_views
left join all_product_purchases 
    using(product_id)
full outer join products
    using(product_id)
order by 5 desc

