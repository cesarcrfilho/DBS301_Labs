/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Oct 03 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Lab05b
---------------------------------------------------------------*/

-- Question 01
-- Display the location id, address, city, state and country for each location id. Be careful of nulls in country_id
SELECT l.location_id AS "Location",
       l.street_address AS "Address",
       l.city AS "City",
       l.state_province AS "State/Province",
       c.country_name AS "Country"
FROM locations l
LEFT JOIN countries c
USING (country_id)
ORDER BY 1;

-- Question 02
-- Display the employee id, last name, job, department name, and job grade for all employees.
-- HINT: You need to consider showing ALL employees
SELECT e.employee_id AS "Emp#",
       e.last_name AS "Last Name",
       e.job_id AS "Job",
       d.department_name AS "Department",
       j.grade AS "Job Grade"
FROM (employees e
LEFT JOIN departments d
USING(department_id)),
job_grades j -- still FROM
WHERE salary BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY 1 ASC;

-- Question 03
-- Display the employee id and last name of every employee along with the name and id of the employee's manager (if applicable).
SELECT e.employee_id AS "Emp#",
       e.last_name AS "Employee",
       m.employee_id AS "Mgr#",
       m.last_name AS "Manager"
FROM employees e
LEFT JOIN employees m
ON m.employee_id = e.manager_id
ORDER BY 1 ASC;

-- Question 04
-- Display the employee id, last name of every employee and the name of the department and city that the employee is assigned to (if applicable). 
-- The display line is long, so it may word wrap a bit.
SELECT e.employee_id AS "Emp#",
       e.last_name AS "Employee",
       d.department_name AS "Department",
       l.city AS "City"
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN locations l
ON d.location_id = l.location_id
ORDER BY 1 ASC;

-- Question 05
-- Display the name of each employee and the city they are assigned to (if applicable).
SELECT e.first_name || ' ' || e.last_name AS "Employee",
       l.city AS "City"
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN locations l
ON d.location_id = l.location_id
ORDER BY 1 ASC;

-- Question 06
-- Display the name of each city and the names of employees assigned to that city (if applicable).
SELECT l.city AS "City",
       e.first_name || ' ' || e.last_name AS "Employee"
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id
RIGHT JOIN locations l
ON d.location_id = l.location_id
ORDER BY 1 ASC;

-- Question 07
-- Display all employees and all cities.
SELECT e.first_name || ' ' || e.last_name AS "Employee",
       l.city AS "City"
FROM employees e
FULL JOIN departments d
ON e.department_id = d.department_id
FULL JOIN locations l
ON d.location_id = l.location_id
ORDER BY 1 ASC;

-- EXTRA QUESTION 8
-- I give you the select you finish it. Sort by customer name. 
-- Because I don't want 1255 rows I need it limited to 20 rows. So add the following to your WHERE statement.
-- AND ROWNUM <= 20
-- Display ... etc 
--select cname, o.order_no, p.Prod_no, prod_name
SELECT cname,
       o.order_no,
       p.Prod_no,
       prod_name
FROM customers c
JOIN orders o
ON c.cust_no = o.cust_no
JOIN orderlines ol
ON o.order_no = ol.order_no
JOIN products p
ON ol.prod_no = p.prod_no
WHERE rownum <= 20
ORDER BY 1 ASC;