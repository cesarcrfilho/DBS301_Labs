/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Oct 03 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Lab05a
---------------------------------------------------------------*/

-- Question 01
-- Display the department name, city, street address and postal code for all departments sorted by city and department name.
SELECT d.department_name AS "Department",
       l.city AS "City",
       l.street_address AS "Street Address",
       l.postal_code AS "Postal Code"
FROM departments d
JOIN locations l
USING (location_id)
ORDER BY 2, 1 ASC;

-- Question 02
-- Display full name of the employees using format of Last, First, their  hire date and salary together with their department name and city,
-- but only for departments which names start with an A or S sorted by department name and employee name
SELECT e.last_name || ', ' || e.first_name AS "Employee",
       e.hire_date AS "Hire Date",
       e.salary AS "Salary",
       d.department_name AS "Department",
       l.city AS "City"
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE d.department_name LIKE 'A%' OR
      d.department_name LIKE 'S%'
ORDER BY 4, 1 ASC;

-- Question 03
-- Display the full name of the manager of each department in states/provinces of Ontario, California 3 and Washington along with the department name,
-- city, postal code and province name.   Sort the output by city and then by department name.
SELECT e.first_name || ' ' || e.last_name AS "Manager",
       d.department_name AS "Department",
       l.city AS "City",
       l.postal_code AS "Postal Code",
       l.state_province
FROM employees e
JOIN departments d
USING (department_id)
JOIN locations l
USING (location_id)
WHERE UPPER(l.state_province) IN('ONTARIO', 'CALIFORNIA', 'WASHINGTON')
ORDER BY 3, 2 ASC;

-- Question 04 a
-- Display employee’s last name and employee number along with their manager’s last name and manager number. Label the columns Employee, Emp#, Manager, and Mgr# respectively.
SELECT e.last_name AS "Employee",
       e.employee_id AS "Emp#",
       m.last_name AS "Manager",
       m.employee_id AS "Mgr#"
FROM employees e
LEFT OUTER JOIN employees m
ON e.manager_id = m.employee_id
ORDER BY 1 ASC;

-- Question 04 b
-- Display customer number, customer name, country_id, country_cd and country name
-- HINT:
-- This will take some thinking as country_id and country_cd are different lengths except UK. But there are others that can be matched such as US to USA. or DE to DEN
SELECT c.cust_no AS "Customer Number",
       c.cname AS "Customer Name",
       co.country_id AS "Country ID",
       c.country_cd AS "Country CD",
       co.country_name AS "Country Name"
FROM customers c
JOIN countries co
ON SUBSTR(c.country_cd, 1, 2) = co.country_id
ORDER BY 2 ASC;