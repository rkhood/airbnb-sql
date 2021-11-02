-- Ranked highest priced properties by area

select * from (
select id,
	   price,
       neighbourhood_cleansed,
       rank() over (partition by neighbourhood_cleansed order by price desc) as ranking
from listings
) a
where a.ranking = 1
