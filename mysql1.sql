#进阶1：基础查询
/*
语法：
select 查询列表 from 表名；

特点：
1、查询列表可以是：表中的字段、常量值、表达式、函数
2、查询的结果是一个虚拟的表格

*/
USE myemployees; # 进入库

#1.查询表中的单个字段
SELECT last_name FROM employees;
#2.查询表中的多个字段
SELECT last_name,salary,email FROM employees;
#3.查询表中的所有字段  --*表示所有的字段,字段顺序和原表是一样的  
#还可以将所有字段写上去，用逗号隔开
SELECT * FROM employees;

#4.查询常量值
SELECT 100;      #结果：显示100，结果相应的字段是100
SELECT 'john';   #结果：显示john，结果相应的字段是john

#5.查询表达式
SELECT 100*98;   #结果：9800，结果相应的字段是100*98 字段都是显示的select后面的原文字

#6.查询函数 结果就是函数的返回值
SELECT VERSION();  #结果：5.5.15 结果相应的字段是version() 字段都是显示的select后面的原文字

#7.起别名
/*
①便于理解
②如果要查询的字段有重名的情况，使用别名可以区分开来
*/
#方式1：使用as
SELECT last_name AS 姓, first_name AS 名 FROM employees;
#方式2：使用空格
SELECT last_name 姓, first_name 名 FROM employees;

#8.去重
#案例：查询员工表中涉及到的所有部门编号
SELECT DISTINCT department_id FROM employees;

#9.+号的作用
/*
mysql中的+号：
仅仅只有一个功能：运算符（不能用于字符连接）
*/
#案例：查询员工的名和姓连接成一个字段，并且相应字段的名字叫做：姓名
SELECT CONCAT(last_name, first_name) AS 姓名 FROM employee
