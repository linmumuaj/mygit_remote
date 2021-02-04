#变量
/*
系统变量：
	全局变量 --跨连接有效，作用域：服务器每次启动将为所有的全局变量赋初始值
	                        针对于所有的会话(连接)有效，但不能跨重启(也就是设置的值重启后回到初始)
	
	会话变量 --作用域：仅仅针对于当前会话(连接)有效

自定义变量：
	用户变量
	局部变量
*/
#一、系统变量
/*
说明：变量由系统提供，不是用户定义，属于服务器层面
使用的语法：
1、查看所有的系统变量
SHOW GLOBAL|SESSION VARIABLES;

2、查看满足条件的部分系统变量
SHOW GLOBAL|【SESSION】 VARIABLES LIKE '%char%';

3、查看指定的某个系统变量的值
SELECT @@GLOBAL|【SESSION】.系统变量名;

4、为某个具体的系统变量赋值
方式一：
SET GLOBAL|【SESSION】系统变量名=值;
方式二：
SET @@GLOBAL|【SESSION】.系统变量名=值;

注意：
如果是全局级别，需要写global，如果是会话级别，需要写session，如果什么都不写默认是session会话级别

*/
#1.全局变量
#①查看所有的全局变量
SHOW GLOBAL VARIABLES;

#②查看满足条件的部分的全局变量
SHOW GLOBAL VARIABLES LIKE '%char%';

#③查看指定的全局变量的值
SELECT @@global.autocommit;
SELECT @@tx_isolation;

#④为某个指定的全局变量赋值
SET GLOBAL autocommit=0;
SET @@global.autocommit=0;


#2.会话变量
#①查看所有的会话变量
SHOW SESSION VARIABLES;

#②查看满足条件的部分的会话变量
SHOW SESSION VARIABLES LIKE '%char%';

#③查看指定的会话变量的值
SELECT @@tx_isolation;
SELECT @@session.tx_isolation;

#④为某个指定的会话变量赋值
SET @@session.tx_isolation='read-committed';
SET SESSION tx_isolation='read-committed';


#二、自定义变量
/*
说明：变量是用户自定义的，不是系统的
使用步骤：
声明
赋值
使用（查看、比较、运算等）

*/
#1、用户变量
/*
作用域：针对于当前会话（连接）有效，同于会话变量的作用域
应用在任何地方，可以放在begin end里面或begin end外面
*/
#①声明并初始化
SET @用户变量名=值;
SET @用户变量名:=值;
SELECT @用户变量名:=值;

#②赋值（更新用户变量的值）
方式一：通过SET或SELECT
	SET @用户变量名=值;
	SET @用户变量名:=值;
	SELECT @用户变量名:=值;
方式二：通过SELECT INTO
	SELECT 字段 INTO @变量名
	FROM 表;

#③使用（查看用户变量的值）
SELECT @用户变量名;

#案例：
#声明并初始化
SET @name='john';
SET @name:=100;
SELECT @name:=100;
#赋值
SELECT COUNT(*) INTO @count
FROM employees;
#使用（查看用户变量的值）
SELECT @count;



#2、局部变量
/*
作用域：仅仅在定义它的begin end中有效
应用在begin end中的第一句话！！！！
*/
#①声明
DECLARE 变量名 类型;
DECLARE 变量名 类型 DEFAULT 值; #值要与声明的类型一致

#②赋值
方式一：通过SET或SELECT
	SET 局部变量名=值;
	SET 局部变量名:=值;
	SELECT @局部变量名:=值;
方式二：通过SELECT INTO
	SELECT 字段 INTO 局部变量名
	FROM 表;

#③使用
SELECT 局部变量名;


/*
对比用户变量和局部变量
 
		作用域		定义和使用的位置	语法
用户变量	当前会话        会话中的任何地方       变量名前必须加@符号，不用限定类型
                                                      
局部变量	begin end中     begin end中的第一句    一般不用加@符号，需要限定类型

*/

#案例：声明两个变量并赋初值，求和
#用户变量
SET @add1=2;
SET @add2=4;
SET @sum=@add1+@add2;

SELECT @sum;

#局部变量  --下面的程序有错，因为是局部变量，没有用在begin end中
DECLARE add1 INT DEFAULT 1;
DECLARE add2 INT DEFAULT 1;
DECLARE SUM INT;
SET SUM=add1+add2;
SELECT SUM;




