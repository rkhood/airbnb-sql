-- Number of properties by type and total
-- By rows

select property_type,
	   count(*) as num_property
from listings
where property_type is not null
group by property_type

union

select 'Total' as property_type,
	   count(*) as num_property
from listings
where property_type is not null
order by num_property desc
