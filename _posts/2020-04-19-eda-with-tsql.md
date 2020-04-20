---
layout: post
title: Tweets EDA with T-SQL
---
 

Welcome to my very first blog post!


This is going to be a blog on the things that I am curious and passionate about. 

The main goal is for it to be a technical one, focused on the things I either already know and would like to document somewhere, or new things I am learning at the moment.

_Alternatively, I can write on my sucessful and failed (?) attempts at following baking recipes, but that's only my back up plan, in case I am *that* bad at blogging on technical stuff. I figured it is a solid back up plan, don't you agree?_


I've recently become very interested in Machine and Deep Learning and as you quickly learn, once into the topic, the first step in solving any kind of problem is analysing the data you have to work with and getting familiar with it. And by that I mean _really_ familiar. 

You need to know exactly what are you working on and how the data looks like and what is missing and why is it missing and what can you replace it with and oh-so-many things to worry about. 

But first, let's get some insights from our dataset. Basic ones. Easy small-talk with the data. More like a one-sided small talk, since you ask and the data answers. 
It does not ask you back. 

_Quite boring, you might think. But not really!_

This is exactly the point of my exercise: I'd like to be able to have a nice small-talk with the data, get some basic info and move on with my life. 
You know, especially now that there are no friends around, my hobby is talking to data. ~~Things are getting weird. Belive me, I am aware of it!~~ 

Anyway, if you have never been good in small talk, this is your chance to practice, because this is the only way to be able to develop an intuition about your data. 
Or have any friends in real life, for that matter. _Just look at how nice this has worked out for me._

So, back to the subject: 

