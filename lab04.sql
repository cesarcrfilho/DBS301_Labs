/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Sep 26 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Lab04
---------------------------------------------------------------*/

-- Question 01
-- 1 Display the difference between the Average pay and Lowest pay in the company.
-- Name this result Real Amount.
SELECT ROUND(AVG(salary) - MIN(salary), 2) AS "Real Amount"
FROM employees;

-- Question 02
-- 2 Display the department number and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.
-- Round the average
-- Sort the output so that the department with highest average salary is shown first.
SELECT NVL(department_id, 0) AS "Department Number",
       MAX(salary) AS "High",
       MIN(salary) AS "Low",
       ROUND(AVG(salary), 2) AS "Avg"
FROM employees
GROUP BY department_id
ORDER BY 4 DESC;

-- Question 03
-- 3 Display how many people work the same job in the same department.
-- Name these results Dept#, Job and How Many.
-- Include only jobs that involve more than one person.
-- Sort the output so that jobs with the most people involved are shown first.
SELECT department_id AS "Dept#",
       job_id AS "Job",
       COUNT(employee_id) AS "How Many"
FROM employees
GROUP BY department_id, job_id
HAVING COUNT(employee_id) > 1
ORDER BY 3 DESC;

-- Question 04
-- 4 For each job title display the job title and total amount paid each month for this type of the job. Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $15,000.
-- Sort the output so that top paid jobs are shown first.
SELECT job_id AS "Job Title",
       SUM(salary) AS "Total Paid"
FROM employees
GROUP BY job_id
HAVING job_id NOT IN('AD_PRES', 'AD_VP') AND
       SUM(SALARY) > 15000
ORDER BY 2 DESC;

-- Question 05
-- 5 For each manager number display how many persons he / she supervises. Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.
-- Sort the output so that manager numbers with the most supervised persons are shown first.
SELECT manager_id AS "Manager Number",
       COUNT(employee_id) AS "Employees"
FROM employees
GROUP BY manager_id
HAVING manager_id NOT IN(100, 101, 102) AND
       manager_id IS NOT NULL AND
       COUNT(employee_id) > 2
ORDER BY 2 DESC;

-- Question 06
-- 6 For each department show the latest and earliest hire date, BUT
-- -exclude departments 10 and 20
-- -also exclude those departments where the last person was hired in this century.
-- -Sort the output so that the most recent, meaning latest hire dates, are shown first.
SELECT department_id AS "Department Number",
       MAX(hire_date) AS "Latest Hire Date",
       MIN(hire_date) AS "Earliest Hire Date"
FROM employees
GROUP BY department_id
HAVING department_id NOT IN(10, 20) AND
       MAX(hire_date) < '01-JAN-01'
ORDER BY 2 DESC;

-- Question 07
-- Show country name and show how many letters each country name has in it and list them from most letters to least letters.
SELECT country_name AS "Country Name",
       LENGTH(country_name) AS "Letters"
FROM countries
ORDER BY 2 DESC;

-- Question 08
-- List all the countries and replace all letter "a"'s with "o"'s.
SELECT REPLACE(country_name, 'a', 'o') AS "Country Name"
FROM countries
ORDER BY 1 ASC;

-- Question 09
-- Show the date 10 days ago.
SELECT sysdate - 10 AS "Date - 10"
FROM DUAL;

-- Question 10
-- What is the date of the 3rd Sunday from today. (Think of how far past you need to go in days BEFORE looking for a Sunday)
SELECT NEXT_DAY(sysdate, 'Sunday') + 14 AS "3rd Sunday from Today"
FROM DUAL;