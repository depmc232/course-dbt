{{ config(materialized='table') }}

select user_id, name as product_name,
sum(case when event_type = 'page_view' then 1 else 0 end) as count__page_view,
sum(case when event_type = 'add_to_cart' then 1 else 0 end) as count__add_to_cart,
sum(case when event_type = 'checkout' then 1 else 0 end) as count__checkout,
sum(case when event_type = 'package_shipped' then 1 else 0 end) as count__package_shipped,
from {{ ref('stg_postgres__events') }}
inner join {{ ref('stg_postgres__products') }} using (product_id)
group by 1,2
