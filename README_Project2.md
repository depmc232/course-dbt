# Analytics engineering with dbt
# Project 2

## Part 1
<!-- What is our user repeat rate? -->

with order_per_user as (
    select user_id, count(distinct order_id) as number_of_orders
    from 
    dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__orders
    group by 1
),

repeat_users as(
    select count(repeat_.user_id) repeat_users_
    from order_per_user repeat_
    where number_of_orders >= 2
),
all_users as(
    select count(distinct user_id) as all_users_ from dev_db.dbt_ceciliadepmanmurmurationorg.stg_postgres__orders
)
select repeat_users_/all_users_
from repeat_users
full outer join all_users

--0.798387

<!-- What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question? -->

Users who likely to puchase again, might have consistent page views and are repeat customers with products in their cart.  Other data I//'d be interested in exploring is the length of time users spend in each search session and how lenth of time might relate to event_type.

<!-- Explain the product mart models you added. Why did you organize the models in the way you did? -->

I created 2 fact models summarizing different domensions of the data.  fact__sessions summarizes the types of events occuring in eaach session and the length of each session. fact__order_status summarizes users' individual orders by product and the status of their activity based on event_type.


<!-- Use the dbt docs to visualize your model DAGs to ensure the model layers make sense.  Paste in an image of your DAG from the docs. These commands will help you see the full DAG -->

![screenshot](screenshot_dag_20241020.png)

## Part 2
<!-- Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through. -->
I would schedule these tests to run regularly after the data gets updated and generate a notification (email/slack, etc) to relevent folks with table failures.  I would advise all downstream processes pause until tables are fixed and failures are resolved.

## Part 3
<!-- Which products had their inventory change from week 1 to week 2?  -->
Pothos
Philodendron
Monstera
String of pearls