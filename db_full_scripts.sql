-- select database
use university;

--create schema
--Create SCHEMA demo;
--drop tables
DROP TABLE IF EXISTS demo.enrollment;
DROP TABLE IF EXISTS demo.subject;
DROP TABLE IF EXISTS demo.university;
DROP TABLE IF EXISTS demo.teacher;
DROP TABLE IF EXISTS demo.student;
DROP TABLE IF EXISTS demo.address;
DROP TABLE IF EXISTS demo.category;
--create tables

CREATE TABLE demo.address
	(
	address_id numeric(18, 0) NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	address_1 varchar(50) NOT NULL,
	address_2 varchar(50) NOT NULL,
	address_3 varchar(50) NULL,
	address_4 varchar(50) NULL,
	postcode varchar(50) NOT NULL,
	country varchar(50) NOT NULL
	) ; 
CREATE TABLE demo.student
	(
	student_id numeric(18, 0) NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	name varchar(50) NOT NULL,
	dob date NOT NULL,
	address_id numeric(18, 0),
	FOREIGN KEY	(address_id	) REFERENCES demo.address(address_id) ON UPDATE NO ACTION ON DELETE NO ACTION 
	);

CREATE TABLE demo.teacher
	(
	teacher_id numeric(18, 0) NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	name varchar(50) NOT NULL,
	dob date NOT NULL,
	subject_taught varchar(50) NOT NULL,
	address_id numeric(18, 0) NOT NULL,
	hod_id numeric(18, 0) NULL,
	FOREIGN KEY (hod_id) REFERENCES demo.teacher (teacher_id) ON UPDATE  NO ACTION  ON DELETE  NO ACTION ,
	FOREIGN KEY	(address_id) REFERENCES demo.address (address_id) ON UPDATE  NO ACTION ON DELETE  NO ACTION 
);

CREATE TABLE demo.category
	(
	category_id numeric(18, 0) NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	category_name varchar(50) NOT NULL
	) ;

CREATE TABLE demo.university
	(
	university_id numeric(18, 0) NOT NULL IDENTITY (1, 1)  PRIMARY KEY,
	name varchar(50) NOT NULL,
	address_id numeric(18, 0) NULL,
	FOREIGN KEY (address_id ) REFERENCES demo.address (address_id) ON UPDATE  NO ACTION  ON DELETE  NO ACTION 
	);
CREATE TABLE demo.subject
	(
	subject_id numeric(18, 0) NOT NULL IDENTITY (1, 1)  PRIMARY KEY,
	subject_name varchar(50) NOT NULL,
	category_id numeric(18, 0) NOT NULL,
	unversity_id numeric(18, 0) NOT NULL,
	teacher_id numeric(18, 0) NOT NULL,
	FOREIGN KEY	(subject_id) REFERENCES demo.teacher(teacher_id) ON UPDATE  NO ACTION  ON DELETE  NO ACTION ,
	FOREIGN KEY (category_id) REFERENCES demo.category(category_id) ON UPDATE  NO ACTION ON DELETE  NO ACTION,
    FOREIGN KEY (unversity_id) REFERENCES demo.university (university_id) ON UPDATE  NO ACTION  ON DELETE  NO ACTION 
	);
	
CREATE TABLE demo.enrollment
	(
	enrollement_id numeric(18, 0) NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	subject_id numeric(18, 0) NOT NULL,
	student_id numeric(18, 0) NOT NULL,
	status smallint NOT NULL,
	enrollment_date date NULL,
	FOREIGN KEY	(student_id) REFERENCES demo.student (student_id) ON UPDATE NO ACTION ON DELETE NO ACTION, 
	FOREIGN KEY(subject_id) REFERENCES demo.subject	(subject_id) ON UPDATE  NO ACTION ON DELETE  NO ACTION 
	);




--INSERT DATA 
--SINGLE ROW
	--WITH ALL COLUMNS
	insert into demo.address( address_1,address_2, address_3, address_4, postcode, country)
	values('learn university', '413 wood', 'Rutland close ' , 'delhi', 'dh123456', 'IN')

	--WITHOUT COLUMNS
	insert into demo.address
	values('Play university', '234 wood', 'Rutland close ' , 'chennai', 'ch43356', 'IN')

