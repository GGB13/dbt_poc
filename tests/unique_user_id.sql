select user_id, count(*) as count
from {{ ref('stg_users') }}
group by user_id
having count > 1
