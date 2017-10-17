/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Oct 17 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Assignment 01
---------------------------------------------------------------*/

-- 01) Display the customer number, customer name and country code for all the customers that are in . The country code for Germany is GER. 
-- Please note that the user could have used GER, ger, GeR or any combination and not Germany.
SELECT cust_no    AS "Customer Number",
       cname      AS "Customer Name",
       country_cd AS "Country Code"
FROM customers
WHERE UPPER(country_cd) = UPPER('GER)'
ORDER BY 1 ASC;

-- 02) Display the customer number for Ultra Sports 5.
SELECT cust_no AS "Customer Number"
FROM customers
WHERE TRIM(UPPER(cname)) = TRIM(UPPER('Ultra Sports 5'));

-- 03) List the customer number, customer name and order number for customers that ordered product 40303. Put result in customer number order.
SELECT c.cust_no    AS "Customer Number",
       c.cname      AS "Customer Name",
       o.order_no   AS "Order No."
FROM customers c
JOIN orders o
ON c.cust_no = o.cust_no
JOIN orderlines ol
ON o.order_no = ol.order_no
WHERE ol.prod_no = 40303
ORDER BY 1 ASC;

-- 04) How many orders have the product number 40302?
SELECT COUNT(order_no) AS "Count"
FROM orderlines
WHERE prod_no = 40302;

-- 05) Display all orders for United Kingdom. 
-- The word entered is United Kingdom and not UK. 
-- Show only cities that start with L.
-- Display the customer number, customer name, order number, product name, the total dollars for that line. 
-- Give that last column the name of TOTAL. 
-- Put the output into customer number order from highest to lowest 
-- and display only order numbers less than 75
SELECT c.cust_no       AS "Customer Number",
       c.cname         AS "Customer Name",
       o.order_no      AS "Order No.",
       p.prod_name     AS "Product Name",
       '$ ' || (ol.price * ol.qty) AS "TOTAL"
FROM products p
JOIN orderlines ol
ON p.prod_no = ol.prod_no
JOIN orders o
ON ol.order_no = o.order_no
JOIN customers c
ON o.cust_no = c.cust_no
JOIN countries co
ON c.country_cd = co.country_id
WHERE TRIM(UPPER(co.country_name)) = TRIM(UPPER('United Kingdom')) AND
      o.order_no < 75 AND
      c.city LIKE 'L%'
ORDER BY 2 DESC;

-- 06) Display a count of how many different country codes there are
SELECT COUNT(country_id) AS "Count"
FROM countries;

-- 07) Find the total dollar value for all orders from London. Each row will show customer name, order number and total dollars for the order. Sort by order number
SELECT c.cname    AS "Customer Name",
       o.order_no AS "Order No.",
       '$ ' || SUM(ol.price * ol.qty) AS "TOTAL"
FROM customers c
JOIN orders o
ON c.cust_no = o.cust_no
JOIN orderlines ol
ON o.order_no = ol.order_no
WHERE UPPER(c.city) = UPPER('London')
GROUP BY c.cname, o.order_no
ORDER BY 2 ASC;

-- 08) Display the (a) employee number, (b) full employee name, (c) job and (d) hire date.
-- - Limit the display to all employees hired in May, June, July, August or December 
-- of any year. 
-- - The most recently hired employees are displayed first. 
-- - Exclude people hired in 1992 to 1997. 
-- - Full name should be in the form ?  Lastname, Firstname  -- with an alias called Full Name.
-- - Hire date should point to the last day in May, June, July, August or December of that year (NOT to the exact hire date) 
-- - The format is in the form of May 31st of 1997 –better if there is no big gap between month and 31st
-- - The hire date column should be called Start Date. 
-- NOTE: Do NOT use a LIKE operator. 
-- You should display ONE row per output line by limiting the width of the Full Name to 25 characters. 
SELECT employee_id AS "Emp#",
       last_name || ', ' || first_name AS "Full Name",
       CASE job_id
           WHEN 'AC_ACCOUNT' THEN 'Public Accountant'
           WHEN 'AC_MGR' THEN 'Accounting Manager'
           WHEN 'AD_ASST' THEN 'Administration Assistant'
           WHEN 'AD_PRES' THEN 'President'
           WHEN 'AD_VP' THEN 'Administration Vice President'
           WHEN 'IT_PROG' THEN 'Programmer'
           WHEN 'MK_MAN' THEN 'Marketing Manager'
           WHEN 'MK_REP' THEN 'Marketing Representative'
           WHEN 'SA_MAN' THEN 'Sales Manager'
           WHEN 'SA_REP' THEN 'Sales Representative'
           WHEN 'ST_CLERK' THEN 'Stock Clerk'
           WHEN 'ST_MAN' THEN 'Stock Manager'
       END AS "Job",
       TO_CHAR(LAST_DAY(hire_date),'FMMonth ddth "of" YYYY') AS "Start Date"
