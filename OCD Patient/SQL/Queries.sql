
-- 1. Count & Pct of F vs M that have OCD & -- Average Obsession Score by Gender

with data as (
   Select 
       Gender, 
	   count(Patient_ID) as patient_count , 
	   avg(Y_BOCS_Score_Obsessions) as avg_obs_score 
	from ocd_patient
    group by Gender
    --order by patient_count
)
select
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_female,

    round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_male
from data


-- 2. Count of Patients by Ethnicity and their respective Average Obsession Score

select
	Ethnicity,
	count(Patient_ID) as patient_count,
	avg(Y_BOCS_Score_Obsessions) as obs_score
From ocd_patient
Group by Ethnicity
Order by patient_count

-- 3. Number of people diagnosed with OCD MoM
-- alter table health_data.ocd_patient_dataset
-- modify `OCD Diagnosis Date` date


SELECT
    FORMAT(OCD_Diagnosis_Date, 'yyyy-MM-01 00:00:00') AS month,
    COUNT(Patient_ID) AS patient_count
FROM ocd_patient
GROUP BY FORMAT(OCD_Diagnosis_Date, 'yyyy-MM-01 00:00:00')
ORDER BY month

-- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score

Select
  Obsession_Type,
  count(Patient_ID) as patient_count,
  round(avg(Y_BOCS_Score_Obsessions),2) as obs_score
from ocd_patient
group by Obsession_Type
Order by patient_count


-- 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score

Select
  Compulsion_Type,
  count(Patient_ID) as patient_count,
  round(avg(Y_BOCS_Score_Obsessions),2) as obs_score
from ocd_patient
group by Compulsion_Type
Order by patient_count



