use master

create database fsoft
go

use fsoft

create table Employee(
 empNo nvarchar(10) primary key,
 empName nvarchar(50) not null,
 birthDay datetime not null,
 deptNo int not null,
 mgrNo nchar(10) not null,
 startDate datetime not null,
 salary money not null,
 levels int not null,
 statues int not null,
 note nvarchar(50)
)
alter table Employee add constraint Check_level check(levels between 1 and 7)
alter table Employee add constraint Check_status check(statues=1 or statues=2 or statues=0)


create table Skill(
	SkillNo varchar(10) primary key,
	SkillName nvarchar(50) not null,
	Note nvarchar(200)
)

create table Emp_Skill(
	SkillNo varchar(10),
	empNo nvarchar(10),
	SkillLevel int not null,
	RegDate nvarchar(30) not null,
	Decription nvarchar(30) not null,
	primary key(SkillNo,empNo),
	constraint fk_Skill foreign key (SkillNo) references Skill(SkillNo),
	constraint fk_Employee foreign key(empNo) references Employee(empNo)
)

create table Department(
	deptNo int identity(1,1) primary key,
	deptName nvarchar(20) not null,
	Note nvarchar(200)
)

--ca2
alter table Employee add Email nvarchar(30) unique(email)
alter table Employee add constraint Status_DS default(0) for statues
alter table Employee add constraint Status_DM default(0) for mgrNo

--cau3
alter table Employee add constraint fk_dept foreign key (deptNo) references Department(deptNo)
alter table Emp_Skill drop column Decription

--cau4
insert into [dbo].[Employee] ([empNo],[empName],[birthDay],[deptNo],[mgrNo],[startDate],[salary],[levels],[statues],[note],[Email])
values('No1','name1','12-12-2022',1,'mrg1','01-01-2022',200000,3,1,N'Note 1','email1'),
('No2','name2','12-12-2022',2,'mrg2','01-01-2022',200000,3,1,N'Note 1','email2'),
('No3','name3','12-12-2022',3,'mrg3','01-01-2022',200000,4,0,N'Note 1','email3'),
('No4','name4','12-12-2022',4,'mrg4','01-01-2022',200000,5,1,N'Note 1','email4'),
('No5','name5','12-12-2022',5,'mrg5','01-01-2022',200000,1,2,N'Note 1','email5')
insert into [dbo].[Department]([deptName],[Note])
values('deptName1','Note1'),
('deptName2','Note1'),
('deptName3','Note1'),
('deptName4','Note1'),
('deptName5','Note1')

insert into [dbo].[Skill]([SkillNo],[SkillName],[Note])
values('skillNo1','SkillName1','Note1'),
('skillNo2','SkillName2','Note1'),
('skillNo3','SkillName3','Note1'),
('skillNo4','SkillName4','Note1'),
('skillNo5','SkillName5','Note1')

insert into [dbo].[Emp_Skill]([SkillNo],[empNo],[SkillLevel],[RegDate])
values('skillNo1','No1',1,'date1'),
('skillNo2','No2',2,'date2'),
('skillNo3','No3',3,'date3'),
('skillNo4','No4',4,'date4'),
('skillNo5','No5',5,'date5')

create view Employee_Tracking as
	select empNo,empName,levels
	from Employee
	where levels>=3 and levels<=5

select * from Employee_Tracking