use master
go
if Exists (select name
			from sys.databases
			where name='FresherTrainingManagement')
		drop database FresherTrainingManagement
go
create database FresherTrainingManagement
go
use FresherTrainingManagement
go
create table Trainee(
	TraineeID int  identity(1,1) primary key,
	Full_Name nvarchar(50),
	Birth_Date datetime,
	Gender varchar(50),
	ET_IQ int,
	ET_Gmath int,
	ET_English int,
	Training_Class int,
	Evaluation_Notes nvarchar(200)
)

go
alter table Trainee add constraint check_Trainee_Gender check(Gender = 'male' or Gender = 'female')
go
alter table Trainee add constraint check_Trainee_ET_Gmath check(ET_Gmath >=0 and ET_Gmath <=20)
go
alter table Trainee add constraint check_Trainee_ET_English check(ET_English >=0 and ET_English <=50)
go
insert into Trainee
values(N'Nguyễn Tiến Dũng',02-02-2000,'male',15,15,40,1,N'Không'),
(N'Nguyễn Việt Hoàng',03-03-2000,'male',12,12,30,2,N'Không'),
(N'Nguyễn Tiến Thành',04-04-2000,'male',8,8,35,10,N'Không'),
(N'Nguyễn Việt Phương',05-05-2000,'male',20,15,40,3,N'Không'),
(N'Lê Hồng Phong',06-06-2000,'male',15,20,50,7,N'Không'),
(N'Phạm Văn Phong',07-07-2000,'male',18,18,40,4,N'Không'),
(N'Phạm Thanh Đức',08-08-2000,'male',7,7,40,5,N'Không'),
(N'Hà Hữu Duy',09-09-2000,'male',6,6,20,8,N'Không'),
(N'Lại Đức Huy',12-12-2000,'male',5,5,10,6,N'Không'),
(N'Nguyễn Tiến Đạt',02-02-2000,'male',9,9,20,9,N'Không')

--b
alter table Trainee add Fsoft_Account nvarchar(50)
select * from Trainee
--c
create view view_Trainee
as
Select *
from Trainee t
where (t.ET_IQ+ET_Gmath>=20) and ET_IQ>=8 and ET_Gmath>=8 and ET_English>=18

select * from view_Trainee

--d
select (select Full_Name where MONTH(Birth_Date)='1') as N'Tháng 1',
(select Full_Name  where MONTH(Birth_Date)='2') as N'Tháng 2',
(select Full_Name  where MONTH(Birth_Date)='3') as N'Tháng 3',
(select Full_Name  where MONTH(Birth_Date)='4') as N'Tháng 4',
(select Full_Name  where MONTH(Birth_Date)='5') as N'Tháng 5',
(select Full_Name  where MONTH(Birth_Date)='6') as N'Tháng 6',
(select Full_Name  where MONTH(Birth_Date)='7') as N'Tháng 7',
(select Full_Name  where MONTH(Birth_Date)='8') as N'Tháng 8',
(select Full_Name  where MONTH(Birth_Date)='9') as N'Tháng 9',
(select Full_Name  where MONTH(Birth_Date)='10') as N'Tháng 10',
(select Full_Name  where MONTH(Birth_Date)='11') as N'Tháng 11',
(select Full_Name  where MONTH(Birth_Date)='12') as N'Tháng 12'
from view_TRAINEE
go
/*e*/
Select TraineeID, Full_Name ,Birth_Date, Gender, (SELECT ROUND(DATEDIFF(day, Birth_Date,GETDATE())/365,0)) as tuoi
from view_TRAINEE
where Len (Full_Name)=(select max(Len(Full_Name)) from view_TRAINEE)
group by TraineeID, Full_Name ,Birth_Date, Gender
