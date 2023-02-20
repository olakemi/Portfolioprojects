
--
-- PROJECT
--- THE DESIGN AND IMPLEMENTATION OF A PAYROLL DATA MODEL ON A CENTRALIZED LEDGER DATABASE SYSTEM
PROMPT Creating Table 'STAFF'
CREATE TABLE STAFF
 (id INTEGER NOT NULL
 ,NINO VARCHAR2(12) NOT NULL
 ,name VARCHAR2(60) NOT NULL
 ,dob DATE NOT NULL
 ,mobile_no VARCHAR2(12)
 ,email_address VARCHAR2(100)
 ,ppt_id  VARCHAR2(12) NOT NULL
 ,dpt_id  INTEGER NOT NULL
 )
/

PROMPT Creating Table 'DEPARTMENTS'
CREATE TABLE DEPARTMENTS
 (ID   INTEGER NOT NULL
 ,NAME VARCHAR2(60) NOT NULL
 ,LOCATION VARCHAR2(60) NOT NULL )
/


PROMPT Creating Table 'JOB_GRADES'
CREATE TABLE JOB_GRADES
 (CODE  VARCHAR2(12) NOT NULL
 ,DESCRIPTION VARCHAR2(240) NOT NULL
)
/

PROMPT Creating Table 'SCALE_POINTS'
CREATE TABLE SCALE_POINTS
 (CODE        VARCHAR2(12) NOT NULL
 ,DESCRIPTION VARCHAR2(240) NOT NULL
)
/

PROMPT Creating Table 'PROGRESSION_POINTS'
CREATE TABLE PROGRESSION_POINTS
 (ID            VARCHAR2(12) NOT NULL
 ,GRD_CODE      VARCHAR2(12) NOT NULL
 ,SPT_CODE      VARCHAR2(12) NOT NULL
 ,ANNUAL_SALARY NUMBER(12,3) NOT NULL
)
/

-- as hrprj_src
grant select on STAFF   to hrprj_tpl;
grant select on DEPARTMENTS    to hrprj_tpl;
grant select on JOB_GRADES   to hrprj_tpl;
grant select on SCALE_POINTS  to hrprj_tpl;
grant select on PROGRESSION_POINTS   to hrprj_tpl;



----TO DELETE TABLES & CONSTRAINTS
DROP TABLE Departments CASCADE CONSTRAINTS;
DROP TABLE SCALE_POINTs CASCADE CONSTRAINTS;
DROP TABLE PROGRESSION_POINTs CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Job_Grades CASCADE CONSTRAINTS;



--
-- as hrprj_src
--

PROMPT Creating Primary Key on 'STAFF'
ALTER TABLE STAFF
 ADD (CONSTRAINT STF_PK PRIMARY KEY 
  (ID))
/

PROMPT Creating Unique Key on 'STAFF'
ALTER TABLE STAFF
ADD (CONSTRAINT STF_UK UNIQUE
    (NINO))
/

PROMPT Creating Primary Key on 'DEPARTMENTS'
ALTER TABLE DEPARTMENTS
 ADD (CONSTRAINT DPT_PK PRIMARY KEY 
  (ID))
/

PROMPT Creating Unique Key on 'DEPARTMENTS'
ALTER TABLE DEPARTMENTS
ADD (CONSTRAINT DPT_UK UNIQUE
   (NAME))
/

PROMPT Creating Primary Key on 'JOB_GRADES'
ALTER TABLE JOB_GRADES
 ADD (CONSTRAINT GRD_PK PRIMARY KEY 
  (CODE))
/

PROMPT Creating Primary Key on 'SCALE_POINTS'
ALTER TABLE SCALE_POINTS
 ADD (CONSTRAINT SPT_PK PRIMARY KEY 
  (CODE))
/

PROMPT Creating Primary Key on 'PROGRESSION_POINTS'
ALTER TABLE PROGRESSION_POINTS
 ADD (CONSTRAINT PPT_PK PRIMARY KEY 
  (ID))
/

PROMPT Creating Unique Key on 'PROGRESSION_POINTS'
ALTER TABLE PROGRESSION_POINTS
ADD (CONSTRAINT PPT_UK UNIQUE
    (GRD_CODE,SPT_CODE))
/


PROMPT Creating Foreign Key on 'STAFF'
ALTER TABLE STAFF ADD (CONSTRAINT
 STF_DPT_FK FOREIGN KEY 
  (DPT_ID) REFERENCES DEPARTMENTS
  (ID))
