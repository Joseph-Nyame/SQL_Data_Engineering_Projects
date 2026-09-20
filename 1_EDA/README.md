# Exploratory Data analysis with sql: job market analsis


SQL project analyzing job market using real world job postings. it shows my ability to write production-quality analytical SQL, design efficient queries and turn business questions into data driven insights

![Project 1 Overview](../img/1_1_Project1_EDA.png)


## Executive Summary

- **Project Scope:** Built 3 analytical queries about the data engineer job market

- **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights

- **Analytics:** Applied **aggregation,filtering, and sorting** to find top skills by demand, salary, and overall value

- **Outcone:** Delivered **actionable insights** on sql and python dominance,cloud trends and salary patterns

if you only have a minute, review these:

1. [01_top_demanded.skills.sql](01_top_demanded_skills.sql) - demand analysis with multi-table joins
2. [02_top_paying_skills.sql](02_top_paying_skills.sql) - salary analysis with agregation
1. [03_optimal_skills.sql](03_optimal_skills.sql) - combined demand/salary optimization query

## Problem and Context

Job market analysis need to answer questions like:
- **Most in demand skills** *Which skills are most in-demand for data engineers*
- **highest paid:**  *Which skills command the highest salaries?*
- **Best trade-off:** *Which is the optimal skill set balancing demand and compensation?*

This project analyzes a **data warehouses** built using a star schema design. The warehouse structure consist of 


![data warehouse](../img/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` - Central table containing job posting details (job titles, locations, salaries etc)

- **Dimension Tables:** 
    -`company_dim`- Company information linked to job postings
    -`skills_dim`- Skills catalog with skill names and types
-**Bridge Table:** `skills_job_dim` -Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, i extracted insights about skills demand, salary patterns , and optimal skill combinations for data engineering roles.



## Tech Stack

-**Query engine:** Duckdb for fast OLAP-style analytical queries 

-**Language:** SQL (ANSI-style with analytical functions)

-**Data Model** Star schema with fact + dimension + bridge tables

-**Development** VScode for SQL editing + terminal for duckdb


## Analysis Overview

## Query Structure

1. [Top Demand Skills](01_top_demanded_skills.sql) - identifies the 10 most in demand skills for remote data engineer positions
2. [Top Paying Skills](02_top_paying_skills.sql) - Analyze the highest -paying skills with salary and demand metrics
1. [Optimal Skills](03_optimal_skills.sql) - Calculates and optimal score using natural log og demand combined with the median salary to identify the most valuable skills to learn

## Key Insights
- Core Languages: SQL and python each appear in ~29,000 job postinfs making them the most in demand skills

- Cloud platforms: AWS and Azure are critical for modern data engineering roles
- Infra and tooling: kubernetes,docker and terraform are associated with premium salaries 
- Big data tools: Apache spark shows strong demand with competitive compensation



## SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins**: Multi-table `INNER JOINS` operations across `job_postings_fact`,`skills_job_dim`,`skills_dim`
- **Aggregations**: `COUNT()`,`,MEDIAN()`, `ROUND()` for statistical anaylsis
- **Filterings** : Bolean logic with `WHERE` clauses and multiple conditions (`job_title_short`,`job_work_from_honme`,`salary_year_avg IS NOT NULL`)
- **Sorting and Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

## Data Analysis Techniques

### Grouping
`GROUP BY` for categorical analysis by skill

### Mathematical Functions
`LN()` for natural logarithm transformation to normalize demand metrics

### Calculated Metrics
Derived optimal score combining log-transformed demand with median salary

### HAVING Clause
Filtering aggregated results (skills with >= 100 postings)

### NULL Handling
Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)