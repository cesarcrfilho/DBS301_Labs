/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Sep 26 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Lab02
---------------------------------------------------------------*/

---- Question 01 ----
-- Display the employee_id, last name and salary of employees earning in the range of $8000 to $15,000.
-- Sort the output by top salaries first and then by last name
SELECT employee_id AS "Employee Id",
       ﻿﻿﻿﻿﻿last_name   ﻿﻿AS "Last Name",
       ﻿﻿﻿﻿﻿﻿﻿﻿salary      ﻿﻿﻿﻿﻿﻿AS "Salary"
FROM employees
WHERE salary BETWEEN 8000 AND 15000
ORDER BY salary, last_name;

---- Question 02 ----
-- Display the employee_id, last name and salary of employees earning in the range of $8000 to $15,000.
-- Sort the output by top salaries first and then by last name.
-- Limit the display to those employees that work as Programmers or Sales Representatives
SELECT employee_id AS "Employee Id",
       last_name   AS "Last Name",
       salary      AS "Salary"
FROM employees
WHERE (salary BETWEEN 8000 AND 15000) AND
      (UPPER(job_id) IN ('IT_PROG', 'SA_REP'))
ORDER BY salary, UPPER(last_name);

---- Question 03 ----
-- The Human Resources department wants to find high salary and low salary employees.
-- Modify the previous query so that it displays the same job titles but for people who earn outside the given salary range from question 1. (8000 to 15000)
-- Use same sorting as before
SELECT employee_id AS "Employee Id",
       last_name   AS "Last Name",
       salary      AS "Salary"
FROM employees
WHERE (salary NOT BETWEEN 8000 AND 15000) AND
      (UPPER(job_id) IN ('IT_PROG', 'SA_REP'))
ORDER BY salary DESC, UPPER(last_name);

---- Question 04 ----
-- The company needs a list of long term employees, in order to give them a thank you dinner. Display the last name, job_id and salary of employees hired before 1998. 
-- List the most recently hired employees first.
-- (Note: you need to know the date format for where you are working – Seneca was  dd-MON-yyyy)
SELECT last_name   AS "Last Name",
       employee_id AS "Employee Id",
       salary      AS "Salary",
       hire_date   AS "Hire Date"
FROM employees
WHERE hire_date < '01-JAN-98'
ORDER BY hire_date DESC;

---- Question 05 ----
-- Modify previous query so that it displays only employees earning more than $10,000. List the output by job title alphabetically and then by highest paid employees.
-- Look at the results carefully. It seems that salary may be out of order.
SELECT last_name, job_id, salary, hire_date
FROM employees
WHERE hire_date < '01-JAN-1998'
AND salary > 10000
ORDER BY job_id, salary DESC;

---- Question 06 ----
-- Display the job titles and full names of employees whose first name or last_name contains an ‘t’ or ‘T’ anywhere
SELECT job_id,
       TRIM(first_name || ' ' || last_name) AS "Full Name"
FROM employees
WHERE UPPER(last_name) LIKE '%T%' OR
      UPPER(first_name) LIKE '%T%'
ORDER BY first_name ASC;

---- Question 07 ----
-- Create a report to display last name, salary, and commission percent for all employees that earn a commission
SELECT last_name, salary, (commission_pct * 100) || '%' AS "Comission %"
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY last_name ASC;

---- Question 08 ----
-- Create a report to display last name, salary, and commission percent for all employees that earn a commission.Put the report in order of descending salaries
SELECT last_name, salary, (commission_pct * 100) || '%' AS "Comission %"
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC;

---- Question 09 ----
-- Using the same criteria as the previous question, use a numeric value to determine the sort order instead of the attribute name
SELECT last_name, salary, (commission_pct * 100) || '%' AS "Comission %"
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY 2 DESC;

---- Question 10 ----
-- Let the president of CMC Outdoor World know many orders there are in the order table
SELECT COUNT(order_no) AS "Number of Orders"
FROM orders;