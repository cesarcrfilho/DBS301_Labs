/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Sep 26 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Lab03
---------------------------------------------------------------*/

-- Question 02
SELECT TO_CHAR(sysdate + 1, 'Month ddth "of year" YYYY') AS "Tomorrow" 
FROM dual;

-- Question 03
SELECT last_name AS "Last Name",
       first_name AS "First Name",
       salary AS "Salary",
       (salary * 1.07) AS "Good Salary",
       (((salary * 1.07) - salary) * 12) AS "Annual Pay Increase"
FROM employees
WHERE department_id IN(20, 50, 60);

-- Question 04
SELECT UPPER(last_name) || ', ' || UPPER(first_name) || ' is ' || 
CASE job_id
    WHEN 'AC_ACCOUNT' THEN 'Accountant'
    WHEN 'AC_MGR' THEN 'Accounting Manager'
    WHEN 'AC_ASST' THEN 'Accounting Assistant'
    WHEN 'AC_PRES' THEN 'Accounting President'
    WHEN 'AC_VP' THEN 'Accounting Vice-President'
    WHEN 'IT_PROG' THEN 'IT Programmer'
    WHEN 'MK_MAN' THEN 'Marketing Manager'
    WHEN 'MK_REP' THEN 'Marketing Representative'
    WHEN 'SA_MAN' THEN 'Sales Manager'
    WHEN 'SA_REP' THEN 'Sales Representative'
    WHEN 'ST_CLERK' THEN 'Store Clerk'
    WHEN 'ST_MAN' THEN 'Store Manager'
    END AS "Person and Job"
FROM employees
WHERE UPPER(SUBSTR(last_name, -1, 1)) = 'S' AND
      UPPER(SUBSTR(first_name, 1, 1)) IN('C', 'K')
ORDER BY last_name ASC;

-- Question 05
SELECT last_name AS "Last Name",
       hire_date AS "Hire Date",
       ROUND((sysdate - hire_date) / 365) AS "Years Worked"
FROM employees
WHERE hire_date < '01-JAN-1992'
ORDER BY 3 DESC;

-- Question 06
SELECT city AS "City",
       country_id AS "Country Code",
       NVL(state_province, 'Unknown Province') AS "Province Name"
FROM locations
WHERE UPPER(SUBSTR(city, 1, 1)) = 'S' AND
      LENGTH(city) >= 8
ORDER BY city ASC;

-- Question 07
SELECT last_name AS "Last Name",
       hire_date AS "Hire Date",
       TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12), 'TUESDAY'), 'DAY, Month fmDdspth "of year" YYYY') AS "REVIEW DAY"
FROM employees
WHERE hire_date > '31-DEC-1997'
ORDER BY last_name;

-- Question 08
SELECT TO_TIMESTAMP(sysdate)
FROM dual;

-- Question 09
SELECT * 
FROM countries
WHERE UPPER(SUBSTR(country_name, 1, 1)) = UPPER('&COUNTRY');

-- Question 10
SELECT * FROM countries
WHERE UPPER(country_name) LIKE UPPER('&EnterLetter%');