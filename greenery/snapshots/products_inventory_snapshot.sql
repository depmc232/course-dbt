{% snapshot products_inventory_snapshot %}

{{
  config(
    target_database = target.dev_db,
    target_schema = target.dbt_ceciliadepmanmurmurationorg,
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}}

SELECT * FROM {{ source('postgres', 'inventory') }}

{% endsnapshot %}