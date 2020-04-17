---
layout: post
title: EDA in Python with Pandas!
---


Learning Python and coming from a SQL background, the first thing I wanted to be able to do was handling a dataset in Python the way I do using T-SQL.
Being comfortable and familiar with Python will take time, but I can start by finding parallels in the way both work with data and maybe feel like I am not stranded out in the wild.
 

I have already written and article on [Exploratory Data Analysis with T-SQL](), but now I want to do the same using Python and Pandas. 
If you are learning Python and have spent many a night thinking about this (as I might have done), then keep reading. 


Typical checks I usually do when I have to work with a dataset (or in my database tables, an actual table or several of those) are: 


1. Check how the table looks like (first few rows, just to get an idea of how the data is)
2. Check how many rows there are
3. Check how many of those rows have columns that are null or empty
4. Get max, min values (for columns such as timestamps, to get an idea of the timeframe of the data I am working on) 
5. Check how many rows do I have per entity, are they unique entries, are they not? 



Let's load a dataset and try to do exactly these checks in Python using Pandas. 





The next post in this series will be [Exploratory Data Analysis using PySpark and SparkSQL](). 
Let me know if you would be interested in that, I'd be happy to put together a tutorial. 



