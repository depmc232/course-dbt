{{ config(materialized='table') }}

select events.*, name as product_name,
from {{ ref('stg_postgres__events') }} events
inner join {{ ref('stg_postgres__products') }} using (product_id)
where event_type= 'page_view' 


