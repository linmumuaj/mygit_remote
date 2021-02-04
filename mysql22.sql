#流程控制结构
/*
顺序结构：程序从上往下依次执行
分支结构：程序从两条或多条路径中选择一条去执行
循环结构：程序在满足一定条件的基础上，重复执行一段代码
*/

#一、分支结构
#1.if函数
/*
功能：实现简单的双分支
语法：select if(表达式1,表达式2,表达式3)
执行顺序：如果表达式1成立，则if函数返回表达式2的值，否则返回表达式3的值

应用：任何地方
*/

#2.case结构
情况1：类似于java中的switch语句，一般用于实现等值判断
语法：
	CASE 变量|表达式|字
	WHEN 要判断的值 THEN 返回的值1或语句1;
	WHEN 要判断的值 THEN 返回的值2或语句2;
	...
	ELSE 要返回的值n或语句n;
	END CASE;

情况2：类似于java中的多重IF语句，一般用于实现区间判断
语法：
	CASE
	WHEN 要判断的条件1 THEN 返回的值1或语句1;
	WHEN 要判断的条件2 THEN 返回的值2或语句2;
	...
	ELSE 要返回的值n或语句1n;
	END CASE;

特点：
①
可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，BEGIN END中或BEGIN AND外面
可以作为独立的语句去使用，只能放在BEGIN END中
②
如果WHEN中的值满足或条件成立，则执行对应的THEN后面的语句，并且结束CASE
如果都不满足，则执行ELSE中的语句或值
③
ELSE可以省略，如果ELSE省略了，并且所有WHEN条件都不满足，则返回NULL

#案例
#创建存储过程，根据传入的成绩，来显示等级，比如传入的成绩：
#90-100，显示A；80-90，显示B；60-80，显示C；否则，显示D
CREATE PROCEDURE test_case(IN score INT)
BEGIN
	CASE
	WHEN score BETWEEN 90 AND 100 THEN SELECT 'A';
	WHEN score BETWEEN 80 AND 90 THEN SELECT 'B';
	WHEN score BETWEEN 60 AND 80 THEN SELECT 'C';
	ELSE SELECT 'd';
	END CASE;
END $

CALL test_case(75)$

#3.if结构
/*
功能：实现多重分支
语法
if 条件1 then 语句1;
elseif 条件2 then 语句2;
...
【else 语句n;】
end if;

应用：只能应用在begin end中

*/
#案例1：
#根据传入的成绩，来显示等级，比如传入的成绩：
#90-100，返回A；80-90，返回B；60-80，返回C；否则，返回D
CREATE FUNCTION test_if(score INT) RETURNS CHAR
BEGIN	
	DECLARE grade CHAR;
	IF score BETWEEN 90 AND 100 THEN grade='A';
	ELSEIF score BETWEEN 80 AND 90 THEN grade='B';
	ELSEIF score BETWEEN 60 AND 80 THEN grade='C';
	ELSE grade='D';
	END IF;
	RETURN grade; 
END $

SELECT test_if(75)$



#二、循环结构
/*
分类：
while、loop、repeat

循环控制：
iterate类似于continue，继续，结束本次循环，继续下一次
leave类似于break，跳出，结束当前所在的循环

应用在begin end里面

*/

#1.while
/*
语法：
【标签:】while 循环条件 do
	循环体;
end while【 标签】;
不写标签的话就是正常的while循环，没有循环控制

*/

#2.loop
/*
语法：
【标签:】loop
	循环体;
end loop【 标签】;

可以描述简单的死循环，如果要跳出，就要搭配leave

*/

#3.repeat
/*
语法：
【标签:】repeat
	循环体;
until 结束循环的条件
end repeat【 标签】;

*/

#没有添加循环控制语句
#案例1：批量插入，根据次数插入到admin表中多条记录
CREATE PROCEDURE test_while1(IN num INT)
BEGIN
	DECLARE counter INT DEFAULT 1;
	tag:WHILE counter<=num DO
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Rose',i),'666');
		SET counter=counter+1;
	END WHILE tag;
END $

CALL test_while1(5)$

#添加leave语句
#案例2：批量插入，根据次数插入到admin表中多条记录，如果次数>20则停止
TRUNCATE TABLE admin$
CREATE PROCEDURE test_while2(IN num INT)
BEGIN
	DECLARE counter INT DEFAULT 1;
	tag:WHILE counter<=num DO
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Rose',i),'666');
		IF i>=20 THEN LEAVE a;
		END IF;
		SET counter=counter+1;
	END WHILE tag;
END $

CALL test_while2(5)$

#添加iterate语句
#案例3：批量插入，根据次数插入到admin表中多条记录，只插入偶数次
TRUNCATE TABLE admin$
CREATE PROCEDURE test_while3(IN num INT)
BEGIN
	DECLARE counter INT DEFAULT 0;
	tag:WHILE counter<=num DO
		SET counter=counter+1;
		IF MOD(counter,2)!=0 THEN ITERATE tag;
		END IF;
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Rose',i),'666');
	END WHILE tag;
END $

CALL test_while3(5)$

