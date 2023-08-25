CREATE DATABASE gold_silver;

USE gold_silver;

# Select all data, LIMIT 10 fields
SELECT *
FROM gold_pr
LIMIT 10;

# Knowing type data
DESCRIBE gold_pr;

# Replace character '/' to '-' in column Date
SELECT REPLACE(Date,'/','-') AS Date
FROM gold_pr;

# Replace character '/' to '-' in column Date
UPDATE gold_pr
SET Date = REPLACE(Date,'/','-');

# Change type data from STRING to DATE
UPDATE gold_pr
SET Date = STR_TO_DATE(Date, '%m-%d-%Y');

# Change type data from STRING to DATE
ALTER TABLE gold_pr
MODIFY Date DATE;

# Make new column as YEAR, and fill it with 4 char in DATE column
SELECT *, SUBSTRING(Date, 1, 4) AS Year
FROM gold_pr;

WITH Yr AS (
	SELECT SUBSTRING(Date, 1, 4) AS Year
    FROM gold_pr
)
SELECT Yr.Year, gold_pr.*
FROM gold_pr, Yr
LIMIT 5;

ALTER TABLE gold_pr
ADD COLUMN Year VARCHAR(4) AFTER Date;

UPDATE gold_pr
SET Year = SUBSTRING(Date, 1, 4);

# Make new column as MONTH, and fill it with 2 character from DATE column

SELECT length(Date) as Len_Date
FROM gold_pr;

SELECT *, SUBSTRING(Date, 6,2) AS Month
FROM gold_pr;

ALTER TABLE gold_pr
ADD COLUMN Month VARCHAR(2) AFTER Year;

UPDATE gold_pr
SET Month = SUBSTRING(Date, 6, 2);

# Change column name from CLOSE/LAST into CLOSE

ALTER TABLE gold_pr
CHANGE COLUMN `Close/Last` `Close` Double;

# Viewing maximum price per year

SELECT Year, max(Close) as Max_Last_Price
FROM gold_pr
GROUP BY Year;

SELECT Year, max(Open) as Max_Open_Price
FROM gold_pr
GROUP BY Year;

# Viewing minimum price per year

SELECT Year, min(Close) as Min_Last_Price
FROM gold_pr
GROUP BY Year;

SELECT Year, min(Open) as Min_Open_Price
FROM gold_pr
GROUP BY Year;

# Viewing average price per year

SELECT Year, ROUND(AVG(Close),2) as Average_Price
FROM gold_pr
GROUP BY Year;

#Viewing maximum last price at range 2021-2023

SELECT Year,Month, MAX(Close) as Max_Price
FROM gold_pr
WHERE Year IN (2023,2022,2021)
GROUP BY Year, Month
ORDER BY Year DESC;

# Viewing total gold volume per year

SELECT Year, SUM(Volume) as Total_volume
FROM gold_pr
GROUP BY Year;

# Highest and Lowest price difference at range 2022-2023

SELECT Year, Month, ROUND(MAX(High - Low),2) AS Price_Difference
FROM gold_pr
WHERE Year IN (2022, 2023)
GROUP BY Year, Month;