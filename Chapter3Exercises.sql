
************************Typicle********************

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

	 (2)检索至少学习了课程号为C1和C2的学生学号
	 select S#
	 from SC
	 where CNO='C1' and S# IN(
	 						 select S# 
	 						 from SC
	 						 where CNO='C2'
	 						 );
	
	(3)检索年龄在18到20之间的女生的 学号 姓名 年龄
	select S#,SNAME,AGE
	from S
	where AGE between 18 and 20;

	(4)检索平均成绩超过80分的学生学号和平均成绩
	select S#,AVG(GRADE)'平均成绩'
	from SC
	group by S# 
	having AVG(GRADE)>80;

	(5)检索选修了全部课程的学生姓名
	select SNAME
	from S
	where not exists(select * 
					 from C
					 where not exists(
						            select *
						            from SC
						            where S# = S.S# 
						            and C# = C.C#
						            )

					);

	(6)检索选修了三门课以上的学生的姓名
	select SNAME
	from S,SC
	where S.S# = SC.S#
	group by SNAME
	having COUNT(*)>3;


例3:设有关系S(S#,SNAME,SAGE,SEX) 学生号 学生姓名 学生年龄 学生性别
		  C(C#,CNAME)	课程号 课程名
		  SC(S#,C#,GRADE) 学生号 课程号 成绩
	(1)用SQL语句创建S表，声明 S#为主码，SNAME不能为空 SEX取值为男女
	create table Student(
		SNO CHAR(9) primary key,
		SNAME char(20) unique,
		sex char(2) check(sex = 男 or SEX = 女)，
		sage smallint
		);

	(2)用SQL语句修改C表中的列CNAME 为 CNAME CHAR(40)。
	alter table C
	alter column CNAME char(40);

	(3)用SQL语句向原表S中插入一个学生信息(具体信息自定)。
	insert into Student (SNO,SNAME,SEX,SAGE)
	values('200125128','陈东','男',18);

	(4)分别用关系代数表达式 和 SQL语句查询出所有女同学的姓名 年龄信息
	//SQL:
	select SNAME,SAGE
	from S
	where S.SEX = '女';
	//关系表达式：
	R1=𝛔SEX='女'(S)
	R2=𝛑SNAME,SAGE(R1);


例4:设某工厂数据库中有两个基本表
    车间基本表：DEPT(DNO,DNAME,MGR_ENO) 车间编号 车间名 车间主任职工号
    职工基本表：ERP(ENO,ENAME,AGE,SEX,SALARY,DNO) 职工号 姓名 年龄 性别 工资 所在车间号
    建立一个有关 女车间主任的职工号和姓名的视图如下：
    			VIEW6(ENO,ENAME)。写出SQL
    create view VIEW6
    as
    select ENO,ENAME 
    from ERP 
    where SEX='女' and ENO IN(
    						select MGR_ENO
    						from DEPT 
    						);

例5:用SQL语句使用嵌套查询，查询出 没有选修1号课程的学生学号和姓名
   select S#,Sname
   from Student
   where NOT exists(
   					select *
   					from SC
   					where Sno=Student.Sno 
   					and Cno = '1'
   					);


***************Exercises******************
1、试述SQL的特点。
   综合统一：集 数据定义语言DDL、数据操纵语言DML、数据控制语言DCL 的功能于一体。
   高度非过程化：进行数据操作，无需了解存取路径
   面向集合的操作方式：操作对象、查询结果 可以是元组的集合。一次插入、删除、更新 操作的对象也是元组的集合。
   是自含式语言，独立的用于联机交互。是嵌入式语言，嵌入到其他语言混合编程。

2、说明DROP TABLE时，RESTRICT和CASCADE的区别
   RESTRICT 受限 确保只有不存在相关视图 和完整性约束的表才能被删除。
   			欲删除的基本表不能被其他的表的约束所引用。
   			如果存在依赖该表的对象（触发器 视图），则此表不能被删除
   CASCADE 连级 任何的相关视图 和 完整性约束 一并都被删除，在删除基本表时 相关依赖对象一起删除。

3、有两个关系S(A,B,C,D)和T(C,D,E,F) 写出下列表达式
   (1)𝛔𝚨=10(S); 
		select * from S where A ='10';
   (2)πA,B(S); 
   		select A,B from S;
   (3)S⧓T; 
   		select A,B,S.C,S.D,E,F 
   		from S,T 
   		where S.C =T.C and S.D = T.D

   (4)S⧓T :S.C=T.C  
        select * 
        from S,T 
        where S.C=T.C;

   (5)S⧓T A<E  
   		select * 
   		from S,T 
   		where S.A<T.E;
   (6)πC,D(S)xT 
         select S.C,S.D,T.* 
         from S,T;

4、用SQL语句建立第二章习题6中的4个表，针对建立的四个表用SQL完成第二章习题6中的查询
		第二章题目：
		设有一个SPJ数据库，包括S、P、J以及SPJ四个关系模式：
		S(SNO,SNAME,STATUS,CITY); 供应商表：供应商代码、供应商名、供应商状态、供应商所在城市
		P(PNO,PNAME,COLOR,WEIGHT); 零件表：零件代码、零件名、颜色、重量
		J(JNO,JNAME,CITY);		工程项目表：工程项目代码、工程项目名、工程项目所在城市
		SPJ(SNO,PNO,JNO,QTY);   供应情况表：供应商代码、零件代码、工程项目代码、供应数量（某供应商 供应某种零件 给某工程项目）



  建立表S(SNO,SNAME,STATUS,CITY)
  CREATE TABLE S(
  	SNO CHAR(3),
  	SNAME CHAR(10)),
    STATUS CHAR(2),
    CITY CHAR(10)
    );

  建立表P(PNO,PNAME,COLOR,WEIGHT)
  CREATE TABLE P(
  	PNO CHAR(3),
  	PNAME CHAR(10),
  	COLOR CHAR(4),
  	WEIGHT INT 
  	);

  建立表J(JNO,JNAME,CITY)
  CREATE TABLE J(
  	JNO CHAR(3),
  	JNAME CHAR(10),
  	CITY CHAR(10)
  	);

  建立表SPJ(SNO,PNO,JNO,QTY)
  CREATE TABLE SPJ(
  	SNO CHAR(3),
  	PNO CHAR(3),
  	JNO CHAR(3),
  	QTY INT
  	);

  6个查询：
  (1)求供应工程J1零件的供应商号SNO。
  SELECT SNO 
  FROM SPJ 
  WHERE JNO = 'J1';

  (2)求供应工程J1零件 P1的供应商号SNO。
  SELECT SNO
  FROM SPJ
  WHERE JNO='j1' AND PNO='p1';

  (3)求供应工程J1红色零件的供应商号SNO。
  SELECT SNO
  FROM SPJ,P
  WHERE JNO ='J1' AND SPJ.PNO=P.PNO AND COLOR= '红';

  (4)求没有使用天津供应商生产的红色零件的工程号JNO。从J表入手，以包含那些尚未使用任何零件的工程号。
  SELECT JNO 
  FROM J 
  WHERE NOT EXISTS(
  			SELECT * 
  			FROM SPJ 
  			WHERE SPJ.JNO=J.JNO AND SNO IN(
  									SELECT SNO 
  									FROM S
  									WHERE CITY='天津')  AND  PNO IN(
  															SELECT PNO 
  															FROM P 
  															WHERE COLOR='红')
  				  );

  (5)求至少用了S1供应商所供应的全部零件的工程号JNO。
  SELECT DISTINCT JNO 
  FROM SPJ SPJZ 
  WHERE NOT EXISTS(
  			SELECT *
  			FROM SPJ SPJX
  			WHERE SNO='S1'AND NOT EXISTS(
  						SELECT *
  						FROM SPJ SPJY
  						WHERE SPJY.PNO=SPJX.PNO
  						AND  SPJY.JNO= SPJZ.JNO )
  					);






5、针对题4中的4个表 完成下列操作

(1)找出所有供应商的姓名和所在城市
  SELECT SNAME,CITY FROM S;
(2)找出所有零件的名称 颜色 重量
  SELECT PNAME,COLOR,WEIGHT FROM P;
(3)找出供应商S1所供应零件的工程号吗
  SELECT JNO FROM SPJ WHERE SNO='S1';
(4)找出工程项目J2使用的各种零件的名称及其数量。
  SELECT P.PNAME,SPJ.QTY 
  FROM P,SPJ
  WHERE P.PNO=SPJ.PNO AND SPJ.JNO='J2';
(5)找出上海厂商供应的所有零件号吗
  SELECT DISTINCT PNO FROM SPJ;
(6)找出使用上海产的零件的工程名称。
  SELECT JNAME FROM J,SPJ,S
  WHERE J.JNO = SPJ.JNO AND SPJ.SNO=S.SNO AND S.CITY='上海';
(7)找出没有使用天津产的零件的工程号吗。
  SELECT JNO FROM J WHERE NOT EXISTS(
  						SELECT*
  						FROM SPJ 
  						WHERE SPJ.JNO=J>JNO AND SNO IN(
  									 		SELECT SNO 
  									 		FROM S 
  									 		WHERE CITY='天津')
  								   );

(8)把全部红色零件的颜色改为蓝色
 UPDATE P
 SET COLOR='蓝'
 WHERE COLOR='红';

(9)由S5供给J4的零件P6改为由S3供应，请做必要修改
 UPDATE SPJ SET SNO ='S3'
 WHERE SNO='S5' AND JNO='J4' AND PNO='P6';

(10)从供应商表中删除S2的记录，并从供应情况表中删除相应记录。
 DELETE FROM SPJ WHERE SNO='S2';
 DELETE FROM S WHERE SNO='S2';

(11)请将(S2,J6,P4,200)插入供应情况表。
 INSERT INTO SPJ(SNO,JNO,PNO,QTY)
 VALUES('S2','J6','P4',200);












