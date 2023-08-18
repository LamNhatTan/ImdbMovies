--- Top 10 movies ratings all time ---
SELECT TOP 10 *
FROM    [Imdb movies].[dbo].[IMDB Top 250 Movies]
ORDER BY rating DESC

--- Top 10 movies with the highest ratings recently ----
SELECT TOP 10 *
FROM    [Imdb movies].[dbo].[IMDB Top 250 Movies]
ORDER BY [year] DESC, rating DESC

--- Ranking movies by certificate----
SELECT 
        ROW_NUMBER() OVER(PARTITION BY [certificate] Order by [rating] DESC ) as rank,
        [name],
        [rating],
        [certificate],
        [directors]
FROM [Imdb movies].[dbo].[IMDB Top 250 Movies]

---- Total movie per year ----
SELECT  COUNT([name]) as total_movie,
        [year]
FROM [Imdb movies].[dbo].[IMDB Top 250 Movies]
GROUP BY [year]
ORDER BY [total_movie] DESC

---- Best movie per year ----
SELECT 
        sub.name,
        sub.year
FROM
        (SELECT 
                [name],
                [year],
                ROW_NUMBER() OVER(PARTITION BY [year] ORDER BY [rating] DESC) as rank
        FROM    [Imdb movies].[dbo].[IMDB Top 250 Movies]
        ) AS sub
WHERE
        sub.rank = 1

--- Top Movie budgets all time ---
SELECT
        [name],
        [year],
        [budget]
FROM    [Imdb movies].[dbo].[IMDB Top 250 Movies]
WHERE   substring(budget,1,1) IN ('1','2','3','4','5','6','7','8','9')
ORDER BY 
        [budget] DESC

--- Movie budgets per year ---
SELECT
        [name],
        [year],
        [budget],
        ROW_NUMBER()OVER(PARTITION BY [year] ORDER BY [budget] DESC) as rank
FROM    [Imdb movies].[dbo].[IMDB Top 250 Movies]
WHERE   substring(budget,1,1) IN ('1','2','3','4','5','6','7','8','9')