select
  user_id,
  date_trunc('day', event_time) as activity_date,
  count(*) as events_count,
  count(distinct event_type_clean) as unique_event_types
from {{ ref('stg_events') }}
group by user_id, activity_date
