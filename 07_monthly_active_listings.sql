-- Calculate the monthly available listings
-- Process:
--   available only
--   add missing days
--   join in monthly intervals
--   count distinct listing_ids
--   between min and max dates

with
-- limit to test query
calendar_subset as (
  select * from calendar limit 10000
)

select j.date,
	   count(distinct c.listing_id) as monthly_active
from calendar_subset c
join julian j on j.date between date_add(c.date, interval -1 month) and c.date
where available = 1
and j.date >= (select min(date) from calendar)
group by date
