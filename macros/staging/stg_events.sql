with raw_events as (
  select * from {{ source('raw', 'events') }}
),

cleaned_events as (
  select
    event_id,
    user_id,
    event_type,
    event_timestamp::timestamp as event_time,
    properties,
    case
      when event_type is null then 'unknown'
      else lower(event_type)
    end as event_type_clean,
    {{ dbt_utils.surrogate_key(['event_id']) }} as event_sk
  from raw_events
  where user_id is not null
)

select * from cleaned_events
