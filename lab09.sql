-- Question 01
-- Display the names of the employees whose salary is the same as the lowest salaried employee in any department.
SELECT last_name
FROM employees
WHERE salary = (
                SELECT MIN(salary)
                FROM employees
                )
ORDER BY 1;

-- Question 02
-- Display the names of the employee(s) whose salary is the lowest in each department
SELECT last_name
FROM employees
WHERE (department_id, salary) IN (
                                  SELECT department_id, MIN(salary)
                                  FROM employees
                                  GROUP BY department_id
                                  )
ORDER BY 1;

-- Question 03
-- Give each of the employees in question 2 a $100 bonus
UPDATE employees
SET salary = salary + 100
WHERE last_name IN
(
SELECT last_name
FROM employees
WHERE (department_id, salary) IN (
                                  SELECT department_id, MIN(salary)
                                  FROM employees
                                  GROUP BY department_id
                                  )
);

-- Question 04
-- Create a view named ALLEMPS that consists of all employees includes
-- employee_id, last_name, salary, department_id, department_name, city and country (if applicable)
CREATE VIEW allemps AS
SELECT e.employee_id, e.last_name, e.salary, department_id, d.department_name, l.city, c.country_name
FROM employees e
JOIN departments d USING (department_id)
JOIN locations l USING (location_id)
JOIN countries c USING (country_id);

-- Question 05
-- Use the ALLEMPS view to:
-- Display the employee_id, last_name, salary and city for all employees 
SELECT employee_id, last_name, salary, city
FROM allemps
ORDER BY 1;
-- Display the total salary of all employees by city 
SELECT city, SUM(salary)
FROM allemps
GROUP BY city
ORDER BY 1;
-- Increase the salary of the lowest paid employee(s) in each department by 100 
UPDATE allemps
SET salary = salary + 100
WHERE last_name IN
(
SELECT last_name
FROM employees
WHERE (department_id, salary) IN (
                                  SELECT department_id, MIN(salary)
                                  FROM employees
                                  GROUP BY department_id
                                  )
);
-- What happens if you try to insert an employee by providing values for all columns in this view? 
INSERT INTO allemps VALUES
(999, 'Cesar Rodrigues', 2000, 999, 'Void', 'Toronto', 'Canada');
-- Delete the employee named Vargas. Did it work? Show proof.
-- Error: ORA-01776: cannot modify more than one base table through a join view

-- Question 06
-- Create a view named ALLDEPTS that consists of all departments and includes
-- department_id, department_name, city and country (if applicable) 
CREATE VIEW alldepts AS
SELECT department_id, department_name, city, country_name
FROM departments
JOIN locations USING (location_id)
JOIN countries USING (country_id);

-- Question 07
-- Use the ALLDEPTS view to:
-- For all departments display the department_id, name and city
SELECT department_id, department_name, city
FROM alldepts
ORDER BY 1;
-- For each city that has departments located in it, display the number of departments by city 
SELECT city, COUNT(department_id)
FROM alldepts
GROUP BY city
ORDER BY 1;

-- Question 08
-- Create a view called ALLDEPTSUMM that consists of all departments and includes
-- for each department: department_id, department_name, number of employees, number of salaried employees, total salary of all employees.
-- Number of Salaried must be different from number of employees. The difference is some get commission.
CREATE VIEW alldeptsum AS
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "TOTAL_EMPLOYEES",
       COUNT(c.employee_id) AS "SALARIED",
       SUM(e.salary) AS "TOTAL_SALARY"
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN employees c -- comission employees
ON e.employee_id = c.employee_id AND
c.commission_pct IS NULL
GROUP BY d.department_id, d.department_name;



-- Question 09
-- Use the ALLDEPTSUMM view to display department name and number of employees
-- for departments that have more than the average number of employees
SELECT department_name, total_employees
FROM alldeptsum
WHERE total_employees > (
                        SELECT AVG(total_employees)
                        FROM alldeptsum
                        )
ORDER BY 1;

-- Question 10
-- Use the GRANT statement to allow another student (Neptune account )
-- to retrieve data for your employees table and to allow them to retrieve,
-- insert and update data in your departments table. Show proof
GRANT SELECT ON employees TO dbs301_173a15;
GRANT SELECT, INSERT, UPDATE ON departments TO dbs301_173a15;

-- Question 11
-- Use the REVOKE statement to remove permission for that student to insert and update data in your departments table
REVOKE SELECT ON employees FROM dbs301_173a15;
REVOKE SELECT, INSERT, UPDATE ON departments FROM dbs301_173a15;