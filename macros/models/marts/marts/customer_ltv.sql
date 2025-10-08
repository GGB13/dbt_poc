with revenue_events as (
  select
    user_id,
    event_time::date as revenue_date,
    (properties->>'revenue')::float as revenue
  from {{ ref('stg_events') }}
  where event_type_clean = 'purchase'
),

ltv as (
  select
    user_id,
    sum(revenue) over (
      partition by user_id
      order by revenue_date
      rows between current row and 89 following
    ) as ltv_90d
  from revenue_events
)

select distinct user_id, max(ltv_90d) as ltv_90d
from ltv
group by user_id
