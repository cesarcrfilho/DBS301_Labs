-- Question 01
-- The HR department needs a list of Department IDs for departments that do not contain
-- the job ID of ST_CLERK> Use a set operator to create this report
SELECT department_id
FROM employees
MINUS
SELECT department_id
FROM employees
WHERE UPPER(job_id) = UPPER('ST_CLERK')
ORDER BY 1;

-- Question 02
-- Same department requests a list of countries that have no departments
-- located in them. Display country ID and the country name. Use SET operators
SELECT country_id, country_name
FROM countries

MINUS

SELECT country_id, country_name
FROM countries c
JOIN locations l
USING(country_id)
JOIN departments d
USING(location_id)
WHERE department_id IS NOT NULL;

-- Question 03
-- This is tricky. The Vice President needs very quickly a list of
-- departments 10, 50, 20 in that order, job and department ID are to be displayed
SELECT DISTINCT job_id, department_id
FROM employees
WHERE department_id = 10

UNION ALL

SELECT DISTINCT job_id, department_id
FROM employees
WHERE department_id = 50

UNION ALL

SELECT DISTINCT job_id, department_id
FROM employees
WHERE department_id = 20;

-- Question 04
-- Create a report that lists the employee IDs and job IDs of those employees
-- who currently have a job title that is the same as their job title when they
-- were initially hired by the company. That means they changed jobs but have now
-- gone back o it. You need to use JOB_HISTORY table as well
-- The result will be ... 176 and 200
SELECT employee_id, job_id
FROM employees

INTERSECT

SELECT employee_id, job_id
FROM job_history
ORDER BY 1;

-- Question 05
-- THE HUMAN RESOURCES DEPARTMENT NEEDS A REPORT WITH TE FOLLOWING SPECIFICATIONS:
-- Last Name and department ID of all the employees in the employee table even if they don't belong to a department yet
-- Department ID and department Name of all the departments in the table departments, even if there are no employees
-- USE a SET operator
SELECT last_name, department_id, TO_CHAR('null') -- I'm using a string here so it's gonna show in the results
FROM employees

UNION

SELECT TO_CHAR('null'), department_id, department_name -- same as above
FROM departments
ORDER BY 1;