************************Typicle********************
例1、把查询Student表的权限授予给用户U1.
GRANT SELECT 
ON TABLE Student 
TO U1;

例2、把对Student表和Course表的全部权限授予用户U2和U3。
GRANT ALL PRIVILIGES
ON TABLE Student,Course 
TO U2,U3;

例3、把查询Student表和修改学生学号的权限授给用户U4。
GRANT UPDATE(Sno),SELETE
ON TABLE Student
TO U4;

例4、把用户U5对SC表的INSERT权限回收
REVOKE INSERT 
ON TABLE SC 
FROM U5 CASCADE;

例5、把对表SC的INSERT权限授予U5用户，并允许他再将此权限授予其他用户。
GRANT INSERT
ON TABLE SC
TO U5
WITH GRANT OPTION;

例6、通过角色实现将一组权限授予一个用户。
CREATE ROLE R1;

GRANT SELETE,UPDATE,INSERT
ON TABLE Student
TO R1;

GRANT R1
TO 王平，张明，赵玲

REVOKE R1
FROM 王平;



***************Exercises******************

1、什么是数据库的安全性？
指保护数据库以防止不合法的使用造成的数据泄漏、更改或破坏。

2、举例说明对数据库安全性产生威胁的因素。
非授权用户对数据库的恶意存取和破坏
安全环境的脆弱性：计算机硬件 操作系统 网络系统 等安全性是紧密相连的。

4、数据库安全性控制的常用技术：
    用户标识和鉴别 
	存取控制
	视图机制
	审计
	数据加密

5、自主存取控制方法和强制存取控制方法？
自主存取控制方法：定义各个用户对不同数据对象的存取权限
强制存取控制方法：每一个数据对象被强制标以一定的秘级

6、对下列两个关系模式：
	学生（学号，姓名，年龄，性别，家庭住址，班级号）
	班级（班级号，班级名，班主任，班长）
  使用GRANT语句完成下列授权功能：

  (1)授予用户U1对两个表的所有权限，并可给其他用户授权。
     GRANT ALL PRIVILIGES 
     ON Student,CLass
     TO U1
     WITH GRANT OPTION;

  (2)授予用户U2对学生表具有查看权限，对家庭住址具有更新权限
  	GRANT SELECT,UPDATE,DELETE
  	ON Student
  	TO U2;

  (3)将对班级表查看权限授予所有用户
 	GRANT SELECT 
  	ON Class 
  	TO PUBLIC;

  (4)将对学生表的查询、更新权限授予角色R1。
    GRANT SELECT,UPDATE
    ON Student
    TO R1;
  (5)将角色R1授予用户U1，并且U1可继续授权给其他角色。
    GRANT R1 
    TO U1
    WITH GRANT ADMIN OPTION;


7、今有以下两个关系模式：
	职工（职工号，姓名，年龄，职务，工资，部门号）
	部门（部门号，名称，经理名，地址，电话号）
  请用SQL的GRANT和REVOKE语句（加上视图机制）完成以下授权定义或存取控制功能：

   (1）用户王明对两个表有SELECT权限）
  	GRANT SELECT 
  	ON 职工，部门 
  	TO 王明; 
  	 【  
  	   REVOKE SELECT 
  	   ON 职工，部门
  	   FROM 王明;
  	  】

   (2)用户李勇对两个表有INSECT和DELETE权力。
    GRANT INSERT，DELETE 
    ON 职工，部门
    TO 李勇
     【
    	REVOKE INSERT,DELETE 
    	ON 职工，部门
    	FROM 李勇;
      】
  
   (3)每个职工只对自己的记录有SELECT权力。
    GRANT SELECT 
    ON 职工
    WHEN USER()=NAME  /*这是为什么呢*/
    TO ALL;
    【
    	REVOKE SELECT 
    	ON 职工
    	WHEN USER()=NAME
    	FROM ALI;
     】

   (4)用户刘星对职工表有SELECT权限，对工资字段具有更新权限。
    GRANT SELECT,UPDATE(工资)
    ON 职工
    TO 刘星;
     【
     	REVOKE SELECT，UPDATE
     	ON 职工
     	FROM 刘星;
      】

   (5)用户张新具有修改这两个表的结构的权力。
    GRANT ALTER TABLE
    ON 职工，部门
    TO 张新;
     【
     	REVOKE ALTER TABLE
     	ON 职工，部门
     	FROM 张新;
      】

   (6)用户周平具有对两个表所有权利（读，插，改，删数据），并具有给其他用户授权的权利。
    GRANT ALL PRIVILIGES
    ON 职工，部门
    TO 周平;
    WITH GRANT OPTION;
     【
     	REVOKE ALL PRIVILIGES
     	ON 职工，部门
     	FROM 周平；
      】


   (7)用户杨兰具有从每个部门职工中SELECT最高工资，最低工资，平均工资的权力，他不能查看每个人的工资。
    CREATE VIEW 部门工资 
    AS SELECT 部门.名称,MAX(工资),MIN(工资)，AVG(工资)
    FROM 职工，部门
    WHERE 职工.部门号=部门.部门号
    GROUP BY 职工.部门号
    GRANT SELECT 
    ON 部门工资
    TO 杨兰;
     【
     	REVOKE SELECT 
     	ON 部门工资
     	FROM 杨兰;
     	
     	DROP VIEW 部门工资;
      】

8、针对习题7中的每种情况，撤销各个用户授予的权限。
































