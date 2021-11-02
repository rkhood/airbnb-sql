-- Calculate YoY growth per day

-- 1. Calculate cum sum of hosts
-- 2. YoY comparison (per day)

with

julian_dates as (
  select date,
	     host_id
  from hosts h
  right join julian j on j.date = h.host_since
),
  
all_dates as (
  select date,
	     coalesce(count(host_id), 0) as num_hosts
  from julian_dates
  group by date
),

cumsums as (
  select date,
	     sum(num_hosts) over (order by date) as cumsum_hosts
  from all_dates
  group by date
),

comparison as (
  select cm.date,
         cm.cumsum_hosts as current_hosts,
         cm2.cumsum_hosts as previous_hosts
  from cumsums cm
  join cumsums cm2 on cm2.date = date_add(cm.date, interval -1 year)
  order by date
)

select date,
	   current_hosts,
       previous_hosts,
       round(((current_hosts - previous_hosts) / previous_hosts) * 100.0) as growth
from comparison
order by date