The most commonly used languages for exploratory data analysis seem to be R and Python. Yes, I checked. Yes, by [googling](https://www.google.com/search?client=firefox-b-d&q=most+common+languages+to+perform+exploratory+data+analysis) it. 

According to Google:  

>
Exploratory Data Analysis In Python Vs R. 
>
Python and R programming are the two most widely used languages for data analysis by data scientists.
Nov 5, 2019


I personally have chosen to learn Python, however I decided to first perform this task in T-SQL, since this is part of my comfort zone. 
The learning-new-things steps will come a tiny bit later. One has to start somewhere, right?


Also, I have noticed there are people interested in doing this kind of analysis in T-SQL. 
How do I know this? Glad you asked. Going back to Google, searching for ["exploratory data analysis with t-sql"](https://www.google.com/search?client=firefox-b-d&ei=yaecXtK3Eueo1fAP9aWakAo&q=exploratory+data+analysis+with+t-sql&oq=exploratory+data+analysis+with+t-sql&gs_lcp=CgZwc3ktYWIQAzoECAAQRzoECCEQClCdpAtYtKwLYLytC2gAcAp4AIABWogBmAOSAQE1mAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab&ved=0ahUKEwiSwN35nfXoAhVnVBUIHfWSBqIQ4dUDCAs&uact=5) there are more than 2 million results - which means, _some_ people are still interested in reading about this.

Yes - it also means _there are already more than 2 million results on the subject, why are you adding another one, Rigerta?_ but please let's not go there, because honestly, I am also somewhat still wondering. 

However, articles like [Writing a Technical Blog: Why to do it and what to write about](https://littlekendra.com/2011/01/13/onblogging/) from Kendra Little ([t](https://twitter.com/Kendra_Little), [b](https://littlekendra.com/)) and [this](https://medium.com/@racheltho/why-you-yes-you-should-blog-7d2544ac1045) by Rachel Thomas ([t](https://twitter.com/math_rachel)) and so many more on the subject, made me think I could and maybe _should_ just do it. So here we are.   

Now, coming back to the main subject, T-SQL is not a language _designed_ for exploratory data analysis, but the kind of analysis I have in mind can be easily done in T-SQL as well, so I thought of giving this a try and then proceeding with other language/s. 


This will be the first article in a series of 3, since I plan to do the same in Python with Pandas and in PySpark with SparkSQL - because...well, it's quarantine time and I cannot use my usual excuses to procrastinate. 
 

<h3> Alright, let's jump right into it. </h3>


I will load the dataset into a _SQL Server 2019 (Developer Edition)_ database and the dataset I will be using for this article is the one from Kaggle's <a href="https://www.kaggle.com/c/tweet-sentiment-extraction/overview" target="_blank">Tweet Sentiment Extraction Competition</a> (used under creative commons attribution 4.0. international licence).


The train dataset consists of:
* a `tweet_id`
* the `tweet_text`
* a `selected_text` from the tweet text and 
* a `sentiment` attached to it


The objective in this competition is to develop a model that performs sentiment analysis on the test dataset so that when provided with a certain selected text from a tweet, it can categorize it's sentiment correctly into either `neutral`, `negative` or `positive`. 

 
<h3> Step 1. Download the train.csv dataset file from <a href="https://www.kaggle.com/c/tweet-sentiment-extraction/data" target="_blank">Kaggle</a> </h3> 

 
![Download Kaggle's Tweets Dataset](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/undraw_download.png "Download Kaggle's Tweets Dataset")
 

<h3> Step 2: Load the data into the database using the <a href="https://docs.microsoft.com/en-us/sql/t-sql/statements/bulk-insert-transact-sql?view=sql-server-ver15" target="_blank">BULK INSERT</a> command </h3> 

<script src="https://gist.github.com/rigerta/99e4cad54dc3eed5f969c738c4b24286.js"></script>
 
![Start Analysing](https://github.com/rigerta/rigerta.github.io/tree/dev/images/visual_data.png "Start analysing!")
 

<h3> Step 3: Let the fun begin! </h3> 


Let's first see how many tweets we have in the dataset and how does the data in the first five rows look like:

<script src="https://gist.github.com/rigerta/f29b0033d8c02093b2eb653918332c0f.js"></script>

We have *27.481* tweets in total, we have the full tweet in the `text` column and the `selected_text` seems to be a subset of the tweet itself - at least at first sight.

![Ininital checks](https://graw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/initial_check.png "Initial Results!")

We also see that our columns are all text columns (type `nvarchar`) and they are all `nullable`, which means we _might_ have null values in any of those columns. 

Let's see if we do have any: 

<script src="https://gist.github.com/rigerta/002b2dd21972733fbb075fa21566f861.js"></script>

It turns out we only have one row with missing tweet_text and selected_text which is classified as a neutral tweet. 

![Missing values](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/04.png "Missing values!")


Let's do some further checks, as to find out what are the distinct values for our sentiment column accross the whole dataset and check how many tweets we have per sentiment,
using the following two queries: 

<script src="https://gist.github.com/rigerta/1a22477cfa9dead1bdc4049ea717d6ce.js"></script>
![Further checks](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/further_checks.png "Further checks!")

So we have three distinct values for the sentiment column and luckily, no tweets that have a missing value for it.

We also notice we have a similar distribution for positive and negative tweets, while we have a much larger number of neutral tweets. 

These are insights we get from simple quick checks on our data that will prove to be very useful in the next steps of building an accurate machine learning model for the specific competition, but this is something we do not need to think about now. We have so much to learn before we get there.


Next, we will find out if we have the same selected_text for more than one tweet and if so, we will take a look at those tweets, to see what do they have in common.

These steps are done to help building an intuition and getting to know your data. 
It is very important to know what you are working with, so that you can take better decisions. 

<script src="https://gist.github.com/rigerta/5479aa85a06bbffc3002a2247fb20008.js"></script>

![Same selected text per tweet](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/05.png "Same selected text per tweet!")

As we see, there are 303 tweets in the dataset having the same selected text - "happy" and 262 sharing the selected text "good" and so on. 

Next step is finding out what is the distribution of length of tweets per sentiment. 

We can find out the shortest and longest tweet lenth using the following query: 

<script src="https://gist.github.com/rigerta/d83f976d4d43622405369dfed18af7d0.js"></script>

And we find out that our tweets range from 3 characters long to 159 characters long. 

![MinMax Length](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/06.png "MinMax Tweet Length!")


That means that finding the distribution of tweet length per sentiment, we could come up with groups like: 
* (0-5) characters
* (5-50) characters 
* (50-100) characters
* (100-150) characters and
* (> 150) characters 

We can use the following query and find out how long are most of the tweets per each sentiment we have in our dataset: 

<script src="https://gist.github.com/rigerta/1619284915a64fd7a90696bb336d39a0.js"></script>

The results seem interesting: 

![Tweet Length Distribution Per Sentiment](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/07.png "Tweet Length Distribution Per Sentiment!")

  Most of the positive and negative tweets are between 50-100 characters long  

  Most of the neutral tweets are shorter - between 5-50 characters

  There's a single tweet longer than 150 characters and that it is a neutral one.


We can perform the same analysis on the selected_text and see what we find. 
The query is the same, just this time we query on the selected_text instead of the tweet text. 

<script src="https://gist.github.com/rigerta/6337131100317386100b7b00015d38d1.js"></script>

> For every sentiment, whether negative, positive or neutral, the majority of the selected texts are between 0-50 characters long.

![Selected Text Length Distribution Per Sentiment](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/08.png "Selected Text Length Distribution Per Sentiment!")


## A quick recap:

What do we know about the data in the train.csv dataset? 

>
There are in total 27.481 tweets
>
There is only one row with missing data
>
We have no missing sentiment label for any of the train dataset rows
>
The dataset has a similar number of positive and negative tweets, but almost double of that number in neutral tweets
>
The tweet texts are between 0-159 characters long
>
Most of the positive and negative tweets are less than 100 characters long 
>
Most of the neutral tweets are less than 50 chars long 
>
Most of the selected texts (regardless of the sentiment) are less than 50 characters long
 

Further - slightly more advanced - exploratory steps could include trying to find out how many words there are per tweet, the average word length, the word distribution and the number of unique words.

This can be done using the [STRING_SPLIT()](https://docs.microsoft.com/en-us/sql/t-sql/functions/string-split-transact-sql?view=sql-server-ver15) function (available as of SQL Server 2016, Compatibility Level 130). 


<br/>       

<div class="centered_p">
  <p> ******* </p>
</div>

We have performed a basic exploratory data analysis on the tweets dataset and now we are ready for the next steps, which would be post-processing and building a machine learning model to fit our training set and accurately classify the test set tweets selected text sentiment! 


If by any chance you decide to give this competition a try on Kaggle, have fun and good luck! 


I will meanwhile perform the same analysis on the same dataset on Python as well, so if you're interested, keep an eye for the next post in this series.

<br/>

_One last note_: 

All the illustrations on this post are from [UnDraw](https://undraw.co/illustrations). 
I love them and they are easily customizable and _free_ to use. 

_A big shout out to the developers and designers, they are doing a great job!_



<div class = "center" markdown="1">
![Super Thank You!](https://raw.githubusercontent.com/rigerta/rigerta.github.io/dev/images/happy.png "Super Thank You!")
</div>



Thank youhu for reading!  

























