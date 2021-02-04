#函数
/*
含义：一组预先编译好的SQL语句的集合
好处：
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率

区别：
存储过程：可以有0个返回，也可以有多个返回，适合做批量的插入、批量更新
函数：有且仅有1个返回，适合做处理数据后返回一个结果

*/
#一、创建语法
CREATE FUNCTION 函数名(参数列表) RETURNS 返回类型
BEGIN
	函数体
END
/*
注意：
1.参数列表 包含两部分：参数名 参数类型

2.函数体：肯定会有return语句，如果没有会报错
3.当函数体只有一句话时，可以省略begin end语句
4.使用delimiter语句设置结束标记
*/

#二、调用语法
SELECT 函数名(参数列表)

#-----------案例演示----------
#1.无参有返回的
#案例：返回公司的员工个数
DELIMITER $
CREATE FUNCTION emplNum()RETURNS INT
BEGIN
	DECLARE c INT DEFAULT 0;
	SELECT COUNT(*) INTO c
	FROM employees;
	RETURN c;
END $

SELECT emplNum()$

#2.有参又返回
#案例1：根据员工名返回工资
CREATE FUNCTION myf1(emplName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	DECLARE s DOUBLE DEFAULT 0;
	SELECT salary INTO s
	FROM employees
	WHERE last_name=emplName;
	RETURN s;
END $

SELECT myf1('Kochhar')$

#案例2：根据部门名，返回该部门的平均工资
CREATE FUNCTION myf2(depName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	DECLARE sal DOUBLE DEFAULT 0;
	SELECT AVG(salary) INTO sal
	FROM employees e
	INNER JOIN departments d ON e.departments_id=d.departments_id
	WHERE department_name=depName;
	RETURN sal;
END $
SELECT myf2('IT')$

#三、函数的查看
SHOW CREATE FUNCTION 函数名;

#四、函数的删除
DROP FUNCTION 函数名;

#案例：创建函数，实现传入两个float，返回二者之和
CREATE FUNCTION sum_f(num1 FLOAT,num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE SUM FLOAT DEFAULT 0;
	SET SUM=num1+num2;
	RETURN SUM;
END $

SELECT sum_f(1.2,2.5)$

