/*

Data Cleaning Steps
1- Remove unnecessary columns
2- Extract the youtube channal names from the first column name
3- Raname the columns name

*/

select * from top_uk_youtubers_2024

select
  NOMBRE,
  total_subscribers,
  total_views,
  total_videos
from 
  top_uk_youtubers_2024

-- CHARINDEX

select CHARINDEX('@' , NOMBRE) , NOMBRE from top_uk_youtubers_2024

-- SUBSTRING

select SUBSTRING(NOMBRE,1, CHARINDEX('@' , NOMBRE) -1 ) from top_uk_youtubers_2024

CREATE VIEW view_uk_youtubers_2024 AS

select 
   CAST(SUBSTRING(NOMBRE,1, CHARINDEX('@' , NOMBRE) -1 ) AS VARCHAR(100)) AS channel_name,
   total_subscribers,
   total_views,
   total_videos
from 
   top_uk_youtubers_2024

/*

# Data Quality tests

1- the data need to be 100 records of youtube channels (row count test)
2- the data needs 4 fields (column count test)
3- the channel name column must be string format and other columns must be numerical data types (data type check)
4- each record must be unique in dataset (duplicate count check)

Row count = 100
Column count = 4

Data Types

channal_name = varchar
total_subscribers = integer 
total_views = integer 
total_videos = integer 

Duplicate count = 0

*/

--1. Row count check

select 
  count(*) as no_of_rows
from 
  view_uk_youtubers_2024

-- 2. Column count check

select
  count(*) as column_count
from
  INFORMATION_SCHEMA.COLUMNS
where
  TABLE_NAME = 'view_uk_youtubers_2024'

--3. Data type check

select
  COLUMN_NAME,
  DATA_TYPE
from
  INFORMATION_SCHEMA.COLUMNS
where
  TABLE_NAME = 'view_uk_youtubers_2024'

--4. Duplicate record check

select 
  channal_name,
  count(*) as duplicate_count
from
  view_uk_youtubers_2024
group by
  channal_name
having
  count(*) > 1




/*

1- Define the variables
2- Create a CTE that rounds the avarge views per video
3- Select Columns that are required for the analysis
4- Filter the results by the YouTube channels with the highest subscriber base
5- Order by net_profit (from highest to lowest)

*/

-- 1.
Declare @conversionRate float = 0.02        --coversion rate @ % 2
Declare @productCost Money = 5.0            --Product cost @ $ 5
Declare @campaignCost Money = 50000.0       --Campaign Cost @ $ 50,000


-- 2.
with ChannelData as(
   select 
      channal_name,
	  total_views,
	  total_videos,
	  Round((CAST(total_views as float) / total_videos) , -4) as rounded_avg_views_per_video,
	  (total_views / total_videos) as original_avg_views_per_video
	from
	YouTube_db.dbo.view_uk_youtubers_2024
)

-- 3.
SELECT
    channal_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM
    ChannelData

-- 4.
WHERE
    channal_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')


-- 5.
ORDER BY
    net_profit DESC


