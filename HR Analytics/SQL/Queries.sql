

select * from [HR Analytics Data]

--Analysis

UPDATE [HR Analytics Data]
SET Age = REPLACE(Age, '"', '')
select * from [HR Analytics Data]

UPDATE [HR Analytics Data]
SET YearsWithCurrManager = REPLACE(YearsWithCurrManager, '"', '')
select * from [HR Analytics Data]

--check results
SELECT Age , YearsWithCurrManager
FROM [HR Analytics Data]

--age distribution
SELECT
 MIN(Age) AS youngest, MAX(Age) AS OLDEST
FROM [HR Analytics Data]

--gender breakdown in the company
SELECT
 Gender,COUNT(Gender) AS count
FROM [HR Analytics Data]
WHERE YearsAtCompany IS NOT NULL
GROUP BY Gender
ORDER BY Gender ASC

--Total Employee
SELECT COUNT(*) AS total_employees
FROM [HR Analytics Data]

--gender vary across departments and job titles
SELECT 
  Department,Gender , count(Gender) AS count
FROM 
  [HR Analytics Data]
WHERE 
  YearsAtCompany IS NOT NULL
GROUP BY 
  Department, Gender 
ORDER BY 
  Department, Gender ASC 

SELECT 
    Department, JobRole, Gender, COUNT(Gender) AS count
FROM 
    [HR Analytics Data]
WHERE 
    YearsAtCompany IS NOT NULL
GROUP BY 
    Department, JobRole, Gender
ORDER BY 
    Department, JobRole, Gender ASC

--Education distribution in the company
SELECT
  EducationField, count(*) AS count
FROM
  [HR Analytics Data]
WHERE 
  YearsAtCompany IS NOT NULL 
GROUP BY 
  EducationField
ORDER BY count DESC

--Education distribution in the company
SELECT
  BusinessTravel , count(*) AS count
FROM
  [HR Analytics Data]
WHERE 
  YearsAtCompany IS NOT NULL 
GROUP BY 
  BusinessTravel
ORDER BY count DESC

--Marital distribution in the company
SELECT
  MaritalStatus , count(*) AS count
FROM
  [HR Analytics Data]
WHERE 
  YearsAtCompany IS NOT NULL 
GROUP BY 
  MaritalStatus
ORDER BY count DESC

--Job distribution in the company
SELECT
  JobRole , count(*) AS count
FROM
  [HR Analytics Data]
WHERE 
  YearsAtCompany IS NOT NULL 
GROUP BY 
  JobRole
ORDER BY count DESC

--append tables
SELECT 
    a.EmployeeNumber, 
	e.Emplyee_name,
    a.OverTime
FROM 
    [HR Analytics Data] a
INNER JOIN 
    [HR employee data] e
ON 
    a.EmployeeNumber = e.EmployeeNumber


SELECT 
    a.EmployeeNumber, 
	e.Emplyee_name,
    a.OverTime,
	CASE 
	  WHEN OverTime = 1 THEN 'Due for promotion' 
	  WHEN OverTime = 0 THEN 'Will be retrenchment' 
	  ELSE 'other' 
	END AS Action
FROM 
    [HR Analytics Data] a
INNER JOIN 
    [HR employee data] e
ON 
    a.EmployeeNumber = e.EmployeeNumber