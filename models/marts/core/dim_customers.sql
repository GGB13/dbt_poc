with customers as (
    select * from {{ref('stg_customers')}}
),

orders as (
    select * from {{ref('stg_orders')}}
)

select * from orders