-- count rows -aggregation only


SELECT 
COUNT(*)
FROM 
    job_postings_fact
LIMIT 50;



-- count rows window function

SELECT
    job_id,
    COUNT(*) OVER ()
FROM 
    job_postings_fact
LIMIT 50;

-- syntax

-- SELECT 
--     column_1
--     window_function() OVER (
--         PARTITION BY <...>
--         ORDER BY <...>
--     ) AS window_column_alias
-- FROM table_name

-- partition by(GROUPS ROWS FOR THE WINDOW CALCULATIONS) -find hourly salary

SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short,company_id
    ) AS avg_hourly_by_title
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 50;


-- Order by(DEFINES THE SEQUENCE OF ROWS WITHIN IN EACH OF THE PARTITION) --ranking hourly salary


SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM job_postings_fact

WHERE salary_hour_avg IS NOT NULL
-- ORDER BY 
--     salary_hour_avg DESC
LIMIT 50;


--  PARTITION BY AND ORDER BY -- running average hourly salary
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL AND job_title_short = 'Data Engineer'
ORDER BY job_title_short,job_posted_date
LIMIT 50;


-- partition by and order by --ranking by job_title_short

SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM job_postings_fact

WHERE salary_hour_avg IS NOT NULL
ORDER BY 
    salary_hour_avg DESC,
    job_title_short
    
LIMIT 50;


-- LAG() time based comparison of company yearly salary(PREVOUS POSTING)
SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    salary_year_avg,
    LAG (salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_posting_salary,
    salary_year_avg - LAG (salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change,

FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY company_id,job_posted_date
LIMIT 60;


-- LEAD() time based comparison of company yearly salary (NEXT POSTING)
SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    salary_year_avg,
    LEAD(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS next_posting_salary,
    salary_year_avg - LEAD(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change,

FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY company_id,job_posted_date
LIMIT 60;