/

PROMPT Creating Foreign Key on 'STAFF'
ALTER TABLE STAFF ADD (CONSTRAINT
 STF_PPT_FK FOREIGN KEY 
  (PPT_ID) REFERENCES PROGRESSION_POINTS
  (ID))
/

PROMPT Creating Foreign Key on 'STAFF'
ALTER TABLE PROGRESSION_POINTS ADD (CONSTRAINT
 PPT_SPT_FK FOREIGN KEY 
  (SPT_CODE) REFERENCES SCALE_POINTS
  (CODE))
/

ALTER TABLE PROGRESSION_POINTS ADD (CONSTRAINT
 PPT_GRD_FK FOREIGN KEY 
  (GRD_CODE) REFERENCES JOB_GRADES
  (CODE))
/

-- as hrprj_src
grant select on STAFF   to hrprj_tpl;
grant select on DEPARTMENTS    to hrprj_tpl;
grant select on JOB_GRADES   to hrprj_tpl;
grant select on SCALE_POINTS  to hrprj_tpl;
grant select on PROGRESSION_POINTS   to hrprj_tpl;


-------Setting time context----------
exec dbms_systime.set_trans_time();
exec dbms_systime.set_specified_time();
exec dbms_systime.set_valid_time();

------------------------------------
-----use the "exec gen" command to reset the data or after an update on the schema or when you iterate around your design ----

exec gen;

------checking valid time----
SELECT  to_char(dbms_systime.get_valid_time(),'DD-MON-YYYY HH24:MI') FROM dual;

------view table (using the "_z") showing the metadata (YTS)when a row was created, updated, or deleted. SOE (start of existence) & sov(start of version) shows the logically start time as set by the user on the ld8a framework
------ eoe (end of existence) null indicates that it has not be deleted yet
   
--------VIEWS--------------
  
----RELATIONAL CURRENT VIEW-----
---For a known transaction and valid time
select * from job_grades;
select * from departments;
select * from scale_points;
select * from progression_points;
select * from staff;


-----Current view with metadata(Z)
------view table (using the "_z") showing the metadata (YTS)when a row was created, updated, or deleted. SOE (start of existence) & sov(start of version) shows the logically start time as set by the user on the ld8a framework
------ eoe (end of existence) null indicates that it has not be deleted yet

-----Current view with metadata(Z)
select * from departments_z;
select * from job_grades_z;
select * from scale_points_z;
select * from progression_points_z;
select * from staff_z;

-----Last known state (L)
select * from progression_points_l;
select * from departments_l;
select * from job_grades_l;
select * from scale_points_l;
select * from progression_points_l;
select * from staff_l;

-----Last known state (L)
select * from staff_l;



-------Valid time history (Y)
select * from staff_y;
select * from departments_y;
select * from job_grades_y;
select * from scale_points_y;
select * from progression_points_y;


Valid time history (Y)order by start of variance)
select * from departments_y
order by sov;


------Transaction time history (x)
select * from departments_x;
select * from job_grades_x;
select * from scale_points_x;
select * from progression_points_x;
select * from staff_x;


------Event  history (e)
select * from departments_e;
select * from job_grades_e;
select * from scale_points_e;
select * from progression_points_e;
select * from staff_e;

------All history (a)
select * from departments_a;
select * from job_grades_a;
select * from scale_points_a;
select * from progression_points_a;
select * from staff_a;


-----more views
select * from departments_x
order by yts;

select * from departments_e
order by yts;

select * from departments_a
order by yts, sov;


-----staff 195- Acostamadiedo Maria was moved up the scale point on 1/12016 to University Lecturer on scale point 2
 exec dbms_systime.set_valid_time(to_date('01-JAN-2016','DD-MON-YYYY'));
  update Staff
  set ppt_id = 'ULPPTS2'
  where id = 195; 
---checking the current view with metadata
SELECT id,name,ppt_id,yts,soe,sov,eoe
FROM Staff_y
WHERE id = 195
; 


----/ *Alter insert time of staff 198*/
 exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
  update Staff_z 
  set soe = '01-JAN-2014'
  where id = 198;
 -----------using the event history view
 SELECT *
