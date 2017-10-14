/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Oct 13 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Lab06
---------------------------------------------------------------*/

-- Question 01
-- This lab doesn't have the first question

-- Question 02
-- Display the last names of all employees who are in the same department as the employee named davies. You need to consider that the name can be input in any mix of case (example AbEl, abel, abEL)
SELECT last_name AS "Last Name"
FROM employees
WHERE department_id = 
                (SELECT DISTINCT(department_id)
                FROM employees
                WHERE UPPER(last_name) = 'DAVIES')
ORDER BY 1 ASC;

-- Question 03
-- Display the first name of the lowest paid employee(s)
SELECT first_name AS "First Name"
FROM employees
WHERE salary = (
                  SELECT MIN(salary)
                  FROM employees
                )
;

-- Question 04
-- Display the city that the highest paid employee(s) are located in.
SELECT l.city AS "City"
FROM locations l
JOIN departments d
ON l.location_id = d.location_id
JOIN employees e
ON d.department_id = e.department_id
WHERE e.salary = (
                    SELECT MAX(salary)
                    FROM employees
                 )
;

-- Question 05
-- Display the last name, salary, department_id of the lowest paid employee(s) in each department as long as the department_id is above 75
SELECT last_name AS "Last Name",
       salary AS "Min. Salary",
       department_id AS "Dpt#"
FROM employees
WHERE (department_id, salary) IN (
                                    SELECT department_id,
                                           MIN(salary)
                                    FROM employees
                                    WHERE department_id > 75
                                    GROUP BY department_id
                                 )
ORDER BY 3 ASC;

-- Question 06
-- Display the last name of the lowest paid employee(s) in each city
SELECT e.last_name AS "Last Name",
       l.city AS "City"
FROM employees e
JOIN departments d
USING(department_id)
JOIN locations l
USING(location_id)
WHERE (salary, city) IN (
                            SELECT MIN(e.salary),
                                   l.city
                            FROM employees e
                            JOIN departments d
                            ON e.department_id = d.department_id
                            JOIN locations l
                            ON d.location_id = l.location_id
                            GROUP BY l.city
                        )
ORDER BY 1 ASC;

-- Question 07
-- Display last name and salary for all employees who earn less than the lowest salary in ANY department.
-- Sort the output by top salaries first and then by last name.
SELECT last_name AS "Last Name",
       salary AS "Salary"
FROM employees
WHERE salary < ANY (
                      SELECT MIN(salary)
                      FROM employees
                      GROUP BY department_id
                   )
ORDER BY 2 DESC, 1 ASC;

-- Question 08
-- Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT Department.
-- Do NOT use Join method.
-- Sort the output by salary ascending first and then by last_name
SELECT last_name AS "Last Name",
       job_id AS "Job Title",
       salary AS "Salary"
FROM employees
WHERE salary IN (
                SELECT salary
                FROM employees
                WHERE department_id = 60
                )
ORDER BY 3 ASC, 1 ASC;

-- Question 09
-- Display the department_id  and lowest salary for any department_id that is a department_id greater than that of Abel
SELECT department_id AS "Dpt#",
       MIN(salary) AS "Min. Salary"
FROM employees
WHERE department_id > ANY (
                        SELECT DISTINCT(department_id)
                        FROM employees
                        WHERE UPPER(last_name) = 'ABEL'
                        )
GROUP BY department_id
ORDER BY 1 ASC;