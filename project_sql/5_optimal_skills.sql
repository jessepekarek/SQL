/*

 **Answer: What are the most optimal skills to learn 
(aka it’s in high demand and a high-paying skill) for a data analyst?** 

- Identify skills in high demand and associated with high average salaries 
for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and 
financial benefits (high salaries), offering strategic insights for career development in data analysis
*/

SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg),0) AS avg_salary
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL AND
    jpf.job_work_from_home = TRUE
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 10;



--The query below is showing how to complete this with CTEs
/*
WITH skills_demand AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM job_postings_fact jpf
        INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id
),

average_salary AS (
    SELECT
        sjd.skill_id,
        AVG(jpf.salary_year_avg) AS avg_salary
    FROM job_postings_fact jpf
        INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY
        sjd.skill_id
)

SELECT
    sd.skills,
    sd.demand_count,
    ROUND(avgs.avg_salary, 2) AS avg_salary
FROM skills_demand sd
    INNER JOIN average_salary avgs 
    ON sd.skill_id = avgs.skill_id
--WHERE 
--    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT
    10;
*/