/*
[例3.5]建立一个学生表Student
*/

create table Student(
				 -> Sno char(9) primary key,	/*列表完整性约束条件，Sno是主码*/
   				 -> Sname char(20) unique,		/*Sname取唯一值*/
  				 -> Ssex char(2),
 				 -> Sage smallint,
 				 -> Sdept char(20)
 				 -> );





/*
建立一个课程表Course
*/
create table Coures(
-> Con Char(4) primary key
->Cname char(40) not null
)