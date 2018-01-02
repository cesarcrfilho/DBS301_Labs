/*--------------------SENECA COLLEGE-----------------------------
Student     : Cesar Rodrigues
Student ID  : 127381168
Email       : cda-conceicao-rodrig@myseneca.ca
Date        : Jan 02 2017
Class       : DBS301 - Database Design II and SQL Using Oracle
Description : Assignment 02
---------------------------------------------------------------*/
-- 1
-- Division Table
CREATE TABLE division (
    division_id     NUMBER(3) NOT NULL,
    division_name   VARCHAR(25) UNIQUE NOT NULL,
    CONSTRAINT division_pk PRIMARY KEY (division_id) USING INDEX
    
);

-- Warehouse
CREATE TABLE warehouse (
    warehouse_id NUMBER(3) NOT NULL,
    city         VARCHAR(15) UNIQUE NOT NULL,
    rating       CHAR(1),
    found_date   DATE NOT NULL,
    division_id  NUMBER(3) NOT NULL,
    CONSTRAINT warehouse_pk PRIMARY KEY (warehouse_id) USING INDEX,
    CONSTRAINT warehouse_division_fk FOREIGN KEY (division_id) REFERENCES division (division_id),
    CONSTRAINT warehouse_rating_ck CHECK (rating IN ('A', 'B', 'C', 'D'))
);

-- Section
CREATE TABLE section (
    warehouse_id NUMBER(3) NOT NULL,
    section_id   NUMBER(2) NOT NULL,
    description  VARCHAR(50) NOT NULL,
    capacity     NUMBER(8),
    CONSTRAINT section_pk PRIMARY KEY (warehouse_id, section_id) USING INDEX,
    CONSTRAINT section_warehouse_fk FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id)
);

INSERT INTO division VALUES (10, 'East Coast');
INSERT INTO division VALUES (20, 'Quebec');
INSERT INTO division VALUES (30, 'Ontario');

INSERT INTO warehouse VALUES (1, 'Montreal', 'A', SYSDATE, 10);
INSERT INTO warehouse VALUES (7, 'Fredericton', 'B', SYSDATE, 10);
INSERT INTO warehouse VALUES (10, 'Toronto', 'A', SYSDATE, 30);

INSERT INTO section VALUES (1, 1, 'Whse 1 Floor 1', 2000);
INSERT INTO section VALUES (1, 2, 'Whse 1 Floor 2', 500);
INSERT INTO section VALUES (7, 1, 'Whse 7 Floor 1', 15000);


COMMIT;

-- 2
ALTER TABLE section
ADD mgr_id NUMBER(6);

ALTER TABLE section
ADD CONSTRAINT section_mgr_id_fk
FOREIGN KEY (mgr_id) REFERENCES employees (employee_id);
    
-- 3
ALTER TABLE warehouse DROP CONSTRAINT warehouse_rating_ck;

ALTER TABLE warehouse
ADD CONSTRAINT warehouse_rating_ck
CHECK (rating IN ('A', 'B', 'C', 'D', 'F'));

-- 4
CREATE SEQUENCE whse_id_seq
    START WITH 320
    INCREMENT BY 15
    MAXVALUE 900
    NOCACHE
    NOCYCLE;
    
-- 5
INSERT INTO warehouse (warehouse_id, city, found_date, division_id) VALUES
(whse_id_seq.NEXTVAL, 'Atlanta', sysdate, 30);

COMMIT;

-- 6
CREATE TABLE cities AS
    SELECT * FROM locations
    WHERE location_id < 2000
;

-- 7
DESCRIBE cities;

-- 8
SELECT * FROM cities;

-- 9
CREATE VIEW whssec_man_vu AS (
    SELECT 
        S.warehouse_id,
        S.section_id,
        W.city,
        D.division_name AS "Group",
        E.last_name AS "LName"
    FROM
        section S
        JOIN warehouse W ON 
            S.warehouse_id = W.warehouse_id
        JOIN division D ON
            W.division_id = D.division_id
        LEFT JOIN employees E ON
            S.mgr_id = E.employee_id
);

-- 10
SELECT * FROM whssec_man_vu;

-- 11
CREATE OR REPLACE VIEW whssec_man_vu AS -- ...

-- 12
SELECT * FROM locations
MINUS
SELECT * FROM cities;

-- 13
UNION
-- 14
UNION ALL
-- 15
INTERSECT
-- 16
MINUS
