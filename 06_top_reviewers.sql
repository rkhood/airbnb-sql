-- super reviewers
select 
		 reviewer_id,
         reviewer_name,
         count(*) as num_reviews
from reviews
group by reviewer_id, reviewer_name
having count(*) > 10
