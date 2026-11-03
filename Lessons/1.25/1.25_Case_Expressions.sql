--bucket list
--<25 = low
--25 to 50 = medium
-->50 = high

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg <25 THEN 'Low'
        WHEN salary_hour_avg <50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM data_jobs.job_postings_fact
WHERE salary_hour_avg IS NOT NULL
LIMIT 10;
    


--handling missing data (nulls)
--filter null salary values

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg <25 THEN 'Low'
        WHEN salary_hour_avg <50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM data_jobs.job_postings_fact
LIMIT 10;

-- Categorizing categorical values
-- classify the 'job_title' column values as:
   -- 'data analyst'
   -- 'data engineer'
   -- 'data scientist'

SELECT 
    job_title,
    CASE
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'Data Engineer'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category,
    job_title_short,
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;  



--conditional aggregation
--calculate median salaries for different buckets
  -- <$100k
  -- >= $150k;

SELECT
    job_title_short,
    COUNT(*) AS total_postings,
    MEDIAN(
        CASE
            WHEN salary_year_avg <100_000 THEN salary_year_avg
        END
    ) AS median_low_salary,
     MEDIAN(
        CASE
            WHEN salary_year_avg >=100_000 THEN salary_year_avg
        END
    ) AS median_high_salary
FROM data_jobs.job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
LIMIT 10;


-- FINAL example :Conditional calculations
--compute a standardized_salary using yearly salary andn adjusted hourly salary (eg, 2080 hours per year)
--categorize salaries into tiers of 
    -- low (<$50k)
    -- medium ($50k-$100k)
    -- high (>$100k)


WITH salaries AS(
    SELECT
        job_title_short,
        salary_year_avg,
        salary_hour_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
        END AS standardized_salary,
    FROM data_jobs.job_postings_fact
)

SELECT 
    *,
    CASE
        WHEN standardized_salary IS NULL THEN 'Mising'
        WHEN standardized_salary <75_000 THEN 'Low'
        WHEN standardized_salary <150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM salaries
ORDER BY standardized_salary
LIMIT 10;