FROM staff_e
WHERE id = 198; 

   ---------All Staff on RASPT2 (Research Assistance on scale point 2 were given a 10% raise on 1/9/2015
exec dbms_systime.set_valid_time(to_date('01-SEP-2015','DD-MON-YYYY'));
UPDATE progression_points
SET annual_salary=annual_salary*1.10 
      WHERE spt_code='RASPT2';
      
Select spt_code,annual_salary,soe,sov
From progression_points_y
 WHERE spt_code='RASPT2'; 
 
 
----------STAFF 201 details were removed from UVO on 19/MAY/2020
 exec dbms_systime.set_valid_time(to_date('19-MAY-2020','DD-MON-YYYY'));
 Delete Staff where id = 201;
 ------Using the event history view
 SELECT*
 FROM STAFF_e
 WHERE id = 201
 
 
 
 ------/* STAFF 200- Abajian Michael John  resigned/
 exec dbms_systime.set_valid_time(to_date('01-JAN-2017','DD-MON-YYYY'));
  update Staff_z 
  set eoe = '02-SEP-2018'
  where id = 200;
 
 SELECT *
FROM staff_e
WHERE id = 200
; 
  
 ----undelete----------------- 
 ------/alter insert eoe(end of existence) of STAFF 200- Abajian Michael John
 exec dbms_systime.set_valid_time(to_date('01-JAN-2017','DD-MON-YYYY'));
  update Staff_z 
  set eoe = null
  where id = 200;
 
 SELECT *
FROM staff_e
WHERE id = 200
;   


-----LIST ALL STAFF DETAILS WHOSE HIRE DATE IS BEFORE 2017
SELECT * 
FROM staff_z
WHERE EXTRACT(YEAR FROM soe) < 2017;

-------Find the sum of the salaries , the maximum salary, the minimum salary, and the average salary earned by staff
select sum(annual_salary),max(annual_salary), min(annual_salary),avg(annual_salary)
from progression_points_z;


------Referential integrity-----
-----Insertion of data into departments, job grades,progression points ,scale_points tables
exec dbms_systime.set_valid_time(to_date('01-SEP-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(3, 'Big Data Analytics', 'Millennium point Building');  
INSERT INTO Job_grades (code, description) 
VALUES ('S1', 'Support');
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT1', 'Support1 scale point 1');
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES ('S1PPTS1', 'S1', 'S1SPT1', 18542);
-----Insertion of data into staff table
exec dbms_systime.set_valid_time(to_date('01-SEP-2014','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (191, 'A6453468', 'Olakemi Oyekan',  DATE '1975-02-18', 07851625890, 'bukzy2006@gmail.com', 'S1PPTS2', 3);
  
  Select * From departments;
  Select * From staff;

------Referential integrity-----
-----Insertion of data into departments, job grades,progression points ,scale_points tables
exec dbms_systime.set_valid_time(to_date('01-SEP-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(3, 'Big Data Analytics', 'Millennium point Building');  
INSERT INTO Job_grades (code, description) 
VALUES ('S1', 'Support');
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT1', 'Support1 scale point 1');
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES ('S1PPTS1', 'S1', 'S1SPT1', 18542);
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (191, 'A6453468', 'Olakemi Oyekan',  DATE '1975-02-18', 07851625890, 'bukzy2006@gmail.com', 'S1PPTS1', 3);
----UPDATE STAFF 191
exec dbms_systime.set_valid_time(to_date('3-SEP-2015','DD-MON-YYYY'));
update staff
set dpt_id = 3 
where id = 191;

--------Setting Transaction time-----------
exec gen;

prompt Report to show state of system as known at Transaction Time
prompt ===========================================================
select dbms_systime.get_trans_time as "Transaction Time"
from   DUAL;


spool S1.log

set echo off
prompt ******************************************************************
prompt * Tables are as follows:
prompt ******************************************************************
set echo on
set lines 80

desc DEPARTMENTS
desc STAFF
desc JOB_GRADES
desc PROGRESSION_POINTS
desc SCALE_POINTS


set echo off
prompt ******************************************************************
prompt * Generate the Schema
prompt ******************************************************************
set echo on
set lines 2000


set echo off
prompt ******************************************************************
prompt * Set Defaults / Initialise
prompt ******************************************************************
set echo on

alter session set nls_timestamp_tz_format = 'DD-MON-YYYY HH24:MI:SS';
alter session set nls_timestamp_format    = 'DD-MON-YYYY HH24:MI:SS';
alter session set nls_date_format         = 'DD-MON-YYYY HH24:MI:SS';

exec dbms_systime.set_valid_time;

exec dbms_systime.set_trans_time;

set echo off
---- INSERT VALUES INTO DEPARTMENTS  TABLE
set echo on
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES (1, 'Cyber Security', 'Steamhouse');

exec dbms_lock.sleep(1);
INSERT INTO Departments (id, name, location) 
VALUES (2, 'Business Intelligence', 'Millennium point Building');

exec dbms_lock.sleep(1);
INSERT INTO Departments (id, name, location) 
VALUES(3, 'Big Data Analytics', 'Millennium point Building');

exec dbms_lock.sleep(1);
INSERT INTO Departments (id, name, location) 
VALUES(4, 'Computer Science', 'SteamHouse');

exec dbms_lock.sleep(1);
INSERT INTO Departments (id, name, location) 
VALUES(5, 'Data Network and Security', 'SteamHouse');

exec dbms_lock.sleep(1);
INSERT INTO Departments (id, name, location) 
VALUES(6, 'User Experience Design', 'Millennium point Building');

exec dbms_lock.sleep(1);
INSERT INTO Departments (id, name, location) 
VALUES(7, 'User Enterprise System Management', 'Royal Birmingham Conservatoire');


---JOB GRADES TABLE 
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES ('S1', 'Support');
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S2', 'Support');
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S3', 'Support');
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S4', 'Support');
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S5', 'Support');
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S6', 'Support');
-

----SCALE_POINTS TABLE

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT1', 'Support1 scale point 1');
exec dbms_lock.sleep(1);

INSERT INTO Scale_points (code, description) 
VALUES('S1SPT2', 'Support1 scale point 2');

exec dbms_lock.sleep(1);
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT3', 'Support1 scale point 3');

exec dbms_lock.sleep(1);
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT4', 'Support1 scale point 4');

exec dbms_lock.sleep(1);
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT1', 'Support2 scale point 1');

exec dbms_lock.sleep(1);
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT2', 'Support2 scale point 2');

exec dbms_lock.sleep(1);
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT3', 'Support2 scale point 3');

-------------------------

---PROGRESSION_POINTS TABLE
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES ('S1PPTS1', 'S1', 'S1SPT1', 18542);

exec dbms_lock.sleep(1);
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S1PPTS2', 'S1', 'S1SPT2', 18542);

exec dbms_lock.sleep(1);
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S1PPTS3', 'S1', 'S1SPT3', 18542);

exec dbms_lock.sleep(1);
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S1PPTS4', 'S1', 'S1SPT4', 18542);
exec dbms_lock.sleep(1);
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS1', 'S2', 'S2SPT1', 18542);

exec dbms_lock.sleep(1);
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS2', 'S2', 'S2SPT2', 18542);

exec dbms_lock.sleep(1);
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS3', 'S2', 'S2SPT3', 19031);

--------------------------------------

---STAFF TABLE
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (200, 'A5350088', 'Bailly Jacques', DATE '1985-10-04', 07901736505, 'bailly.jacques@yahoo.com', 'S2PPTS3', 3);
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (201, 'A0351163', 'Abajian Michael John',  DATE '1988-04-04', 07501846302, 'abajianm@yahoo.com', 'S2PPTS1', 1);
exec dbms_lock.sleep(1);
exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (202, 'A8356107', 'Anathy Vikas', DATE '1990-11-30', 07101866328, 'anathy.vikas@yahoo.com', 'S1PPTS1', 2);
exec dbms_lock.sleep(1);



exec dbms_lock.sleep(1);

select * 
from  Staff
order by name;


select * from Staff;

set echo off

prompt ******************************************************************
prompt * RECORD - 03/09/15
prompt ******************************************************************
set echo on

-- pretend "now" in real time is the transaction date "03/09/15" in the record

variable tt_before_03_09_15 VARCHAR2(25)

begin
  :tt_before_03_09_15 := LOCALTIMESTAMP;
end;
/

print :tt_before_03_09_15

set echo off

prompt ******************************************************************
prompt * INTENT - Event Date 01/09/15 
prompt ******************************************************************
set echo on


exec dbms_systime.set_valid_time(to_date('01-SEP-2015','DD-MON-YYYY'));
select dbms_systime.get_valid_time from dual;

INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (194, 'A5456474', 'Adair Elizabeth Carol', DATE '1979-05-02', 07512627893, 'lizacarol@hotmail.com', 'S1PPTS3', 3);
exec dbms_lock.sleep(1);
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (192, 'A2453261', 'Adler Abigail Rhodes',  DATE '1978-09-11', 07411627896, 'adler.rhodes@gmail.com', 'S1PPTS4', 1);

exec dbms_lock.sleep(1);
SELECT P.ID,
       to_char(p.annual_salary, 'L999,999')AS "ANNUAL SALARY",
      P.GRD_CODE,
      P.SPT_CODE,
       S.NAME,
       d.id as "dept id",
       d.name as "department",
       s.email_address AS "EMAIL ADDRESS"
FROM staff s, departments d, progression_points p
WHERE s.dpt_id = d.id
AND s.ppt_id = p.id
ORDER BY s.name ASC;

set echo off

prompt ******************************************************************
prompt * INTENT - Event Date 02/09/15 (Fill)
prompt ******************************************************************
set echo on
  ---------All Staff on RASPT2 (Research Assistance on scale point 2 were given a 10% raise on 1/9/2015
exec dbms_systime.set_valid_time(to_date('02-SEP-2015','DD-MON-YYYY'));
  update Staff_z 
  set eoe = null
  where id = 200; 
exec dbms_lock.sleep(1);
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (203, 'A6356112', 'Abaied Jamie', DATE '1993-02-09', 07401867191, 'abaiedj93@yahoo.co.uk', 'S1PPTS1', 1);
exec dbms_lock.sleep(1);
set echo off
prompt ******************************************************************
prompt * INTENT - Event Date 03/09/15 
prompt ******************************************************************
set echo on
exec dbms_systime.set_valid_time(to_date('03-SEP-2015','DD-MON-YYYY'));

   /* STAFF 200- Abajian Michael John  end of service at UVO was wrongly effected in the records as 1/jan/2017*/
 exec dbms_systime.set_valid_time(to_date('03-SEP-2015','DD-MON-YYYY'));
  update Staff 
  set name = 'Adebukola Akanle',
      email_address = 'Adebuk2000@yahoo.com'
  where id = 203
  and dpt_id = 1;
exec dbms_lock.sleep(1);  
variable tt_after_03_09_15 VARCHAR2(25)

begin
  :tt_after_03_09_15 := LOCALTIMESTAMP;
end;
/

set echo off



  
prompt ******************************************************************
prompt * RECORD - 03/01/15
prompt ******************************************************************
select P.ID,
       to_char(p.annual_salary, 'L999,999')AS "ANNUAL SALARY",
      P.GRD_CODE,
      P.SPT_CODE,
       S.NAME,
       S.EMAIL_ADDRESS AS "EMAIL ADDRESS",
      S.DOB as age
from   PROGRESSION_POINTS P,
      STAFF S
where  P.ID = S.PPT_ID;

set echo off 
set echo on

-- pretend "now" in real time is the transaction date "03/01/15" in the record

variable tt_after_03_01_15 VARCHAR2(25)

begin
  :tt_after_03_01_15 := LOCALTIMESTAMP;
end;
/

set echo off veri off feed off

prompt ******************************************************************
prompt * Item History Reports
prompt ******************************************************************
set echo on
set lines 2000

exec dbms_systime.set_valid_time;

set echo off
exec dbms_systime.set_trans_time(:tt_before_03_09_15)

 
prompt ******************************************************************
prompt * Item History Reports
prompt ******************************************************************
set echo on
set lines 2000

exec dbms_systime.set_valid_time;

set echo off
exec dbms_systime.set_trans_time(:tt_before_03_09_15) 
prompt
prompt +++++++++++++++++        Before 03/09/2015         ++++++++++++++++++++++
prompt

select P.ID,
       to_char(p.annual_salary, 'L999,999')AS "ANNUAL SALARY",
      P.GRD_CODE,
      P.SPT_CODE,
       S.NAME,
       S.EMAIL_ADDRESS AS "EMAIL ADDRESS",
      S.DOB as age
from   PROGRESSION_POINTS P,
      STAFF S
where  P.ID = S.PPT_ID;

exec dbms_systime.set_trans_time(:tt_after_01_09_15) 
prompt
prompt +++++++++++++++++        After  01_09_15         ++++++++++++++++++++++
prompt

select P.ID,
       to_char(p.annual_salary, 'L999,999')AS "ANNUAL SALARY",
      P.GRD_CODE,
      P.SPT_CODE,
       S.NAME,
       S.EMAIL_ADDRESS AS "EMAIL ADDRESS",
      S.DOB as age
from   PROGRESSION_POINTS P,
      STAFF S
where  P.ID = S.PPT_ID;

---------------INSERTING TABLES---------------------

---DEPARTMENTS  TABLE

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES (1, 'Cyber Security', 'Steamhouse');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES (2, 'Business Intelligence', 'Millennium point Building');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(3, 'Big Data Analytics', 'Millennium point Building');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(4, 'Computer Science', 'SteamHouse');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(5, 'Data Network and Security', 'SteamHouse');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(6, 'User Experience Design', 'Millennium point Building');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Departments (id, name, location) 
VALUES(7, 'User Enterprise System Management', 'Royal Birmingham Conservatoire');



---JOB GRADES TABLE 

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES ('S1', 'Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S2', 'Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S3', 'Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S4', 'Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S5', 'Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('S6', 'Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('SO1', 'Senior Officer Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('SO2', 'Senior Officer Support');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('MA1', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('MA2', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('MA3', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));;
INSERT INTO Job_grades (code, description) 
VALUES('MA4', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('MA5', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('MA6', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('MA7', 'Management');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('RA', 'Research Assistance/Assistance Lecturer');


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('UL', 'Lecturer');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('USL', 'Senior Lecturer');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('SAP', 'Senior Academic Professional');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Job_grades (code, description) 
VALUES('PROF', 'Professorial Grade');




----SCALE_POINTS TABLE


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT1', 'Support1 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT2', 'Support1 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT3', 'Support1 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S1SPT4', 'Support1 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT1', 'Support2 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));;
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT2', 'Support2 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT3', 'Support2 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S2SPT4', 'Support2 scale point 4');


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S3SPT1', 'Support3 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S3SPT2', 'Support3 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S3SPT3', 'Support3 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S3SPT4', 'Support3 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S4SPT1', 'Support4 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S4SPT2', 'Support4 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S4SPT3', 'Support4 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S4SPT4', 'Support4 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S5SPT1', 'Support5 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S5SPT2', 'Support5 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S5SPT3', 'Support5 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S5SPT4', 'Support5 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S6SPT1', 'Support6 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S6SPT2', 'Support6 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S6SPT3', 'Support6 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('S6SPT4', 'Support6 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO1SPT1', 'Senior Support Officer1 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO1SPT2', 'Senior Support Officer1 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO1SPT3', 'Senior Support Officer1 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO1SPT4', 'Senior Support Officer1 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO2SPT1', 'Senior Support Officer2 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO2SPT2', 'Senior Support Officer2 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO2SPT3', 'Senior Support Officer2 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SO2SPT4', 'Senior Support Officer2 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA1SPT1', 'Management1 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA1SPT2', 'Management1 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA1SPT3', 'Management1 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA1SPT4', 'Management1 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA2SPT1', 'Management2 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA2SPT2', 'Management2 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA2SPT3', 'Management3 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA2SPT4', 'Management4 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA3SPT1', 'Management3 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA3SPT2', 'Management3 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA3SPT3', 'Management3 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA3SPT4', 'Management3 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA4SPT1', 'Management4 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA4SPT2', 'Management4 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA4SPT3', 'Management4 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA4SPT4', 'Management4 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA5SPT1', 'Management5 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA5SPT2', 'Management5 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA5SPT3', 'Management5 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA5SPT4', 'Management5 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA6SPT1', 'Management6 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA6SPT2', 'Management6 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA6SPT3', 'Management6 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA6SPT4', 'Management6 scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA7SPT1', 'Management7 scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA7SPT2', 'Management7 scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA7SPT3', 'Management7 scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('MA7SPT4', 'Management7 scale point 4');

---TEACHING STAFF

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('RASPT1', 'Research Assistance scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('RASPT2', 'Research Assistance scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('RASPT3', 'Research Assistance scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('RASPT4', 'Research Assistance scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('ULSPT1', 'Lecturer scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('ULSPT2', 'Lecturer scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('ULSPT3', 'Lecturer scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('ULSPT4', 'Lecturer scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('USLSPT1', 'Senior Lecturer scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('USLSPT2', 'Senior Lecturer scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('USLSPT3', 'Senior Lecturer scale point 3');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('USLSPT4', 'Senior Lecturer scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SAPSPT1', 'Senior Academic Professional scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SAPSPT2', 'Senior Academic Professional scale point 2');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SAPSPT3', 'Senior Academic Professional scale point 3');


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('SAPSPT4', 'Senior Academic Professional scale point 4');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('PROFSPT1', 'Professor scale point 1');

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Scale_points (code, description) 
VALUES('PROFSPT2', 'Professor scale point 2');




---PROGRESSION_POINTS TABLE


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES ('S1PPTS1', 'S1', 'S1SPT1', 18542);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S1PPTS2', 'S1', 'S1SPT2', 18542)

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S1PPTS3', 'S1', 'S1SPT3', 18542);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S1PPTS4', 'S1', 'S1SPT4', 18542);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS1', 'S2', 'S2SPT1', 18542);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS2', 'S2', 'S2SPT2', 18542);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS3', 'S2', 'S2SPT3', 19031);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S2PPTS4', 'S2', 'S2SPT4', 19518);


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S3PPTS1', 'S3', 'S3SPT1', 19614);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S3PPTS2', 'S3', 'S3SPT2', 20253);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S3PPTS3', 'S3', 'S3SPT3', 20786);


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S3PPTS4', 'S3', 'S3SPT4', 21318);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S4PPTS1', 'S4', 'S4SPT1', 22369);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S4PPTS2', 'S4', 'S4SPT2', 23098);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES ('S4PPTS3', 'S4', 'S4SPT3', 23706);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S4PPTS4', 'S4', 'S4SPT4', 24313);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S5PPTS1', 'S5', 'S5SPT1', 25234);


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S5PPTS2', 'S5', 'S5SPT2', 26056);


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S5PPTS3', 'S5', 'S5SPT3', 26742);


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S5PPTS4', 'S5', 'S5SPT4', 27428);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('S6PPTS1', 'S6', 'S6SPT1', 27817);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S6PPTS2', 'S6', 'S6SPT2', 28726);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('S6PPTS3', 'S6', 'S6SPT3', 29480);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('S6PPTS4', 'S6', 'S6SPT4', 30236);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO1PPTS1', 'SO1', 'SO1SPT1', 30856);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO1PPTS2', 'SO1', 'SO1SPT2', 31862);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO1PPTS3', 'SO1','SO1SPT3', 32700);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO1PPTS4', 'SO1', 'SO1SPT4', 33539);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO2PPTS1', 'SO2', 'SO2SPT1', 36072);


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('SO2PPTS2', 'SO2', 'SO2SPT2', 37247);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO2PPTS3', 'SO2', 'SO2SPT3', 38229);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SO2PPTS4', 'SO2', 'SO2SPT4', 39209);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA1PPTS1', 'MA1', 'MA1SPT1', 41093);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA1PPTS2', 'MA1', 'MA1SPT2', 42433);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA1PPTS3', 'MA1', 'MA1SPT3', 43550);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA1PPTS4', 'MA1', 'MA1SPT4', 44666);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA2PPTS1', 'MA2', 'MA2SPT1', 46500);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA2PPTS2', 'MA2', 'MA2SPT2', 48018);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA2PPTS3', 'MA2', 'MA2SPT3', 49281);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA2PPTS4', 'MA2', 'MA2SPT4', 50545);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA3PPTS1', 'MA3', 'MA3SPT1', 53442);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA3PPTS2', 'MA3', 'MA3SPT2', 55163);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA3PPTS3', 'MA3', 'MA3SPT3', 56615);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA3PPTS4', 'MA3', 'MA3SPT4', 58067);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA4PPTS1', 'MA4', 'MA4SPT1', 61766);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA4PPTS2', 'MA4', 'MA4SPT2', 63781);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA4PPTS3', 'MA4', 'MA4SPT3', 65459);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA4PPTS4', 'MA4', 'MA4SPT4', 67137);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA5PPTS1', 'MA5', 'MA5SPT1', 72636);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA5PPTS2', 'MA5', 'MA5SPT2', 75004);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA5PPTS3', 'MA5', 'MA5SPT3', 76979);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA5PPTS4', 'MA5', 'MA5SPT4', 78953);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA6PPTS1', 'MA6', 'MA6SPT1', 83359);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA6PPTS2', 'MA6', 'MA6SPT2', 86076);  

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA6PPTS3', 'MA6', 'MA6SPT3', 88342);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA6PPTS4', 'MA6', 'MA6SPT4', 90606);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA7PPTS1', 'MA7', 'MA7SPT1', 83359);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));;
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('MA7PPTS2', 'MA7', 'MA7SPT2', 86076);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA7PPTS3', 'MA7', 'MA7SPT3', 88342);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('MA7PPTS4', 'MA7', 'MA7SPT4', 90606);

