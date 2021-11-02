-- Reviewer stickiness i.e. DAU / MAU
with

subset as (
  select j.date,
         reviewer_id
  from reviews r
  right join julian j on j.date = r.date
  where j.date >= (select min(date) from reviews)
  order by j.date
  limit 1000
  ),

mau as (
  select s2.date,
         count(distinct s.reviewer_id) as mau
  from subset s
  join subset s2 on s2.date between s.date and date_add(s.date, interval 28 day)
  group by date
  ),

dau as (
  select date,
         count(distinct reviewer_id) as dau
  from subset
  group by date
  )
  
select d.date,
       d.dau,
       m.mau,
       round(d.dau / m.mau, 2) as stickiness
from dau d
join mau m on m.date = d.date
