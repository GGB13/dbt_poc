select
  user_id,
  lower(email) as email,
  signup_date::date as signup_date,
  country,
  case
    when country in ('US', 'CA') then 'North America'
    else 'Other'
  end as region
from {{ source('raw', 'users') }}
where user_id is not null