----TEACHING STAFF

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('RAPPTS1', 'RA', 'RASPT1', 31762);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('RAPPTS2', 'RA', 'RASPT2', 32799);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('RAPPTS3', 'RA', 'RASPT3', 33660);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('RAPPTS4', 'RA', 'RASPT4', 34525);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('ULPPTS1', 'UL', 'ULSPT1', 38639);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('ULPPTS2', 'UL', 'ULSPT2', 39898);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('ULPPTS3', 'UL', 'ULSPT3', 40949);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('ULPPTS4', 'UL', 'ULSPT4', 41998);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('USLPPTS1', 'USL', 'USLSPT1', 47778);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('USLPPTS2', 'USL', 'USLSPT2', 49334);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('USLPPTS3', 'USL', 'USLSPT3', 50663);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('USLPPTS4', 'USL', 'USLSPT4', 51931);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SAPPPTS1', 'SAP', 'SAPSPT1', 56756);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES ('SAPPPTS2', 'SAP', 'SAPSPT2', 58605);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SAPPPTS3', 'SAP', 'SAPSPT3', 60148);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('SAPPPTS4', 'SAP', 'SAPSPT4', 61690);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary)  
VALUES('PROFPPTS1', 'PROF', 'PROFSPT1', 63016);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Progression_points (id, grd_code, spt_code, annual_salary) 
VALUES('PROFPPTS2', 'PROF', 'PROFSPT2', 108448);



