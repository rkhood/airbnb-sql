-- Number of properties by type and total
-- By columns
-- Fraction of House, Apartment, and Townhouse as columns

select house / total as house,
	   apartment /total as apartment,
       townhouse / total as townhouse
from (
select sum(house_counts) as house,
	   sum(apartment_counts) as apartment,
       sum(townhouse_counts) as townhouse,
       count(*) as total
from (
select case when property_type = 'House' then 1 else 0 end as house_counts,
       case when property_type = 'Apartment' then 1 else 0 end as apartment_counts,
       case when property_type = 'Townhouse' then 1 else 0 end as townhouse_counts
from listings
) a
) b
