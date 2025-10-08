with user_cohorts as (
  select
    user_id,
    signup_date,
    date_trunc('week', signup_date) as cohort_week
  from {{ ref('stg_users') }}
),

activity as (
  select
    ua.user_id,
    ua.activity_date,
    uc.cohort_week
  from {{ ref('user_activity') }} ua
  join user_cohorts uc on ua.user_id = uc.user_id
)

select
  cohort_week,
  activity_date,
  count(distinct user_id) as active_users
from activity
group by cohort_week, activity_date
order by cohort_week, activity_date