---STAFF TABLE


exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (192, 'A2453261', 'Adler Abigail Rhodes',  DATE '1978-09-11', 07411627896, 'adler.rhodes@gmail.com', 'PROFPPTS2', 1);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address , ppt_id ,dpt_id )
VALUES (193, 'A3456462', 'Adeniyi Aderonke Oluponle', DATE '1977-09-01', 07512627893, 'ade.ponle@yahoo.com', 'SAPPPTS1', 2);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (194, 'A5456474', 'Adair Elizabeth Carol', DATE '1979-05-02', 07512627893, 'lizacarol@hotmail.com', 'USLPPTS1', 3);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (195, 'A94584701', 'Acostamadiedo Jose Maria',  DATE '1982-05-02',  07312727897, 'joseacosta@yahoo.co.uk', 'ULPPTS1', 1);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (196, 'A2359478', 'Abernathy Mac Wilson',  DATE '1984-10-04', 07711729892, 'abernawil@yahoo.co.uk', 'RAPPTS1', 6);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (196, 'A2359478', 'Abernathy Mac Wilson', DATE '1984-10-04', 07711729892, 'abernawil@yahoo.co.uk', 'RAPPTS3', 1);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (197, 'A0359670', 'Almstead Laura', DATE '1986-06-23', 07101729398, 'laura.almstead@gmail.com', 'MA1PPTS1', 5);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (198, 'A1350673', 'Abdul-Karim Yasmeen', DATE '1984-08-03', 07201749394, 'abdul.yasmeen@gmail.com', 'MA1PPTS1', 5);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (199, 'A4350077', 'Abbott John',  DATE '1986-09-12', 07901746303, 'abbott86@hotmail.com', 'SO1PPTS1', 3);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (200, 'A5350088', 'Bailly Jacques', DATE '1985-10-04', 07901736505, 'bailly.jacques@yahoo.com', 'SO1PPTS1', 3);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (201, 'A0351163', 'Abajian Michael John',  DATE '1988-04-04', 07501846302, 'abajianm@yahoo.com', 'S2PPTS1', 1);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (202, 'A8356107', 'Anathy Vikas', DATE '1990-11-30', 07101866328, 'anathy.vikas@yahoo.com', 'S1PPTS1', 2);

exec dbms_systime.set_valid_time(to_date('01-JAN-2015','DD-MON-YYYY'));
INSERT INTO Staff (id, nino, name, dob, mobile_no, email_address, ppt_id, dpt_id )
VALUES (203, 'A6356112', 'Abaied Jamie', DATE '1993-02-09', 07401867191, 'abaiedj93@yahoo.co.uk', 'S1PPTS1', 1);

