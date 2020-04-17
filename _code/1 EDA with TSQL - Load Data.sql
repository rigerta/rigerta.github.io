
-- First we need to create the database that we will use to load our data into
--CREATE DATABASE TwitterData
--GO

-- Use the newly created database
USE TwitterData
GO

-- Create the table that will hold the tweets
DROP TABLE IF EXISTS Tweets 
CREATE TABLE Tweets (text_id nvarchar(50), text nvarchar(500), selected_text nvarchar(250), sentiment nvarchar(50) )


-- Load the train data from the CSV dataset file into our database
-- An alternative way of doing this would be using the functionality Import Flat File in the Tasks menu

BULK INSERT Tweets
    FROM 'C:\GIT\Blog\_datasets\twitter\train.csv'
    WITH
    (
	    FORMAT = 'CSV', 
		FIELDQUOTE = '"',
		FIRSTROW = 2, -- because the first row has the column titles
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
		ERRORFILE = 'C:\GIT\Blog\_datasets\twitter\errors.csv',
		TABLOCK
    )

