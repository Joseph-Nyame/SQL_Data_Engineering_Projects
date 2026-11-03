SELECT 
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestamptz

FROM job_postings_fact
LIMIT 10;

-- EXRACT function
SELECT
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY EXTRACT(YEAR FROM job_posted_date),
         EXTRACT(MONTH FROM job_posted_date)
ORDER BY job_posted_year, job_posted_month
LIMIT 100;


-- DATE_TRUNC function
SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer' AND 
EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY DATE_TRUNC('month', job_posted_date)
ORDER BY job_posted_month
LIMIT 10;

-- AT TIME ZONE function
SELECT
    '2024-01-01 00:00:00'::TIMESTAMPTZ AT TIME ZONE 'EST';


SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC'  AT TIME ZONE 'EST',
    -- job_posted_date AT TIME ZONE 'America/New_York' AS job_posted
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer' AND job_location LIKE '%New York%'

LIMIT 10;


SELECT
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC'  AT TIME ZONE 'EST') AS job_posted_hour,
    COUNT(job_id) AS job_count
    -- job_posted_date AT TIME ZONE 'America/New_York' AS job_posted
FROM job_postings_fact

WHERE job_title_short = 'Data Engineer' AND job_location LIKE '%New York%'
GROUP BY EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC'  AT TIME ZONE 'EST')
ORDER BY job_posted_hour
LIMIT 10;