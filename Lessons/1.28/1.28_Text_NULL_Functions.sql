-- LENTGH AND COUNT

SELECT LENGTH('SQWL');

-- CASE CONVERSION

SELECT LOWER('SQL');


SELECT UPPER('dwl');

-- substring/extraction


SELECT LEFT('SQL',2);

SELECT RIGHT('SQL',2);


SELECT SUBSTRING('SQL',2,2);

SELECT CONCAT('SQL','-','Function');


SELECT 'SQL' || '-' || 'Functions';


SELECT TRIM(' SQL ');

SELECT REPLACE('SQL','Q','_');

SELECT REGEXP_REPLACE('nyamej19@gmail.com', '^.*(@)','\1');


-- cleanup this using text functions

WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS  job_title_clean
    FROM job_postings_fact

)

SELECT  
    job_title,
    CASE
        WHEN job_title_clean LIKE  '%data%'
            AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%'
            AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        WHEN job_title_clean LIKE '%data%'
            AND job_title_clean LIKE '%engineers' THEN 'Data Engineer'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;


SELECT NULLIF(10,20);

SELECT NULLIF(10,10);


SELECT 
    NULLIF(salary_year_avg,0),
    NULLIF(salary_hour_avg,0)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
ORDER BY salary_year_avg
LIMIT 10;


-- coalesce return first non null value
SELECT COALESCE(0,1,2);

SELECT COALESCE(NULL,1,2);


SELECT 
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg *2080)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL

LIMIT 10;


-- SIMPLIFY WITH COALESCE


SELECT 
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg *2080) AS standardized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg *2080) IS NULL THEN 'Mising'
        WHEN COALESCE(salary_year_avg, salary_hour_avg *2080) <75_000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg *2080) <150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC
LIMIT 10;

