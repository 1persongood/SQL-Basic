use master 
go 
create database MovieCollectionTest
go
use MovieCollectionTest
go
create table Movie(
MovieId int  primary key,
MovieName nvarchar(50),
Duration float check (Duration >=1),
Genre int check (Genre between 1 and 8),
Director nvarchar(50),
MoneyMade money,
Comments nvarchar(100)
)
go



go
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1: Action
2: Adventure
3: Comedy
4: Crime
5: Dramas
6: Horror
7: Musical/dance
8: War' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Movie', @level2type=N'COLUMN',@level2name=N'Duration'
GO

create table Actor(
Act_Id char(2) primary key,
Act_Name varchar(50),
Act_Age int,
Avg_Salary money,
Nationality varchar(50)
)
go

create table ActedIn(
Ain_Id char(2) primary key,
Act_Id char(2) ,
MovieId int,
Note varchar(50),
CONSTRAINT fk_Act_Id FOREIGN KEY (Act_Id) REFERENCES Actor (Act_Id),
CONSTRAINT fk_MovieId FOREIGN KEY (MovieId) REFERENCES Movie (MovieId)
)
go
/*Q2*/
alter table Movie add ImageLink  varchar(50) unique
go
insert into Movie VALUES(2,N'Hài tết','2.2',2,N'Cao Phú',100000,N'Haì','abc')
insert into Movie VALUES(1,N'Diệt quỷ','2.4',4,N'Thanh Đức',200000,N'Hay','abcd')
insert into Movie VALUES(3,N'Thất nghiệp','2',6,N'Cao Phú',150000,N'Hap dan','abce')
insert into Movie VALUES(4,N'haweye','1.5',1,N'Tiến Dũng',150000,N'nhàm chán','abcf')
insert into Movie VALUES(5,N'thần y','2.5',7,N'Nhật Hoàng',300000,N'vui','abcg')
go
insert into Actor values('A1',N'Đức',21,30000,N'Việt Nam')
insert into Actor values('A2',N'Dũng',30,40000,N'Việt Nam')
insert into Actor values('A3',N'Hoàng',41,35000,N'Việt Nam')
insert into Actor values('A4',N'Phú',51,3000,N'Việt Nam')
insert into Actor values('A5',N'Cường',18,80000,N'Việt Nam')

go
insert into ActedIn values('N1',N'A2',1,N'vai chính')
insert into ActedIn values('N2',N'A1',3,N'nam phụ')
insert into ActedIn values('N3',N'A5',4,N'nữ chính')
insert into ActedIn values('N4',N'A3',5,N'nữ phụ')
insert into ActedIn values('N5',N'A4',2,N'nam phụ')
go
UPDATE Actor
SET Act_Name = 'Đuc anh'
WHERE Act_Id = 'A1'
Go
/*Q3*/
--c
select * from Actor
where Act_Age > 50
go
--d
select Act_Name,Avg_Salary
from Actor
ORDER BY Avg_Salary ASC
go
--e
SELECT MovieName  FROM dbo.Actor JOIN dbo.ActedIn ON ActedIn.Act_ID = Actor.Act_ID JOIN dbo.Movie ON Movie.MovieID = ActedIn.MovieID
WHERE Act_Name LIKE 'Dũng'
--f
SELECT Movie.MovieName FROM dbo.ActedIn INNER JOIN dbo.Movie ON Movie.MovieID = ActedIn.MovieID INNER JOIN dbo.Actor ON Actor.Act_ID = ActedIn.Act_ID
WHERE dbo.Movie.Genre = 1
GROUP BY Movie.MovieName
HAVING COUNT(Actor.Act_ID) > 3
select * from Movie
select * from Actor
select * from ActedIn
go



