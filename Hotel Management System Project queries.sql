
----Sessions Timings--------------------------------------
--Set data format-----------------------------------------
--SYSTEM FORMAT  DD-MON-RR
---CHECK PC DATE FORMAT
/* CHECK THE PC DATE FORMAT
--Set date format
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
SELECT SYSDATE FROM dual;
--Set timestamp format
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='YYYY-MM-DD HH24:MI:SS';
SELECT systimestamp FROM dual;

ALTER SESSION SET NLS_TIMESTAMP_FORMAT='HH24:MI:SS';
SELECT systimestamp FROM dual;
--The user must first set the date and time to a specific format.





----------HOTEL DATABASE CREATION-------------------------
--Hotel_Zazuu database was created.

--------------------TABLE CREATION------------------------
----------------------------------------------------------

--------TO CREATE TABLE HOTEL_CHAIN----------

CREATE TABLE hotel_chain(
   hotelchainID NUMBER (15) NOT NULL PRIMARY KEY,
   hotelchainname VARCHAR2 (45)NOT NULL,
   hotelchaincontactno VARCHAR2 (12) NOT NULL,
   hotelchainemailadd VARCHAR2 (45)NOT NULL,
   hotelchainwebsite VARCHAR2 (45) NOT NULL,
   addressid NUMBER (15) NOT NULL
)

------TO ALTER TABLE--------------------
ALTER TABLE hotel_chain ADD FOREIGN KEY (addressid)
REFERENCES address(addressid);


----------TO DROP TABLE-----------------
DROP TABLE hotel_chain CASCADE CONSTRAINTS;
DROP TABLE hotel_chain;


----------TO CREATE TABLE ADDRESS--------

CREATE TABLE address(
  addressid NUMBER (15) PRIMARY KEY NOT NULL,
  addressline1 VARCHAR2(100) NOT NULL,
  addressline2 VARCHAR2 (100) NOT NULL,
  city VARCHAR2 (45) NOT NULL,
  state VARCHAR2 (45) NOT NULL,
  country VARCHAR2 (45) NOT NULL
)

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE address CASCADE CONSTRAINTS;
DROP TABLE address;


---TO CREATE TABLE CUSTOMER--------------

CREATE TABLE customer (
  customerID NUMBER (15) NOT NULL PRIMARY KEY,
  customerFname VARCHAR2 (45) NOT NULL,
  customerLname VARCHAR2 (45) NOT NULL,
  customercontactno VARCHAR2 (12) NOT NULL,
  customeremailadd VARCHAR2 (45) NOT NULL,
  customercreditcard VARCHAR2(45) NOT NULL,
  customeridproof VARCHAR2 (45) NOT NULL,
  addressid NUMBER (15) NOT NULL
)

---TO ALTER TABLE-----------------------
ALTER TABLE customer ADD FOREIGN KEY (addressid)
REFERENCES address(addressid);

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE customer CASCADE CONSTRAINTS;
----TO DROP TABLE-----------------------
DROP TABLE customer;


---TO CREATE TABLE TRANSACTION-----------

CREATE TABLE transaction (
  transactionID NUMBER (15) NOT NULL PRIMARY KEY,
  transactionname VARCHAR2 (45) NOT NULL,
  hotelID NUMBER (15) NOT NULL,
  reservationID NUMBER (15)NOT NULL,
  paymentID NUMBER (15) NOT NULL,
  transactiondescription VARCHAR2 (100) NOT NULL,
  transactioncost DECIMAL (10,2) NOT NULL,
  transactiondate DATE NOT NULL
)

---TO ALTER TABLE----------------------------

ALTER TABLE transaction ADD FOREIGN KEY (reservationID)
REFERENCES reservation(reservationID);
ALTER TABLE transaction ADD FOREIGN KEY (hotelID)
REFERENCES hotel(hotelID);
ALTER TABLE transaction ADD FOREIGN KEY (paymentID)
REFERENCES payment(paymentID);

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE transaction CASCADE CONSTRAINTS;
DROP TABLE transaction;


---TO CREATE TABLE PAYMENT-------------------

CREATE TABLE payment(
  paymentID NUMBER (15) NOT NULL PRIMARY KEY,
  paymentdate DATE NOT NULL,
  paymenttype VARCHAR2(45) NOT NULL
)

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE payment CASCADE CONSTRAINTS;



---TO CREATE TABLE HOTEL--------------------

CREATE TABLE hotel (
  hotelID NUMBER (15) NOT NULL PRIMARY KEY,
  hotelwebsite VARCHAR2 (45) NOT NULL,
  hoteldescription VARCHAR2 (45) NOT NULL,
  hotelfloorcount NUMBER (12) NOT NULL,
  hotelemailadd VARCHAR2 (45) NOT NULL,
  hotelname VARCHAR2 (45) NOT NULL,
  checkintime TIMESTAMP NOT NULL,
  checkouttime TIMESTAMP NOT NULL,
  hotelcontactno VARCHAR2 (45) NOT NULL,
  hotelroomcapacity NUMBER (15) NOT NULL,
  addressid NUMBER (15) NOT NULL
)

---TO ALTER TABLE----------------------------
ALTER TABLE hotel ADD FOREIGN KEY (addressid)
REFERENCES address(addressid);


----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE hotel CASCADE CONSTRAINTS;
DROP TABLE hotel;


---TO CREATE TABLE EMPLOYEES-----------------------

CREATE TABLE employees (
  employeeID NUMBER (15) NOT NULL PRIMARY KEY,
  employeedesignation VARCHAR2 (45) NOT NULL,
  departmentID NUMBER (15) NOT NULL,
  hotelID NUMBER (15) NOT NULL,
  addressid NUMBER (15) NOT NULL,
  employeeFname VARCHAR2 (45) NOT NULL,
  employeeLname VARCHAR2 (45) NOT NULL,
  employeecontactno VARCHAR2 (12) NOT NULL,
  employeeemailadd VARCHAR2 (45) NOT NULL
)

---TO ALTER TABLE-------------
ALTER TABLE employees ADD FOREIGN KEY (departmentID)
REFERENCES department(departmentID);
ALTER TABLE employees ADD FOREIGN KEY (addressid)
REFERENCES address(addressid);
ALTER TABLE employees ADD FOREIGN KEY (hotelID)
REFERENCES hotel(hotelID);

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE employees;


---TO CREATE TABLE ROOM-----------

CREATE TABLE room (
  roomID NUMBER (15) NOT NULL PRIMARY KEY,
  roomname VARCHAR2 (45) NOT NULL,
  roomdescription VARCHAR2 (100) NOT NULL,
  roomtypeID NUMBER (15) NOT NULL,
  hotelID NUMBER (15) NOT NULL
)

---TO ALTER TABLE
ALTER TABLE room ADD FOREIGN KEY (roomtypeID)
REFERENCES roomtype(roomtypeID);
ALTER TABLE room ADD FOREIGN KEY (hotelID)
REFERENCES hotel(hotelID);

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE room CASCADE CONSTRAINTS;


---TO CREATE TABLE ROOMTYPE-----------

CREATE TABLE roomtype (
  roomtypeID NUMBER (15) NOT NULL PRIMARY KEY,
  roomtypename VARCHAR2 (45) NOT NULL,
  roomcost DECIMAL (10,2) NOT NULL,
  roomtypedescription VARCHAR2 (45) NOT NULL,
  smokefriendly VARCHAR2 (45) NOT NULL,
  petfriendly VARCHAR2 (45) NOT NULL
)


----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE roomtype CASCADE CONSTRAINTS;




---TO CREATE TABLE DEPARTMENT--------------

CREATE TABLE department (
  departmentID NUMBER (15) NOT NULL PRIMARY KEY,
  departmentname VARCHAR2 (45) NOT NULL,
  departmentdescription VARCHAR2 (100) NOT NULL
)

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE department CASCADE CONSTRAINTS;


---TO CREATE TABLE RESERVATION--------------

CREATE TABLE reservation (
  reservationID NUMBER (15) NOT NULL PRIMARY KEY,
  reservationdate DATE NOT NULL,
  checkindate DATE NOT NULL,
  employeeID NUMBER (15) NOT NULL,
  hotelID NUMBER (15) NOT NULL,
  customerID NUMBER (15) NOT NULL,
  checkoutdate DATE NOT NULL,
  paymenttype VARCHAR2 (45) NOT NULL,
  totalroombooked VARCHAR2 (45) NOT NULL,
  daysrange VARCHAR2 (45) NOT NULL,
  totalamount DECIMAL (10,2) NOT NULL
)

---TO ALTER TABLE--------------
ALTER TABLE reservation ADD FOREIGN KEY (hotelID)
REFERENCES hotel(hotelID);
ALTER TABLE reservation ADD FOREIGN KEY (customerID)
REFERENCES customer(customerID);
ALTER TABLE reservation ADD FOREIGN KEY (employeeID)
REFERENCES employees(employeeID);

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE reservation CASCADE CONSTRAINTS;


---TO CREATE TABLE HOTELCHAIN_HAS_HOTEL----------

CREATE TABLE hotelchain_has_hotel (
 hotelchain_has_hotelID NUMBER (15) NOT NULL PRIMARY KEY,
 hotelchainID NUMBER (15) NOT NULL,
 hotelID NUMBER (15) NOT NULL
)

---TO ALTER TABLE----------------
ALTER TABLE hotelchain_has_hotel ADD FOREIGN KEY (hotelchainID)
REFERENCES hotel_chain(hotelchainID);
ALTER TABLE hotelchain_has_hotel ADD FOREIGN KEY (hotelID)
REFERENCES hotel(hotelID);

----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE hotelchain_has_hotel CASCADE CONSTRAINTS;


---TO CREATE TABLE ROOM_RESERVED----------------

CREATE TABLE room_reserved (
  room_reservedID NUMBER (15) NOT NULL PRIMARY KEY,
  reservationID NUMBER (15) NOT NULL,
  roomID NUMBER (15) NOT NULL
)

---TO ALTER TABLE----------------
ALTER TABLE room_reserved ADD FOREIGN KEY (reservationID)
REFERENCES reservation(reservationID);
ALTER TABLE room_reserved ADD FOREIGN KEY (roomID)
REFERENCES room(roomID);


----TO DROP TABLE AND ROMOVE CONSTRAINTS-------------------------
DROP TABLE room_reserved CASCADE CONSTRAINTS;





--------CREATING CHECK ON PAYMENT TABLE------------
ALTER TABLE payment ADD CONSTRAINT paymenttype_ok
CHECK ((paymenttype BETWEEN cash AND card));

--------CREATING CHECK ON ROOMTYPE TABLE------------
ALTER TABLE roomtype ADD CONSTRAINT roomcost_ok
CHECK (roomcost > 0);

---------CREATING CHECK ON HOTEL TABLE-----------------
ALTER TABLE hotel ADD CONSTRAINT checkoutime_ok
CHECK (checkouttime > checkintime);



--------------------INSERT COMMANDS-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------


-------------------------------------- TABLE ADDRESS----------------------------------------------

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(1,49, 'Dave Street', 'Kitchener','ON','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country) 
VALUES(2,64, 'Victoria Street', 'Kitchener','ON','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country) 
VALUES(3,79, 'Connaught Street', 'London','ON','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country) 
VALUES(4,45, 'Sweden St. Street', 'London','ON','Canada');
INSERT INTO address (addressid, addressline1, addressline2, city, state, country) 
VALUES(5,60, 'Lincoln Street', 'Guelph','ON','Canada');
INSERT INTO address (addressid, addressline1, addressline2, city, state, country) 
VALUES(9,32, 'Gandhi Road', 'Mumbai','Maharashtra','India');
INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(7,8033, 'King George Boulevard', 'Surrey','BC','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(10,706, 'Idle rd', 'Saskatoon','SK','Bangladesh');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(11,45, 'Vanier Park', 'Kitchener','ON','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(12,41, 'Greenfield', 'London','ON','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(13,89, 'Jacob Rd', 'Paris','ON','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(14,85, 'Martin Street', 'Ottawa','BC','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(15,78, 'Josseph St. Street', 'Guelph','BC','Canada');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(16,156, 'James Road', 'Boston','AZ','USA');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(17,7598, 'Atomic Street', 'Ottawa','New York','USA');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(18,5476, 'Saint Jake Rd', 'Chicago','San Jose','USA');

INSERT INTO address (addressid, addressline1, addressline2, city, state, country)
VALUES(19,7465, 'Thames Rd', 'Nashville','Gujarat','India');


SELECT* FROM address;

----------------------------TABLE HOTEL_CHAIN---------------------------------

INSERT INTO hotel_chain (hotelchainID, hotelchainname, hotelchaincontactno, hotelchainemailadd, hotelchainwebsite, addressid)
VALUES (1,'Zazuu best western hotels', 456-865-8956,'bw123@gmail.com', 'https://www.bestwestern.com/', 3);---
INSERT INTO hotel_chain(hotelchainID, hotelchainname, hotelchaincontactno, hotelchainemailadd, hotelchainwebsite, addressid) 
VALUES	(1,'Zazuu Best Western Hotels',456-865-8956,'bw123@gmail.com','https://www.bestwestern.com/',15);
INSERT INTO hotel_chain(hotelchainID, hotelchainname, hotelchaincontactno, hotelchainemailadd, hotelchainwebsite, addressid) 
VALUES	(2,'Zazuu China Town Hotels',110-526-5647,'chinatown123@gmail.com','https://www.chinatown.com/',11);
INSERT INTO hotel_chain(hotelchainID, hotelchainname, hotelchaincontactno, hotelchainemailadd, hotelchainwebsite, addressid) 
VALUES	(10,'Zazuu Elite Hotels',546-874-6547,'elite.tea213@gmail.com','https://www.elitendhe.com/',12);
INSERT INTO hotel_chain(hotelchainID, hotelchainname, hotelchaincontactno, hotelchainemailadd, hotelchainwebsite, addressid) 
VALUES	(4,'Zazuu Cosmopolitan Hotels',852-741-9765,'cosmo.hotels123@gmail.com','https://www.cosmopolitan.com/',13);
INSERT INTO hotel_chain(hotelchainID, hotelchainname, hotelchaincontactno, hotelchainemailadd, hotelchainwebsite, addressid) 
VALUES	(5,'Zazuu Prestige Hotels',657-784-3647,'prestige2453@gmail.com','https://www.prestige.com/',14);

SELECT* FROM hotel_chain;


----------------------------------TABLE CUSTOMER------------------------------------

INSERT INTO customer(customerID, customerFname, customerLname, customercontactno, customeremailadd, customercreditcard, customeridproof, addressid)
VALUES (1,'Jane','Doe',132-456-8564,'jane.doe@gmail.com','visa','/images/drivingLicense1023',1);

INSERT INTO customer(customerID, customerFname, customerLname, customercontactno, customeremailadd, customercreditcard, customeridproof, addressid)
VALUES	(2,'Jerry','Thachter',564-896-4752,'jerry.ytsvg@gmail.com','visa','/images/passport45612',2);

INSERT INTO customer (customerID, customerFname, customerLname, customercontactno, customeremailadd, customercreditcard, customeridproof, addressid)
VALUES	(3,'Rihanna','Perry',745-986-7451,'rih.vfdj89@gmail.com','visa','/images/drivingLicense4889',10);

INSERT INTO customer(customerID, customerFname, customerLname, customercontactno, customeremailadd, customercreditcard, customeridproof, addressid)
VALUES	(4,'Mathew','Jose',489-624-8633,'mathew.jose@gmail.com','visa','/images/drivingLicense8945',4);

INSERT INTO customer(customerID, customerFname, customerLname, customercontactno, customeremailadd, customercreditcard, customeridproof, addressid)
VALUES	(5,'Jessica','Smith',487-956-8963,'jess.smith@gmail.com','visa','/images/passport7896',5);

SELECT* FROM customer;
 
-----------------------------------------------TABLE PAYMENT------------------------------------------

INSERT INTO payment (paymentID, paymentdate, paymenttype)
VALUES(1, DATE '2022-08-08', 'cash');

INSERT INTO payment (paymentID, paymentdate, paymenttype)
VALUES(2, DATE '2022-06-08', 'card');

INSERT INTO payment (paymentID, paymentdate, paymenttype)
VALUES(3, DATE '2022-06-08', 'card');

INSERT INTO payment (paymentID, paymentdate, paymenttype)
VALUES(4, DATE '2022-06-08', 'card');

INSERT INTO payment (paymentID, paymentdate, paymenttype)
VALUES(5, DATE'2022-06-08', 'card');

SELECT* FROM payment;

------------------------------------TABLE HOTEL-------------------------------

INSERT INTO hotel(hotelID, hotelname, hotelcontactno, hotelemailadd, hotelwebsite, hoteldescription, hotelfloorcount, hotelroomcapacity, addressid, checkintime, checkouttime)
VALUES (1,'Zazuu Hotel Delux',604-502-9564,'kgi123@gmail.com','https://www.kgi123.com/','A 2-mile drive from Besh Ba Gowah Park.', 5,45,7, TIMESTAMP'2022-08-08 12:00:00', TIMESTAMP '2022-08-08 23:00:00');

INSERT INTO hotel(hotelID, hotelname, hotelcontactno, hotelemailadd, hotelwebsite, hoteldescription, hotelfloorcount, hotelroomcapacity, addressid, checkintime, checkouttime)
VALUES (2,'Zazuu Hotel Suites','604-502-9564','kgi123@gmail.com','https://www.kgi123.com/','A 2-mile drive from Besh Ba Gowah Park.',5,45,7, TIMESTAMP'2022-08-08 12:00:00', TIMESTAMP'2022-08-08 23:00:00');

INSERT INTO hotel(hotelID, hotelname, hotelcontactno, hotelemailadd, hotelwebsite, hoteldescription, hotelfloorcount, hotelroomcapacity, addressid, checkintime, checkouttime)
VALUES (3,'Zazuu Hotel luxury','547-964-9564','chinni123@gmail.com','https://www.chin23.com/','A 2-mile drive from Besh Ba Gowah Park.',6,55,9, TIMESTAMP'2022-08-08 12:00:00', TIMESTAMP'2022-08-08 23:00:00');

INSERT INTO hotel(hotelID, hotelname, hotelcontactno, hotelemailadd, hotelwebsite, hoteldescription, hotelfloorcount, hotelroomcapacity, addressid, checkintime, checkouttime)
VALUES (4,'Zazuu Hotel Amore','547-964-3452','sawmill.inn@gmail.com','https://www.chin23.com/','A 3-mile drive from Fairview Park.',4,50,9, TIMESTAMP'2022-08-08 12:00:00',TIMESTAMP'2022-08-08 23:00:00');

INSERT INTO hotel(hotelID, hotelname, hotelcontactno, hotelemailadd, hotelwebsite, hoteldescription, hotelfloorcount, hotelroomcapacity, addressid, checkintime, checkouttime)
VALUES (5,'Zazuu Hotel Familia','547-876-5422','northgate.inn@gmail.com','https://www.chin23.com/','A 4-mile drive from Conestoga Mall',3,40,10, TIMESTAMP'2022-08-08 12:00:00', TIMESTAMP'2022-08-08 23:00:00');

SELECT* FROM hotel;

------------------------------------TABLE RESERVATION--------------------------------------

INSERT INTO reservation (reservationID, reservationdate, daysrange, checkindate, checkoutdate, paymenttype, totalroombooked, hotelID, customerID, employeeID, totalamount)
VALUES (1,TIMESTAMP '2022-08-08 00:00:00', 5, TIMESTAMP'2022-08-10 12:00:00', TIMESTAMP'2022-08-15 23:00:00', 'cash', 1, 1, 1, 1, 590);
INSERT INTO reservation (reservationID, reservationdate, daysrange, checkindate, checkoutdate, paymenttype, totalroombooked, hotelID, customerID, employeeID, totalamount)	
VALUES	(2, TIMESTAMP'2022-06-08 00:00:00', 20, TIMESTAMP'2022-06-08 12:00:00', TIMESTAMP'2022-06-28 23:00:00', 'card', 1, 2, 2, 2, 2300);
INSERT INTO reservation (reservationID, reservationdate, daysrange, checkindate, checkoutdate, paymenttype, totalroombooked, hotelID, customerID, employeeID, totalamount)
VALUES	(3, TIMESTAMP'2022-06-08 00:00:00', 10, TIMESTAMP'2022-06-08 12:00:00', TIMESTAMP'2022-06-18 23:00:00', 'card', 1, 3, 3, 3, 1100);
INSERT INTO reservation (reservationID, reservationdate, daysrange, checkindate, checkoutdate, paymenttype, totalroombooked, hotelID, customerID, employeeID, totalamount)
VALUES	(4, TIMESTAMP'2022-06-08 00:00:00', 2,TIMESTAMP '2022-06-08 12:00:00', TIMESTAMP'2022-06-10 23:00:00', 'card', 1, 4, 4, 4, 290);
INSERT INTO reservation (reservationID, reservationdate, daysrange, checkindate, checkoutdate, paymenttype, totalroombooked, hotelID, customerID, employeeID, totalamount)
VALUES	(5, TIMESTAMP'2022-06-08 00:00:00', 3, TIMESTAMP'2022-06-08 12:00:00', TIMESTAMP'2022-06-11 23:00:00', 'card', 1, 5, 5, 5, 350);



SELECT* FROM reservation;

------------------------- TABLE TRANSACTION-------------------------------

INSERT INTO transaction (transactionID, transactionname, hotelID, reservationID, paymentID, transactiondescription, transactioncost,transactiondate)
VALUES (1, 'room', 1, 1, 1,'standard1_payment', 590, DATE '2022-08-08');

INSERT INTO transaction (transactionID, transactionname, hotelID, reservationID, paymentID, transactiondescription, transactioncost,transactiondate)
VALUES (2, 'room', 2, 2, 2,'standard1_payment', 590, DATE '2022-06-08');

INSERT INTO transaction (transactionID, transactionname, hotelID, reservationID, paymentID, transactiondescription, transactioncost,transactiondate)
VALUES (3, 'room', 3, 3, 3,'standard1_payment', 590, DATE '2022-06-08');

INSERT INTO transaction (transactionID, transactionname, hotelID, reservationID, paymentID, transactiondescription, transactioncost,transactiondate)
VALUES (4, 'room', 4, 4, 4,'standard2_payment', 1100, DATE '2022-06-08');

INSERT INTO transaction (transactionID, transactionname, hotelID, reservationID, paymentID, transactiondescription, transactioncost,transactiondate)
VALUES (5, 'room', 5, 5, 5,'executive1_payment', 2300, DATE '2022-06-08');


SELECT* FROM transaction;


--------------------------TABLE EMPLOYEES----------------------------------------------------

INSERT INTO employees(employeeID, employeeFname, employeeLname, employeedesignation, employeecontactno, employeeemailadd, departmentID , addressid,hotelID)
VALUES (1,'Jen','Fen','Waiter',123-789-7896,'jen.rds@gmail.com',1, 16, 1);

INSERT INTO employees(employeeID, employeeFname, employeeLname, employeedesignation, employeecontactno, employeeemailadd, departmentID , addressid,hotelID)
VALUES (2,'Jen','Funman','Waiter',123-789-7896,'jen.rds@gmail.com',1,16,2);
INSERT INTO employees(employeeID, employeeFname, employeeLname, employeedesignation, employeecontactno, employeeemailadd, departmentID , addressid,hotelID)
VALUES (3,'Tom','Pitt','Manager','565-789-7896','tom.pit@gmail.com',3,17,3);

INSERT INTO employees(employeeID, employeeFname, employeeLname, employeedesignation, employeecontactno, employeeemailadd, departmentID , addressid,hotelID)
VALUES (4,'David','Lawrence','Cashier','852-789-7896','david.lawr@gmail.com',2,18,4);
INSERT INTO employees(employeeID, employeeFname, employeeLname, employeedesignation, employeecontactno, employeeemailadd, departmentID , addressid,hotelID)
VALUES (5,'Joseph','Aniston','Cook','765-789-7896','joseph.anis@gmail.com',2,19,5);

INSERT INTO employees(employeeID, employeeFname, employeeLname, employeedesignation, employeecontactno, employeeemailadd, departmentID , addressid,hotelID)
VALUES(6,'Jeny','Patel','Manager','531-789-7896','jeny.patel@gmail.com',3,19,1);


SELECT* FROM employees;


-----------------------TABLE ROOMTYPE----------------------------------

INSERT INTO roomtype(roomtypeID, roomtypename, roomcost, roomtypedescription, smokefriendly, petfriendly)
VALUES (1, 'Standard Room',103,'1 King Bed 323-sq-foo room with cityviews','No','Yes');
INSERT INTO roomtype(roomtypeID, roomtypename, roomcost, roomtypedescription, smokefriendly, petfriendly)	
VALUES	(2, 'Standard Twin Room','123','Two Twin Bed 323-sq-foot room with cityviews','Yes','Yes');
INSERT INTO roomtype(roomtypeID, roomtypename, roomcost, roomtypedescription, smokefriendly, petfriendly)
VALUES	(3, 'Executive Room','130','1 King Bed 323-sq-foot room with cityviews','No','No');
INSERT INTO roomtype(roomtypeID, roomtypename, roomcost, roomtypedescription, smokefriendly, petfriendly)
VALUES	(4, 'Club Room','159','2 King Bed 323-sq-foot room with cityviews','Yes','Yes');

SELECT* FROM roomtype;

-------------------------TABLE ROOM--------------------------------

INSERT INTO room(roomID, roomname, roomdescription, roomtypeID,hotelID)
VALUES (1,'singleroom','standard1',1,1);

INSERT INTO room(roomID, roomname, roomdescription, roomtypeID, hotelID)
VALUES (2,'singleroom','standard1',1,2);

INSERT INTO room(roomID, roomname, roomdescription, roomtypeID,hotelID)
VALUES (3,'singleroom','standard1',1,3);

INSERT INTO room(roomID, roomname, roomdescription, roomtypeID, hotelID)
VALUES (4,'doubleroom','standard2',1,4);

INSERT INTO room(roomID, roomname, roomdescription, roomtypeID, hotelID)
VALUES (5,'twinroom','executive1',1,5);

SELECT* FROM room;


-------------------------TABLE DEPARTMENT-------------------------

INSERT INTO department(departmentID, departmentname, departmentdescription)
VALUES (1,'Kitchen','cooking');
INSERT INTO department(departmentID, departmentname, departmentdescription)
VALUES	(2,'Cleaning','tidy and mop');
INSERT INTO department(departmentID, departmentname, departmentdescription)
VALUES	(3,'Front Staff','handle resevration and query resolution');
INSERT INTO department(departmentID, departmentname, departmentdescription)
VALUES	(4,'Management','handles customer and resolve complaints');
INSERT INTO department(departmentID, departmentname, departmentdescription)
VALUES	(5,'Commute','pick up and drop');

SELECT* FROM department;


----------------------TABLE HOTELCHAIN_HAS_HOTEL--------------------------

INSERT INTO hotelchain_has_hotel(hotelchain_has_hotelID, hotelchainID, hotelID)
VALUES (1,1,1);
INSERT INTO hotelchain_has_hotel(hotelchain_has_hotelID, hotelchainID, hotelID)
VALUES (2,2,2);
INSERT INTO hotelchain_has_hotel(hotelchain_has_hotelID, hotelchainID, hotelID)
VALUES (3,10,3);
INSERT INTO hotelchain_has_hotel(hotelchain_has_hotelID, hotelchainID,hotelID) 
VALUES (4,4,4);
INSERT INTO hotelchain_has_hotel(hotelchain_has_hotelID, hotelchainID, hotelID)
VALUES (5,5,5);


SELECT* FROM hotelchain_has_hotel;

--- -----------------------------TABLE ROOM_RESERVED----------------

INSERT INTO room_reserved (room_reservedID, reservationID, roomID) 
VALUES (1, 1,1);
INSERT INTO room_reserved (room_reservedID, reservationID, roomID)
VALUES (2,2,2);
INSERT INTO room_reserved(room_reservedID, reservationID, roomID)
VALUES (3,3,3);
INSERT INTO room_reserved (room_reservedID, reservationID, roomID)
VALUES (4,4,4);
INSERT INTO room_reserved (room_reservedID, reservationID, roomID)
VALUES (5,5,5);

SELECT* FROM room_reserved;

--QUERY BEFORE CLUSTER INDEXING
SELECT emp.employeeid, emp.employeeFname, emp.employeeLname,d.departmentid, d.departmentname,d.departmentdescription
FROM employees emp
JOIN department d ON emp.departmentid = d.departmentid
ORDER BY departmentid ;
SELECT plan_table_output
FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table',null,'typical'))







---CREATION OF CLUSTER TABLE FOR departmentid
CREATE CLUSTER empl_dept
(departmentid NUMBER (15))
SIZE 512;

DROP TABLE empl;

--Create cluster tables---
CREATE TABLE empl (
emplID NUMBER (15) NOT NULL PRIMARY KEY,
  empldesignation VARCHAR2 (45) NOT NULL,
  departmentID NUMBER (15) NOT NULL REFERENCES dept,
  hotelID NUMBER (15) NOT NULL,
  addressid NUMBER (15) NOT NULL,
  emplFname VARCHAR2 (45) NOT NULL,
  emplLname VARCHAR2 (45) NOT NULL,
  emplcontactno VARCHAR2 (12) NOT NULL,
  emplemailadd VARCHAR2 (45) NOT NULL
)
CLUSTER empl_dept(departmentid)





CREATE TABLE dept (
  departmentID NUMBER (15) NOT NULL PRIMARY KEY,
  departmentname VARCHAR2 (45) NOT NULL,
  departmentdescription VARCHAR2 (100) NOT NULL
)


---CREATE INDEX CLUSTER
CREATE INDEX empl_dept_idx
ON CLUSTER empl_dept;




---CLUSTER INDEXING
SELECT emp.emplid, emp.emplFname, emp.emplLname,d.departmentid, d.departmentname,d.departmentdescription
FROM empl emp
JOIN dept d ON emp.departmentid = d.departmentid
ORDER BY departmentid ;
SELECT plan_table_output
FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table',null,'typical'))

----QUERY OPTIMIZATION BY INDEXING
---BEFORE INDEX CREATION ON TRANSACTION TABLE
ANALYZE TABLE transaction COMPUTE STATISTICS;
SELECT * FROM transaction WHERE transactiondescription LIKE '5%' ORDER BY transactioncost;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);


----AFTER INDEX CREATION ON TRANSACTION TABLE
CREATE INDEX idx_transactioncost ON transaction (transactioncost);
ANALYZE TABLE transaction COMPUTE STATISTICS;
SELECT * FROM transaction WHERE transactiondescription LIKE '5%' ORDER BY transactioncost;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);




----AFTER INDEX CREATION ON CUSTOMER TABLE
CREATE INDEX idx_transactiondescription ON transaction (transactiondescription);
ANALYZE TABLE transaction COMPUTE STATISTICS;
SELECT * FROM transaction WHERE transactiondescription LIKE '5%' ORDER BY transactioncost;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

---BEFORE INDEX CREATION ON RESERVATION TABLE
ANALYZE TABLE reservation COMPUTE STATISTICS;
SELECT res.reservationID, res.reservationdate, res.totolroombooked,res.range,hot.hotelwebsite,hot.hotelname,hotelroomcapacity
FROM hotel hot
JOIN reservation res ON hot.hotelID = res.hotelID
ORDER BY hot.hotelid;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

----AFTER INDEX CREATION ON HOTEL TABLE
CREATE INDEX IDX_hotel ON hotel(thotelid);
ANALYZE TABLE hotel COMPUTE STATISTICS;
SELECT * FROM transaction WHERE transactiondescription LIKE '5%' ORDER BY transactioncost;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);


----AFTER INDEX CREATION ON RESERVATION TABLE
CREATE INDEX IDX_reservation ON reservation(hotelid);
ANALYZE TABLE reservation COMPUTE STATISTICS;
SELECT * FROM transaction WHERE transactiondescription LIKE '5%' ORDER BY transactioncost;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

---BEFORE INDEX CREATION ON HOTEL TABLE
ANALYZE TABLE hotel COMPUTE STATISTICS;
SELECT res.reservationID, res.reservationdate, res.totolroombooked,res.range,hot.hotelwebsite,hot.hotelname,hotelroomcapacity
FROM hotel hot
JOIN reservation res ON hot.hotelID = res.hotelID
ORDER BY hot.hotelid;
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);




---BEFORE INDEX CREATION ON RESERVATION TABLE
ANALYZE TABLE reservation COMPUTE STATISTICS;
SELECT c.customerid,c.customerFname,c.customerLname,c.customeridproof,res.reservationid,res.reservationdate,
res.totalroombooked
FROM customer c
JOIN reservation res ON c.customerid = res.customerid
ORDER BY customerid ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);



----AFTER INDEX CREATION ON CUSTOMER TABLE
CREATE INDEX IDX_reservation ON reservation(customerid);
ANALYZE TABLE customer COMPUTE STATISTICS;

SELECT c.customerid,c.customerFname,c.customerLname,c.customeridproof,res.reservationid,res.reservationdate,
res.totalroombooked
FROM customer c
JOIN reservation res ON c.customerid = res.customerid
ORDER BY customerid ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);





---BEFORE INDEX CREATION ON HOTEL TABLE
ANALYZE TABLE hotel COMPUTE STATISTICS;
SELECT res.reservationID,res.reservationdate,res.totalroombooked,res.daysrange,hot.hotelwebsite,hot.hotelname,hot.hotelroomcapacity
FROM hotel hot
JOIN reservation res ON hot.hotelID = res.hotelID
ORDER BY hot.hotelid;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




----AFTER INDEX CREATION ON CUSTOMER TABLE
CREATE INDEX IDX_hotel ON hotel(hotelid);
ANALYZE TABLE hotel COMPUTE STATISTICS;
SELECT res.reservationID,res.reservationdate,res.totalroombooked,res.daysrange,hot.hotelwebsite,hot.hotelname,hot.hotelroomcapacity
FROM hotel hot
JOIN reservation res ON hot.hotelID = res.hotelID
ORDER BY hot.hotelid;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

----use to drop index on table
--DROP INDEX idx_customer;

--------------- Generating the number of booked rooms reservation in each month:

SELECT EXTRACT(month FROM checkindate) "Month",
COUNT(totalroombooked) "Total booked rooms"
FROM reservation
GROUP BY EXTRACT(month FROM checkindate)
ORDER BY "Total booked rooms" DESC;

--------Generating hotel reservation roomcosts using a range of amount-------

SELECT roomtypeID, roomtypename, roomcost
FROM roomtype
WHERE roomcost BETWEEN 100 AND 130
UNION
SELECT roomtypeID, roomtypename, roomcost
FROM roomtype
WHERE roomcost BETWEEN 50 AND 120
INTERSECT
SELECT roomtypeID, roomtypename, roomcost
FROM roomtype
WHERE roomcost BETWEEN 120 AND 159

------Checking for customer details,  reservation and the paymenttype in ascending order

SELECT c.customerID,
c.customerFname,
c.customerLname,
c.customeridproof,
res.reservationID,
res.reservationdate,
p.paymentID,
p.paymentdate
FROM customer c
JOIN reservation res ON c.customerID = res.customerID
JOIN payment p ON res.paymenttype = p.paymenttype
ORDER BY customerID ASC;

 

--------------Generate employees details with  hotel they are assigned to work, roomcost and  roomtypes in assending order


SELECT 
emp.employeeid,
emp.employeedesignation,
emp.departmentid,
emp.addressid,
emp.employeefname,
emp.employeelname,
r.roomname,
rm.roomcost,
rm.smokefriendly,
hot.hotelid,
hot.hotelwebsite,
hot.hotelname
FROM employees emp
LEFT JOIN reservation res ON res.employeeid = emp.employeeid
LEFT JOIN hotel hot ON res.hotelid = hot.hotelid
LEFT JOIN room r ON r.hotelid = hot.hotelid
LEFT JOIN roomtype rm ON rm.roomtypeid = r.roomtypeid
ORDER BY roomname ASC;


--------------- Generating the number of booked rooms reservation on a particular date

    -- How many rooms are booked in a particular hotel on a given date?
SELECT SUM(totalroombooked) AS "Total Rooms Booked" 		
FROM reservation  res
JOIN hotel hos ON res.reservationid = hos.hotelid
WHERE res.reservationdate LIKE DATE '2022-06-08' AND hos.hotelid = 3
GROUP BY res.totalroombooked;

-- Checking the list of distinct customers who have made reservation for a particular month?
SELECT customerFname,  customerLname, customeremailadd
FROM customer 
WHERE customerid IN 
(SELECT DISTINCT customerid		-- get distinct customers
FROM reservation 
WHERE EXTRACT(month FROM checkindate) = 8);		-- reservation for the month of August

-- Find all Zazuu hotels, contact and address details to enquire about a reservation in ascending order
SELECT hc.hotelchainname, hc.hotelchaincontactno,hc.hotelchainemailadd,hc.hotelchainwebsite, ad.addressline1, addressline2
FROM hotel_chain hc, address ad
WHERE hc.addressid IN (
                         SELECT ad.addressid
                         FROM address ad
                         )
AND ad.addressid = 3
OR ad.addressid = 11
OR ad.addressid = 12
OR ad.addressid = 13
OR ad.addressid = 14
ORDER BY hotelchainname ASC;


---List the various roomtypes and roomcost in Zazuu hotels
SELECT rm.roomtypename, rm.roomcost,rm.roomtypedescription,rm.smokefriendly, rm.petfriendly, r.roomdescription
FROM roomtype rm, room r
ORDER BY rm.petfriendly;


-----After making a reservation customer needs to reconfirm the reservation made

SELECT res.reservationdate, res.checkindate, res.paymenttype,res.totalroombooked,res.daysrange, c.customerFname,c.customerLname
FROM  reservation res
JOIN customer c ON c.customerid = res.customerid
WHERE res.customerid = 3;


SELECT c.customerFname,c.customerLname,res.paymenttype,res.totalroombooked,res.checkindate,res.checkoutdate,
t.transactiondate
FROM customer c
JOIN reservation res ON c.customerID = res.customerID
JOIN transaction t ON res.reservationid = t.reservationid
WHERE c.customerfname = 'Rihanna'
AND t.transactiondate = DATE '2022-06-08';


------CUSTOMER -RIHANNA PERRY NOTICED THAT SHE WAS WRONGLY DEBITED SO SJE NEEDS TO SPEAK TO AN EMPLOYEE AT ZAAZU KING GEORGE 
----INN & SUITES

SELECT emp.employeefname, emp.employeelname, emp.employeecontactno,emp.employeeemailadd, hot.hotelname
FROM employees emp
JOIN hotel hot ON emp.hotelid = hot.hotelid
WHERE emp.employeeid = 3
OR emp.employeeid  = 4
AND emp.employeeid = 5;



