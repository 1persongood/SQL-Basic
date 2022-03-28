﻿USE master
GO

IF  EXISTS (SELECT name 
			FROM sys.databases 
			WHERE name = 'MEDICALSERVICESYSTEM')
	DROP DATABASE MEDICALSERVICESYSTEM
GO
CREATE DATABASE MEDICALSERVICESYSTEM
GO

USE MEDICALSERVICESYSTEM

go
create table PATIENT(
	patient_no varchar(25) primary key,
	full_name nvarchar(50) not null,
	date_of_birth datetime not null,
	gender varchar(50) not null,
	city nvarchar(50) not null,
	note text,
	constraint check_patient_no check(len(patient_no)<=15),
	constraint check_gender check(gender='Male' or gender='Female')
)

go
create table SERVICE(
	service_no varchar(20) primary key,
	service_name nvarchar(50) unique not null,
	price money not null,
	constraint check_service_no check(len(service_no)<=10)

)

go
create table MEDICAL_BILL(
	service_no varchar(20),
	patient_no varchar(25),
	examination_date datetime not null,
	PRIMARY KEY(service_no, patient_no),	
	CONSTRAINT FK_patient_no FOREIGN KEY(patient_no) REFERENCES PATIENT(patient_no),	
	CONSTRAINT FK_service_no FOREIGN KEY(service_no) REFERENCES SERVICE(service_no)
)

go
insert into PATIENT
values('201907170001',N'Lê Hồng Phong','02-02-2000','Male',N'Hà Nam',N'Không')

go
insert into PATIENT
values('P1',N'Lê Hồng Phong','02-02-2000','Male',N'Hà Nam',N'Không'),
		('P2',N'Phạm Thanh Phong','03-03-2000','Male',N'Thái Bình',N'Không'),
		('P3',N'Nguyễn Việt Phương','04-04-2000','Male',N'Hà Nội',N'Không'),
		('P4',N'Nguyễn Tiến Dũng','05-05-2000','Male',N'Hà Nội',N'Không'),
		('P5',N'Phạm Thanh Đức','06-06-2000','Male',N'Thái Bình',N'Không'),
		('P6',N'Lại Tiến Đạt','07-07-2000','Male',N'Thái Bình',N'Không'),
		('P7',N'Nguyễn Nhật Hoàng','08-08-2000','Male',N'Bắc Giang',N'Không'),
		('P8',N'Ngô Thị Thủy','09-09-2000','Female',N'Thái Bình',N'Không'),
		('P9',N'Nguyễn Xuân Linh','02-05-2000','Male',N'Thái Bình',N'Không')
select * from PATIENT

go
insert into SERVICE
values('S1',N'Khám Răng',500000)

go
insert into SERVICE
values('S2',N'Nội soi',2000000)
insert into SERVICE
	values('S3',N'Khám Mắt',3000000),
		('S4',N'Siêu âm',4000000),
		('S5',N'Khám Tim',5000000),
		('S6',N'Khám da',6000000),
		('S7',N'Nội soi1',7000000),
		('S8',N'Nội soi2',2050000),
		('S9',N'Nội soi3',3400000),
		('S10',N'Nội soi4',6500000)
Select * from SERVICE
go
insert into MEDICAL_BILL
values('S1','P1','02-03-2021'),
	('S2','P2','02-02-2021'),
	('S3','P1','02-02-2021'),
		('S4','P4','05-02-2021'),
		('S5','P4','02-03-2021'),
		('S6','P5','07-02-2021'),
		('S7','P2','02-05-2021'),
		('S8','P3','02-08-2021'),
		('S9','P6','07-02-2021'),
		('S10','P3','01-02-2021')

insert into MEDICAL_BILL
values('S1','P2','01-01-2019')
insert into MEDICAL_BILL
values('S1','P3','07-07-2019')
Select * from MEDICAL_BILL
--B
go
UPDATE Patient SET gender = 'Female', city=N'Hà Nội' WHERE patient_no='201907170001'

SELECT * FROM Patient WHERE patient_no='201907170001'

--C
go
SELECT * FROM Patient p INNER JOIN Medical_Bill mb ON p.patient_no=mb.patient_no
WHERE mb.examination_date='01-01-2019'

--D
go
SELECT p.city, COUNT(p.city) AS 'Number of Patients'
FROM Patient p
GROUP BY city
ORDER BY 'Number of Patients' DESC

--E
go
SELECT TOP 1 * FROM PATIENT
ORDER BY YEAR(GETDATE()) - YEAR(date_of_birth) DESC

--F
go
SELECT s.service_name
FROM Service s
WHERE s.service_name = (SELECT TOP 1 service_name FROM Service
ORDER BY price DESC) OR s.service_name = (SELECT TOP 1 service_name FROM Service
ORDER BY price ASC)

--G
go
CREATE VIEW view_PatientReport
AS
SELECT SUM(price) AS 'Total money in Jul 2019'
FROM Service s INNER JOIN Medical_Bill mb ON s.service_no=mb.service_no
WHERE MONTH(mb.examination_date) = 7 AND YEAR(mb.examination_date) = 2019

Select * from view_PatientReport