--MULTIPLE ROW
	--WITH ALL COLUMNS
	insert into demo.address( address_1,address_2, address_3, address_4, postcode, country)
	values
	('student address', '213 wood', 'somewher' , 'chennai', 'ch12356', 'CA'),
	('another student address', '216 wood', 'anywhere' , null, 'en12345', 'CA')
	--WITHOUT COLUMNS
	insert into demo.address( address_1,address_2, address_3, address_4, postcode, country)
	values
	('teacher address', '8913 wood', 'somewher' , 'chennai', 'za12356', 'NY'),
	('another teacher address', '267876 wood', 'anywhere' , null, 'za12345', 'CA')

--MULTIPLE ROW
	--WITH ALL COLUMNS INCLUDING PK
	SET IDENTIty_INSERT demo.category ON;
	INSERT INTO demo.category (category_id, category_name) VALUES
	(1, 'EE'),
	(2, 'CS'),
	(3, 'IT'),
	(4, 'EC'),
	(5, 'MEC'),
	(6, 'BIO')
--INSERT INTO SELECT
--SELECT INTO

--SELECT 
--select from  demo.category/demo.address
--ONE COLUMN
select country from  demo.address
--SOME COLUMNS
select address_1,country from  demo.address
--ALL COLUMNS
select * from  demo.address
--COLUMN ALIAS 
select address_1 + address_2 as 'NEW column' , * from  demo.address
--EXPRESSION   
	--MIN, MAX, COUNT, AVG, SUM  
	select  MIN(address_id), MAX(address_id), COUNT(*) , AVG(address_id), SUM(address_id) , max(Len(address_1)) from  demo.address
	--CASE
	select case address_id
	when 1 then 'FIRST'
	when 2 then 'SECOND'
	when 3 then 'THIRD'
	END  AS MODIFED,  *  from    demo.address
	--NULLIF 
	Select NULLIF( 50, 100) result
	--COALESCE 
	Select COALESCE(NULL, NULL, 100, 200, NULL) result
	--DISTINCT
	select DISTINCT country from  demo.address
	--COUNT
	select count(*) country from  demo.address
	--LEN
	select Len(address_1) as'Length of Address_1' , * from  demo.address
	--TOP
	 select TOP 5 * from  demo.address
	--TOP PERCENT
	 select  TOP 50 percent * from  demo.address
	--TOP WITH TIES (requires orderby) 
	 select  TOP 3 WITH TIES  * from  demo.address  ORDER BY  COUNTRY DESC
--WHERE CLAUSE 
	select  * from  demo.address  WHERE COUNTRY='IN' 
	--AND
	select  * from  demo.address  WHERE COUNTRY='IN' AND address_4='delhi' 
	--OR
	select  * from  demo.address  WHERE COUNTRY='IN' AND (address_4='chennai' OR address_4='delhi' )
	--IN
	select  * from  demo.address  WHERE address_4 IN('chennai' ,'delhi' )
	--LIKE
	select  * from  demo.address  WHERE address_3 LIKE 'c%'
	select  * from  demo.address  WHERE address_3 LIKE '%i'
	select  * from  demo.address  WHERE address_3 LIKE '_e%'
	select  * from  demo.address  WHERE address_3 LIKE '[A-C]%'
	select  * from  demo.address  WHERE address_3 LIKE '[^c-z]%'
	--BETWEEN
	select  * from  demo.address where address_id  between 6 and 8
	--NOT 
		select  * from  demo.address where address_id  NOT between 6 and 8
--ORDER BY	
	--SINGLE COLUMN
	select  * from  demo.address order by COUNTRY 
	--SINGLE COLUMN WITH ORDER
	select  * from  demo.address order by COUNTRY DESC
	--MULTIPLE COLUMNS 
	select  * from  demo.address order by COUNTRY, address_4
	--MULTIPLE COLUMNS WITH ORDER
	select  * from  demo.address order by COUNTRY DESC , address_4 ASC
	--EXPRESSION   
	select  * from  demo.address order by len(address_4) ASC,  COUNTRY DESC 
	--ORDINAL POSITION
	select  * from  demo.address order by 7,4
--GROUP BY
select address_4, count(address_id) from  demo.address  GROUP BY address_4  order by address_4 desc

--HAVING 
select address_1 , address_2, address_3, address_4, count(address_id) from  demo.address  GROUP BY address_1, address_2, address_3, address_4 having address_4 = 'chennai'
--DUPLICATES
select address_1 , address_2, address_3, address_4, count(address_id) from  demo.address  GROUP BY address_1, address_2, address_3, address_4 having count(*)>1
--OFFSET FECTCH
select  * from  demo.address order by COUNTRY  OFFSET 2 ROWS 
select  * from  demo.address order by COUNTRY  OFFSET 2 ROWS  Fetch next 3 ROWS ONLY 



