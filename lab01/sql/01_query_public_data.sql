CREATE OR REPLACE TABLE "lab01_dataset.popular_new_york_names" AS 
    SELECT name, gender, SUM(number) AS total_occurrences 
    FROM "bigquery-public-data.usa_names.usa_1910_2013" 
    WHERE state = 'NY' 
    GROUP BY name, gender 
    ORDER BY total_occurrences DESC;