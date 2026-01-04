/*
**Question: What are the most in-demand skills for data analysts?**

- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.

- Why? Retrieves the top 5 skills with the highest demand in the job 
market, providing insights into the most valuable skills for job seekers.
*/

SELECT 
    sd.skills,
    COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 5