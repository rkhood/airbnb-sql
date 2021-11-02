-- Reviewer MAUs

-- date, num_review_subset, num_review_subset1 at date1
-- ...
-- date, num_review_subset, num_review_subset1 at date30
with

subset as (
  select j.date,
         reviewer_id
  from reviews r
  right join julian j on j.date = r.date
  where j.date >= (select min(date) from reviews)
  order by j.date
  limit 1000
  )

select s2.date,
       count(distinct s.reviewer_id) as mau
from subset s
join subset s2 on s2.date between s.date and date_add(s.date, interval 28 day)
group by date
