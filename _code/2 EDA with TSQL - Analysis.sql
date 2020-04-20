-- Use the newly created database
USE TwitterData
GO

/* 

	Exploratory Data Analysis with T-SQL

*/

 
-- Total number of tweets in the training dataset 
select count(1) as total_tweets
from dbo.Tweets 


-- Let's check the data types for each column
select cols.name as column_name, tp.name as column_type, cols.max_length, cols.is_nullable
from sys.tables t 
		 join sys.columns cols on t.object_id = cols.object_id
		 join sys.types tp on tp.system_type_id = cols.system_type_id and tp.user_type_id = cols.user_type_id
where t.name = 'Tweets'


-- Let's see what our tweets actually look like
select top 5 *
from dbo.Tweets
order by text_id



--- Check if we have any columns with missing (null) values: 
SELECT * 
FROM dbo.Tweets  
WHERE [text_id] IS NULL  
	  OR [text] IS NULL 
	  OR [selected_text] IS NULL 
	  OR [sentiment] IS NULL
 


-- Different types of sentiments => negative, positive, neutral 
select distinct sentiment 
from dbo.Tweets 
order by sentiment 


-- Number of tweets per sentiment - this is also called the class distribution of our sentiment label
-- We notice a class imbalance between negative, positive (similar distribution) and neutral (most of the training set contains neutral sentiment tweets)
select sentiment, count(text_id) nr_tweets
from dbo.Tweets 
group by sentiment
order by nr_tweets desc 


-- Let's see if we have any tweets with the same selected_text 
select selected_text, count(text_id) nr_tweets
from dbo.Tweets 
group by selected_text
order by nr_tweets desc 

-- Let's see some of the tweets for which the selected_text is "happy", since we see we have 302 such tweets
select sentiment, selected_text, text
from dbo.Tweets
where selected_text = 'happy'


-------------------------------------------------


-- Find min and max values of length per tweet, per sentiment: 
;with cte_length as 
(
	select text, len(text) tweet_length
	from dbo.Tweets 
)
select min(tweet_length) min_length, max(tweet_length) max_length
from cte_length


-- The distribution of length of tweets per sentiment
;with cte_length as 
(
	select text, 
		   sentiment,
		   case  
			when len(text) between 0 and 5  then '(0-5)' 
			when len(text) between 5 and 50 then '(5-50)'
			when len(text) between 50 and 100 then '(50-100)'
			when len(text) between 100 and 150 then '(100-150)'
			when len(text) > 150 then '(>150)'
	   end as length_group
	from dbo.Tweets 
)
select 
		sentiment, 
		isnull(p.[(0-5)], 0) '(0-5)',
		isnull(p.[(5-50)], 0) '(5-50)',
		isnull(p.[(50-100)], 0) '(50-100)',
		isnull(p.[(100-150)], 0) '(100-150)',
		isnull(p.[(>150)], 0) '(>150)'
from 
(
	select 
			sentiment, 
			isnull(length_group, 0) as length_group, 
			count(1) nr_tweets_length
	from cte_length
	group by sentiment, length_group
) t
pivot  (sum(t.nr_tweets_length) for length_group in ([(0-5)], [(5-50)], [(50-100)], [(100-150)], [(>150)])) as p

 

-- Same analysis, but this time for the selected_text: 
-- Find min and max values of length per selected_text, per sentiment: 
;with cte_length as 
(
	select text, len(selected_text) tweet_length
	from dbo.Tweets 
)
select min(tweet_length) min_length, max(tweet_length) max_length
from cte_length



-- The distribution of length of selected_texts per sentiment
;with cte_length as 
(
	select selected_text, 
		   sentiment,
		   case  
			when len(selected_text) between 0 and 5  then '(0-5)' 
			when len(selected_text) between 5 and 50 then '(5-50)'
			when len(selected_text) between 50 and 100 then '(50-100)'
			when len(selected_text) between 100 and 150 then '(100-150)'
			when len(selected_text) > 150 then '(>150)'
	   end as length_group
	from dbo.Tweets 
)
select 
		sentiment, 
		isnull(p.[(0-5)], 0) '(0-5)',
		isnull(p.[(5-50)], 0) '(5-50)',
		isnull(p.[(50-100)], 0) '(50-100)',
		isnull(p.[(100-150)], 0) '(100-150)',
		isnull(p.[(>150)], 0) '(>150)'
from 
(
	select 
			sentiment, 
			isnull(length_group, 0) as length_group, 
			count(1) nr_selected_text_chars
	from cte_length
	group by sentiment, length_group
) t
pivot  (sum(t.nr_selected_text_chars) for length_group in ([(0-5)], [(5-50)], [(50-100)], [(100-150)], [(>150)])) as p
=======
-- Let's check the distribution of length of tweets per sentiment: 
;with cte_length_distribution as 
(
	select text, len(text) tweet_length, sentiment
	from dbo.Tweets 
)
select sentiment, min(tweet_length) min_length, max(tweet_length) max_length
from cte_length_distribution
group by sentiment
order by sentiment 

-- Let's check the distribution of tweets by length => most of the tweets are less than 90 chars long
;with cte_length_distribution as 
(
	select text, len(text) tweet_length, sentiment
	from dbo.Tweets 
)
select tweet_length, count(text) tweet_distribution_by_length
from cte_length_distribution
group by tweet_length
order by tweet_length, tweet_distribution_by_length desc  

 