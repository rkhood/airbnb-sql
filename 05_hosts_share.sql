-- Calculate the share of new and existing users
-- Output the month, share of new users, and share of existing users as a ratio

with

num_hosts as (
select 
	   extract(year_month from host_since) as date,
       count(host_id) as num_host
from hosts h
where host_id is not null
  and host_since is not null
group by date
),

total_hosts as (
select date,
	   sum(num_host) over (order by date) as total_host
from num_hosts
group by date
)

select th.date,
	   total_host,
	   nh.num_host as new_host,
       nh.num_host / total_host as share
from total_hosts th
join num_hosts nh on nh.date = th.date
