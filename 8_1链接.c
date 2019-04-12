#include "stdio.h"
#include "stdlib.h"
#include "/usr⁩/local⁩/⁨mysql/include⁩/mysql.h"
#include "/usr/local/mysql/lib"


EXEC SQL BEGIN DECLARE SECTION;	/*主变量说明开始*/
char deptn/me[20];
char hsno[9];
char hsname[20];
char hssex[2];
int HSage;
int NEWAGE;
EXEC SQL END DEcLARE SECTION; /*主变量说明结束*/

long SQLCODE;
EXEC SQL INCLUDE SQLCODE;/*定义SQL通信区*/

int main(void)
{
  int count=0;
  char yn;  //变量代表yes或者no
  printf("Please choose the department name(CS/MA/IS):");
  scanf("%s",&deptname);  //为主变量赋值
  EXEC SQL CONNECT TO TEST@localhost：54321 USER“SYSTEM”/ “MANAGER”; //链接数据库
  EXEC SQL DECLARE SX CURSOR FOR //定义游标SX

    SELECT Sno,Sname,Ssex,HSage
    FROM Student
    WHERE SDept=:deptname;
    EXEC SQL OPEN SX; //打开游标SX，指向查询结果的第一行

    for(;;)
    {
      EXEC SQL FETCH SX INTO:HSno,:Hsname,:HSsex,:HSage;  //推进游标，将当前数据放入主变量
      if(SQLCA.SQLCODE!=0)  //SQLCODE不等于0表示操作不成功
        break;
      if(count++==0)
      printf("\n%-10s %-20s %-10s %-10s\n",HSno,HSname,HSsex,HSage); //打印查询结果
      printf("UPDATE AGE(y/s)?"); //询问用户是否要更新该学生的年龄

      do{scanf("%c",&yn);}
      while(yn!='N' && yn!='n' && yn!='Y' && yn!='y');
      
      if(yn=='y'||yn=='Y')  //如果选择更新操作
      {
        printf("INPUT NEW AGE：");
        scanf("%d",&NEWAGE);  //用户输入新年龄到主变量中
        EXEC SQL UPDATE Student //嵌入式SQL跟新语句
            SET Sage=:NEWAGE
            WHERE CURRENT OF SX; //对当前游标指向的学生年龄进行更新
      }

      EXEC SQL CLOSE SX; //关闭游标SX,不再和查询结果对应
      EXEC SQL COMMIT WORK; //提交更新
      EXEC SQL DISCONNECT TEST；//断开数据库链接

    }



}
