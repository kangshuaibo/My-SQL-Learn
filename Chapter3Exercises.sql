Typicle:
例1：建立学生表 由学号 姓名 性别 年龄 所在系五个属性组成 。其中学号不能为空，值是唯一的，并且姓名取值也唯一。
create table Student(
			Sno char(5) not null unique,
			Sname char(20) unique,
			Ssex char(1),
			Sage int,
			Sdept char(15)
			);


例2：设学生数据库中有三个关系
学生关系 S(S#,SNAMW,AGE,SEX) 学号 姓名 年龄 性别
学习关系 SC(S#,C#,GRADE) 学号 课程号 成绩
课程关系 C(C#,CNAME)	课程号 课程名

	（1）检索选修课程名为MATHS的学生的 学号与姓名
	 select SNAMW,AGE
	 from S,SC,C
	 where S.S#=SC.C#
	 and C.C#=SC.C#
	 and CNAME='MATHS';

	 (2)