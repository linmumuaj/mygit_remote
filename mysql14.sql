#常见的数据类型
/*
数值型：
	整型
	小数：
		定点数
		浮点数
字符型：
	较短的文本：char、varchar
	较长的文本：text、blob(较长的二进制数据)
日期型

*/
#一、整型
/*
分类：
tinyint、smallint、mediumint、int/integer、bigint
  1字节    2字节     3字节      4字节       8字节

特点：
①如果不设置无符号还是有符号，默认是有符号，如果想设置无符号，需要添加unsigned
②如果插入的数值超出了整型的范围，会报out of range异常，并且插入临界值
③如果不设置长度，会有默认的长度
④长度的设置不会影响数值的范围，只是最终数据的显示长度超过设置的时还是全部显示
  当不够设置的长度时，配合zerofill关键字，显示的时候差多少位左边就会补多少0
  zerofill就是默认无符号的

*/
#1.如何设置无符号和有符号
DROP TABLE IF EXISTS tab_int;
CREATE TABLE tab_int(
	t1 INT,
	t2 INT UNSIGNED
);
DESC tab_int;

INSERT INTO tab_int VALUES(-123456,-123456);
SELECT * FROM tab_int;

DROP TABLE IF EXISTS tab_int;
CREATE TABLE tab_int(
	t1 INT(7) ZEROFILL,
	t2 INT(7) ZEROFILL
);
INSERT INTO tab_int VALUES(123,123);
SELECT * FROM tab_int;

#二、小数
/*
分类：
1.浮点型
float(M,D)
double(M,D)
2.定点型
dec(M,D)
decimal(M,D)

特点：
①M和D：M代表的是整数部位+小数部位的总长度
       D代表小数部位
       如果超出范围则插入临界值
②M和D可以省略
如果是decimal，则M默认为10，D默认为0
如果是float和double，则会根据插入的数值的精度来决定精度
③定点型的精度较高

原则：
所选的类型越简单越好，能保存数值的类型越小越好

*/

#三、字符型
/*
较短的文本：
char
varchar

较长的文本：
text
blob（较大的二进制）

特点：
         写法         M的意思        特点            空间的耗费   效率
char     char(M)     最大的字符数   固定长度的字符    比较耗费   高一点
                  可以省略，默认为1

varchar  varchar(M)  最大的字符数   可变长度的字符    比较节省   低一点
                      不可以省略
*/


#四、日期型
/*
分类：
date：只保存日期
time：只保存时间
year：只保存年

datetime：保存日期+时间
timestamp：保存日期+时间

*/








