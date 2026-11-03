-- UNION
SELECT  UNNEST([1,1,1,2])
UNION
SELECT UNNEST([1,1,3]);

--UNION ALL

SELECT  UNNEST([1,1,1,2])
UNION ALL
SELECT UNNEST([1,1,3]);

-- INTERSECT

SELECT  UNNEST([1,1,1,2])
INTERSECT
SELECT UNNEST([1,1,3]);

-- INTERSECT ALL
SELECT  UNNEST([1,1,1,2])
INTERSECT ALL
SELECT UNNEST([1,1,3]);

-- EXCEPT
SELECT  UNNEST([1,1,1,2])
EXCEPT
SELECT UNNEST([1,1,3]);


SELECT  UNNEST([1,1,1,2])
EXCEPT ALL
SELECT UNNEST([1,1,3]);


CREATE TEMP TABLE job_2023 AS
SELECT * EXCLUDE(job_id,job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(year FROM job_posted_date) = 2023
LIMIT 1000;

SELECT * FROM job_2023;


CREATE TEMP TABLE job_2024 AS
SELECT * EXCLUDE(job_id,job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(year FROM job_posted_date) = 2024
LIMIT 1000;

SELECT * FROM job_2024;

--which unique job postings appeared in either 2023 or 2024

SELECT 
    'job_2023' AS table_name,
    COUNT(*) AS record_count

FROM job_2023
UNION
SELECT 
    'job_2024' AS table_name,
    COUNT(*)  AS record_count
FROM job_2024;


SELECT * FROM job_2023
UNION
SELECT * FROM job_2024;

--Which job postings appeared across both years counting duplicates ?

SELECT * FROM job_2023
UNION ALL
SELECT * FROM job_2024;

--which job postings appeared in 2024 but not in 2024

SELECT * FROM job_2023
EXCEPT
SELECT * FROM job_2024;


-- which job postings from 2023 remain after subtracting matching 2024 postings, one-for-one ?

SELECT * FROM job_2023
EXCEPT ALL
SELECT * FROM job_2024;


--which job postings appeared in both 2023 and 2024 ?

SELECT * FROM job_2023
INTERSECT
SELECT * FROM job_2024;


-- WHICH job postings appeared in both years , preserving duplicate counts ?

SELECT * FROM job_2023
INTERSECT ALL
SELECT * FROM job_2024;


