# Analytics engineering with dbt

- How many users do we have?

130
select count(distinct user_id) from dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__users

- On average, how many orders do we receive per hour?
15.041667
with hours as (
    select 
        EXTRACT('hour', created_at) AS "EXTRACTED"
        ,count(distinct order_id) AS ORDER_COUNT
    from dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__orders 
    group by 1
)
SELECT AVG(ORDER_COUNT) FROM HOURS

- On average, how long does an order take from being placed to being delivered?
3.891803
SELECT avg(timediff(days, created_at, delivered_at)) as avg_days_to_delivery
FROM dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__orders


- How many users have only made one purchase? Two purchases? Three+ purchases?
1 puchase: 25
2 purchases: 28
3 purchases: 34
with user_count as (
    select user_id, count(distinct order_id) as number_of_orders from dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__orders group by 1
)
select number_of_orders, count(*) 
from user_count
where number_of_orders <=3
group by 1

- On average, how many unique sessions do we have per hour?
39.458333
with hours as (
    select 
        EXTRACT('hour', created_at) AS "EXTRACTED"
        ,count(distinct session_id) AS session_count
    from dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__events 
    group by 1
)
SELECT AVG(session_count) FROM HOURS

