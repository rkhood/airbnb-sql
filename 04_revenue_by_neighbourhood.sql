-- revenue by neighbourhood

select h.host_neighbourhood,
	   round(avg(c.price)) as average_revenue,
       sum(c.price) as total_revenue
from calendar c
join listings l on l.id = c.listing_id
join hosts h on h.host_id = l.host_id
where available = 1
and host_neighbourhood is not null
group by host_neighbourhood
order by total_revenue desc