--ALTER 
--ALTER COLUMN ADD COLUMN DROP COLUMN RENAME COLUMN
ALTER TABLE demo.address ADD
USER_NAME varchar(50),
LOCK_NO INT, 
--A create , B-Update , C- Delete
REASON_FOR_CHANGE CHAR(1) ,
CREATETSP TIMESTAMP

Select * from demo.address


ALTER TABLE demo.address DROP
COLUMN IF EXISTS USER_NAME , 
COLUMN IF EXISTS LOCK_NO, 
COLUMN IF EXISTS REASON_FOR_CHANGE, 
COLUMN IF EXISTS  CREATETSP 

ALTER TABLE demo.address ADD
USER_NAME varchar(50),
LOCK_NO INT  NOT NULL  default 0,
--A create , B-Update , C- Delete
REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A',
CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP


ALTER TABLE demo.enrollment ADD USER_NAME varchar(50), LOCK_NO INT  NOT NULL  default 0, REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A', CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
ALTER TABLE demo.subject ADD USER_NAME varchar(50), LOCK_NO INT  NOT NULL  default 0, REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A', CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
ALTER TABLE demo.university ADD USER_NAME varchar(50), LOCK_NO INT  NOT NULL  default 0, REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A', CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
ALTER TABLE demo.teacher ADD USER_NAME varchar(50), LOCK_NO INT  NOT NULL  default 0, REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A', CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
ALTER TABLE demo.student ADD USER_NAME varchar(50), LOCK_NO INT  NOT NULL  default 0, REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A', CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
ALTER TABLE demo.category ADD USER_NAME varchar(50), LOCK_NO INT  NOT NULL  default 0, REASON_FOR_CHANGE CHAR(1) NOT NULL default 'A', CREATETSP DATETIME2(3) NOT NULL DEFAULT CURRENT_TIMESTAMP

--CONSTRIANT --ADD --REMOVE - PK/FK/NULL/CHECK
ALTER TABLE demo.address ADD CONSTRAINT valid_address_1 CHECK(len(address_1)>2) 
insert into demo.address( address_1,address_2, address_3, address_4, postcode, country)
	values('len', '413 wood', 'Rutland close ' , 'delhi', 'dh123456', 'IN')
ALTER TABLE demo.address DROP CONSTRAINT valid_address_1

--ALTER COLUMN 
ALTER TABLE demo.address ALTER COLUMN  REASON_FOR_CHANGE char(2)

-- DESCRIBE TABLE
EXEC SP_HELP 'demo.address';


--UPDATE DATA 

-- CREATE TABLE FROM OTHER TABLE WITHOUT IDENTITY COPY 
DROP table if exists demo.address_h
select *  into demo.address_h from demo.address  where 1=0 UNION ALL SELECT TOP(1) * FROM  demo.address where 1=0


--VIEW - TRACK THE CHANGES
DROP view if EXISTS ADDRESS_VIEW;
CREATE VIEW  ADDRESS_VIEW AS ( Select * from demo.address  union all  Select * from demo.address_h );


--before modification copy the current record to history table 
INSERT INTO demo.address_h  select * from demo.address where Address_3 ='anywhere' and address_4 is  null
--first modification
UPDATE  demo.address 
SET 
address_3 = 'updated_value', address_4 = 'updated_value',USER_NAME='VISWANATH',LOCK_NO=LOCK_NO+1,REASON_FOR_CHANGE='B',CREATETSP = CURRENT_TIMESTAMP
where 
Address_3 ='anywhere' and address_4 is  null

select * from ADDRESS_VIEW where address_id in (6) --4
ORDER BY CREATETSP DESC
--before modification copy the current record to history table 
INSERT INTO demo.address_h  select * from demo.address where Address_3 ='updated_value' 
--second modification
UPDATE  demo.address 
SET 
address_3 = 'updated_value_agian', address_4 = 'up  dated_value_agian',USER_NAME='AMMIRAJU',LOCK_NO=LOCK_NO+1,REASON_FOR_CHANGE='B',CREATETSP = CURRENT_TIMESTAMP
where 
Address_3 ='updated_value' 


select * from ADDRESS_VIEW where address_id in (6) --4
ORDER BY CREATETSP DESC



INSERT INTO DEMO.STUDENT (NAME, DOB, ADDRESS_ID) VALUES
('RAJA', '2020-12-12', 3),
('RANI', '2020-12-12', 3),
('ROJA', '2021-11-12', 4),
('SITA', '2018-11-12', NULL)
SELECT * FROM DEMO.teacher
INSERT INTO DEMO.teacher (NAME, DOB, SUBJECT_TAUGHT,  ADDRESS_ID, HOD_ID) VALUES
('RAJA', '2020-12-12', 'MATHS',5, NULL),
('RANI', '2020-12-12', 'SCIENCE', 6,1),
('ROJA', '2021-11-12', 'SOCIAL', 7, 1)


