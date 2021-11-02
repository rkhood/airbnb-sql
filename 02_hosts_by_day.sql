-- number of hosts every day
select date,
	   sum(num_hosts) over (order by date) as cumsum
from
(select date,
       coalesce(count(host_id), 0) as num_hosts
from
(select date,
	   host_id
from hosts h
right join julian j on j.date = h.host_since) a
group by date) b
