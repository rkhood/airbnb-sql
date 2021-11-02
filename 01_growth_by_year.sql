-- Estimate the growth of Airbnb each year
-- using the number of hosts registered as the growth metric

select year,
	   current_year,
       previous_year,
       round(((current_year - previous_year) / previous_year) * 100.0) as growth_metric
from
(select year,
	   current_year,
       lag(current_year, 1) over (order by year) as previous_year
from
(select extract(year from host_since) as year,
	   count(host_id) as current_year
from hosts
where host_id is not null
group by 1) a ) b
where year is not null
