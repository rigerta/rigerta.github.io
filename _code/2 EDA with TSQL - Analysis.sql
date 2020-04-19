-- Use the newly created database
USE TwitterData
GO

/* 

	Exploratory Data Analysis with T-SQL

*/

 
-- Total number of tweets in the training dataset 
select count(1) as total_tweets
from dbo.Tweets 


-- Let's see what our tweets actually look like
select top 5 *
from dbo.Tweets
order by text_id


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


-- Same analysis, but this time for the selected_text: 


-- Let's check the distribution of length of selected_text per sentiment: 
-- min length 1, max length 158

;with cte_length_distribution as 
(
	select selected_text, len(selected_text) selected_text_length, sentiment
	from dbo.Tweets 
)
select sentiment, min(selected_text_length) min_length, max(selected_text_length) max_length
from cte_length_distribution
group by sentiment
order by sentiment 

-- Let's check the distribution of tweets by length => most of the selected_texts are less than 15 chars long
;with cte_length_distribution as 
(
	select selected_text, len(selected_text) selected_text_length, sentiment
	from dbo.Tweets 
)
select selected_text_length, count(selected_text) st_distribution_by_length
from cte_length_distribution
group by selected_text_length
order by selected_text_length, st_distribution_by_length desc  


 