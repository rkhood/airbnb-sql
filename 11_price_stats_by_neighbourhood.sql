-- Most popular prices by neighbourhood

select neighbourhood_cleansed,
       min(price) as min_price,
       max(price) as max_price,
       round(avg(price)) as avg_price
from (
  select neighbourhood_cleansed,
  	     price,
         count(price) as price_freq,
         dense_rank() over(partition by neighbourhood_cleansed order by count(price) desc) as ranking
  from listings
  group by neighbourhood_cleansed, price
  order by neighbourhood_cleansed, price_freq desc
) a
where ranking = 1
group by neighbourhood_cleansed