FROM employees
WHERE (hire_date < '01-JAN-1992' OR hire_date > '31-DEC-1997') AND
      TO_CHAR(hire_date, 'MM') IN ('05', '06', '07', '12')
ORDER BY hire_date DESC;

-- 09) List the employee number, full name, job and the modified salary for all employees
-- - whose monthly earning (without the increase) is outside the range $6,000 – $11,000
-- - and who are employed as a Vice Presidents or Managers (President is not counted here).
--  	- You should use Wild Card characters for this. 
-- - the modified salary for a VP will be 20% higher 
-- - and managers a 30% salary increase.
-- - Sort the output by the top salaries (before this increase).
-- Heading will be: ?	Employees with Increased Pay
-- The output lines should look like this sample line:
-- Employee 101 named Neena Kochhar with Job ID of AD_VP will have a new salary of $22100
SELECT 'Employee ' || employee_id ||
       ' named ' || first_name || ' ' || last_name ||
       ' with Job ID of ' || job_id ||
       ' will have a new salary of $' ||
       CASE 
           WHEN job_id LIKE '%_VP%' THEN (salary * 1.20)
           WHEN job_id LIKE '%_MAN%' THEN (salary * 1.30)
       END AS "Employees with Increased Pay"
FROM employees
WHERE (salary NOT BETWEEN 6000 AND 11000) AND
      (job_id LIKE '%_VP%' OR job_id LIKE '%_MAN%')
ORDER BY salary DESC;

-- 10) Display last_name, job id and salary for all employees who earn more than all lowest paid employees per department that are in locations outside the US.
-- Exclude President and Vice Presidents from this query.
-- Sort the output by job id ascending.
-- If a JOIN is needed you must use a “newer” method (USING/JOIN)
SELECT last_name AS "Last Name",
       job_id    AS "Job",
       salary    AS "Salary"
FROM employees
WHERE salary > ALL (
                    SELECT MIN(salary)
                    FROM employees e
                    JOIN departments d USING(department_id)
                    JOIN locations l USING(location_id)
                    WHERE UPPER(l.country_id) != 'US'
                    GROUP BY department_id
                   )
AND (job_id NOT LIKE '%_VP%' AND job_id NOT LIKE '%_PRES%')
ORDER BY 2 ASC;

-- 11) Who are the employees (show last_name, salary and job) who work either in IT , ACCOUNTING or MARKETING department and earn more than the worst paid person in the SHIPPING department. 
-- Sort the output by the last name alphabetically.
-- You need to use ONLY the Subquery method (NO joins allowed).
SELECT last_name AS "Last Name",
       salary    AS "Salary",
       job_id    AS "Job"
FROM employees
WHERE salary > (
                SELECT MIN(salary)
                FROM employees
                WHERE department_id = (
                                       SELECT DISTINCT(department_id)
                                       FROM departments
                                       WHERE UPPER(department_name) = 'SHIPPING'
                                      )
               ) AND
department_id IN (
                  SELECT department_id
                  FROM departments
                  WHERE UPPER(department_name) IN ('IT', 'ACCOUNTING', 'MARKETING')
                 )
ORDER BY 1 ASC;


-- 12) Display Department_id, Job_id and the Lowest salary for this combination but only if that Lowest Pay falls in the range $6000 - $18000. 
-- Exclude people who 
--	(a) work as some kind of Representative job from this query and 
--	(b) departments IT and SALES 
--Sort the output according to the Department_id and then by Job_id.
--          You MUST NOT use the Subquery method.
SELECT department_id AS "Department",
       job_id AS "Job",
       MIN(salary) AS "Lowest Salary"
FROM employees e
JOIN departments d USING (department_id)
WHERE salary BETWEEN 6000 AND 18000 AND
      UPPER(d.department_name) NOT IN ('IT', 'SALES') AND
      UPPER(e.job_id) NOT LIKE '%_REP%'
GROUP BY department_id, job_id
ORDER BY 1 ASC, 2 ASC;