-- Ratio of availability by listing_id
select listing_id,
	   available,
       num_days / total_days as ratio
from (
  select listing_id,
         available,
         count(*) as num_days,
         sum(count(*)) over(partition by listing_id) as total_days
  from calendar
  group by listing_id, available
) a
order by listing_id, available
