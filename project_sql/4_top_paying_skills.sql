/* **Answer: What are the top skills based on salary?** 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts 
and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT 
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg),0) AS avg_salary
    --COUNT(sjd.job_id) AS demand_count

FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
ORDER BY
    avg_salary DESC
LIMIT 25