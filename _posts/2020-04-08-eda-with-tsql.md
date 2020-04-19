---
layout: post
title: Tweets EDA with T-SQL
---

Welcome to my very first blog post! 
This is going to be a blog on the things that I am curious and passionate about. 
The main goal is for it to be a technical one, focused on the things I either already know and would like to document somewhere, or new things I am learning at the moment. 

I've recently become very very interested in Machine Learning and Deep Learning, so naturally you start wondering: How do I begin?
What's the first thing I should do? What do I already know and how can I leverage that, to learn something new? 

Exploratory data analysis is the first step in finding a solution to a certain problem in Machine Learning. That is, because of course you would like to see general statistics about your data and get familiar with it, in order to be able to develop any intuition about it. 

I will start by performing the exploratory data analysis using T-SQL. 
The next posts on this series will be performing it in Python with Pandas and in PySpark with PySQL. I am already excited, there's so much to learn.


Alright, let's jump right into it. 

The dataset I will be using for this EDA is the one from Kaggle's [Tweet Sentiment Extraction Competition](https://www.kaggle.com/c/tweet-sentiment-extraction/overview). 
The train dataset consists of a tweet id, the tweet text, a selected text from the tweet text and a sentiment attached to it. 
The end result for the competition would be developing a model that would be able to perform sentiment analysis in a way that given a certain selected text from a tweet, it would categorize it correctly into being neutral, negative or positive. 

We will use the data from the training set and start analysing it, to get an idea of how it looks like. 

1. After downloading the data from [Kaggle](https://www.kaggle.com/c/tweet-sentiment-extraction/data), we load it into a SQL Server Database, by using the [BULK INSERT](https://docs.microsoft.com/en-us/sql/t-sql/statements/bulk-insert-transact-sql?view=sql-server-ver15) command. 

2. 
