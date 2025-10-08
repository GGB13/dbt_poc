with cohorts as (
  select
    user_id,
    cohort_week
  from {{ ref('cohort_analysis') }}
),

ltv as (
  select
    user_id,
    ltv_90d
  from {{ ref('customer_ltv') }}
),

segments as (
  select
    c.user_id,
    c.cohort_week,
    l.ltv_90d,
    case
      when l.ltv_90d > 500 then 'High Value'
      when l.ltv_90d between 100 and 500 then 'Medium Value'
      else 'Low Value'
    end as segment
  from cohorts c
  left join ltv l on c.user_id = l.user_id
)

select * from segments
