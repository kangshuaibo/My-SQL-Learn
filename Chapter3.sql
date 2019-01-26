链接：mysql -u root -p;

/*
[例3.5]建立一个学生表Student
*/

create table Student(
	 Sno char(9) primary key,	/*列表完整性约束条件，Sno是主码*/
	 Sname char(20) unique,		/*Sname取唯一值*/
	 Ssex char(2),
	 Sage smallint,
	 Sdept char(20)
	 );





/*
[例3.6]建立一个课程表Course
*/
create table Course(
	 Cno char(4) primary key,	/*列级完整性约束条件，Cno是主码*/
	 Cname char(40) not null,	/*列级完整性约束条件，Cname不能取空值*/
	 Cpno char(4),/*先修课程*/
	 Ccredit smallint,
	 foreign key(Cpno) references Course(Cno)	/*表级完整性约束条件，Cpno是外码，被参照表是Course，被参照列是Cno*/
	 );



/*
[例3.7]建立学生选课表SC
*/
 create table SC(
     Sno char(9),
     Cno char(4),
     Grade smallint,
     primary key(Sno,Cno),/*主码由两个属性构成，必须作为表级完整性进行定义*/
     foreign key(Sno) references Student(Sno),	/*表级完整性约束条件，Sno是外码，被参照表是Student*/
     foreign key(Cno) references Course(Cno)	/*表级完整性约束条件，Cno是外码，被参照表是Course*/
     );




 /*
 [例3.8]向Student表增加“入学时间”列，其数据类型为日期型
 */
alter table Student add S_entrance date;




  /*
 [例3.9]将年龄的数据类型改为整形
 */
ALTER TABLE Student modify COLUMN Sage INT;/*与书上不同 新版本有改动*/



/*
[例3.10]增加 课程名称 必须取唯一值的约束条件
*/
alter table Course add unique(Cname);


/*
[例3.11]删除Student表
*/
 set foreign_key_checks=0;
 drop table Student cascade;/*ERROR 1217 (23000): Cannot delete or update a parent row: a foreign key constraint fails*/



 /*
[例3-12]若表上建有 视图 选择restrict时表不能删除；选择cascade时可以删除，视图也自动删除
 */
 create view IS_Student/*Student表上建立视图*/
     AS
     select Sno,Sname,Sage
     FROM Student
     WHERE Sdept='IS';

 drop table Student restrict;/*删除Student表,由于依赖视图不能删除*/

 drop table Student cascade;/*可以删除*/


/*
[例3_13]为学生-课程数据库中的Student Course SC三个表建立索引。
其中Student表按学号升序建唯一索引，Course表按课程号升序建唯一索引，SC表按学号升序和 课程号降序建唯一索引
*/

create unique index Stusno ON Student(Sno);

Create unique index Coucno ON Course(Cno);

Create unique index SCno ON SC(Sno ASC,Cno DESC);

/*
[例3.14]将SC表的SCno索引名改为SCSno
*/

 ALTER TABLE SC RENAME INDEX SCno TO SCSno;

 /*
[例3.15]删除Student表的Stusname索引
 */、
 alter table Student drop index Sname;