--JOINS
	--INNER /DEFAULT
	SELECT * FROM DEMO.STUDENT A INNER JOIN DEMO.ADDRESS  B ON A.address_id =  B.address_id
	SELECT * FROM DEMO.STUDENT A , DEMO.ADDRESS  B WHERE  A.address_id =  B.address_id
	--LEFT
	SELECT * FROM DEMO.STUDENT A LEFT JOIN DEMO.ADDRESS  B ON A.address_id =  B.address_id
	--RIGHT
	SELECT * FROM DEMO.STUDENT A RIGHT JOIN DEMO.ADDRESS  B ON A.address_id =  B.address_id
	--FULL OUTER
	SELECT * FROM DEMO.STUDENT A FULL OUTER JOIN DEMO.ADDRESS  B ON A.address_id =  B.address_id
	--CROSS 
	SELECT * FROM DEMO.STUDENT A cross JOIN DEMO.ADDRESS  B 
	--SELF -hierarchical data or compare rows within the same table
	SELECT * FROM DEMO.STUDENT A INNER JOIN  DEMO.STUDENT  B ON A.address_id <>  B.address_id
	SELECT a.NAME, b.nAME  FROM DEMO.teacher A INNER JOIN  DEMO.teacher  B ON A.HOD_ID =  b.teacher_id
--SETS
--UNION, UNION ALL
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.ADDRESS GROUP BY ADDRESS_ID
	UNION 
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.STUDENT GROUP BY ADDRESS_ID
	
	--INTERSECT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.ADDRESS GROUP BY ADDRESS_ID
	INTERSECT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.STUDENT GROUP BY ADDRESS_ID

	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.STUDENT GROUP BY ADDRESS_ID
	INTERSECT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.ADDRESS GROUP BY ADDRESS_ID
	--EXCEPT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.ADDRESS GROUP BY ADDRESS_ID
	EXCEPT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.STUDENT GROUP BY ADDRESS_ID

	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.STUDENT GROUP BY ADDRESS_ID
	EXCEPT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.ADDRESS GROUP BY ADDRESS_ID;
--CTE
	WITH TEMP  AS (SELECT * FROM DEMO.STUDENT )
	SELECT ADDRESS_ID , COUNT(*) FROM TEMP  GROUP BY ADDRESS_ID
	EXCEPT
	SELECT ADDRESS_ID , COUNT(*) FROM DEMO.ADDRESS GROUP BY ADDRESS_ID
	
--PIVOT
SELECT ADDRESS_4, COUNT(ADDRESS_ID)  FROM DEMO.ADDRESS GROUP BY ADDRESS_4

SELECT * FROM 
 (SELECT ADDRESS_4, ADDRESS_ID  FROM DEMO.ADDRESS) AS t
 PIVOT(COUNT(ADDRESS_ID) for ADDRESS_4 IN ([delhi],[chennai], [up  dated_value_agian] )) AS  PIVOT_TABLE 
--MERGE
SELECT * FROM DEMO.ADDRESS_h 
SELECT * FROM DEMO.ADDRESS

MERGE DEMO.ADDRESS_h  T   
USING  DEMO.ADDRESS  s
ON (s.ADDRESS_ID = t.ADDRESS_ID and S.LOCK_NO-1 = T.LOCK_NO )
WHEN MATCHED
    THEN UPDATE SET 
	T.ADDRESS_1=S.ADDRESS_1,
	T.ADDRESS_2 = S.ADDRESS_2,
	T.ADDRESS_3 = S.ADDRESS_3,
	T.ADDRESS_4 = S.ADDRESS_4,
	T.POSTCODE = S.POSTCODE,
	t.USER_NAME = 'MERGE UPDATE SCRIPT'
      
WHEN NOT MATCHED BY TARGET 
    THEN INSERT 
         VALUES (s.ADDRESS_ID, s.ADDRESS_1, s.ADDRESS_2, s.ADDRESS_3,  s.ADDRESS_4, s.POSTCODE, S.COUNTRY, 'MERGE INSERT SCRIPT' ,S.lOCK_NO, S.REASON_FOR_CHANGE, S.CREATETSP)
WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;



--TRUNCATE

TRUNCATE TABLE DEMO.ADDRESS_h 
--DROP
