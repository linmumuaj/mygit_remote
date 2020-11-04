#二、分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数

分类：
sun求和、avg平均值、max最大值、min最小值、count计算个数

特点：
1、sum,avg一般只用于处理数值型
   max,min,count可以处理任何类型
2、以上分组函数都忽略null值
3、可以和distinct搭配实现去重的运算
4、count函数的单独介绍
   一般使用count(*)用于统计行数
5、和分组函数一同查询的字段要求是group by后的字段     
   

*/

#1.简单的使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

#2.参数支持哪些类型 sum,avg适合数值类型
SELECT SUM(last_name),AVG(last_name) FROM employees; #没有逻辑意义,虽然没有报错

SELECT MAX(last_name),MIN(last_name) FROM employees; #支持
SELECT MAX(hiredate),MIN(hiredate) FROM employees;   #支持

SELECT COUNT(salary) FROM employees;  #支持
SELECT COUNT(commission_pct) FROM employees; #支持

#3.忽略null
SELECT SUM(commission_pct),AVG(commission_pct) FROM employees;  #如果是null值就不参与计算

SELECT MAX(commission_pct),MIN(commission_pct) FROM employees;  #如果是null值就不参与计算

#4.和distinct搭配
SELECT SUM(DISTINCT salary),SUM(salary) FROM employees;
SELECT COUNT(DISTINCT salary),COUNT(salary) FROM employees;

#5.count函数的详细介绍
SELECT COUNT(*) FROM employees;  #用于统计行数
SELECT COUNT(1) FROM employees; #作用同上，就是在表中多加了一列，这一列的值全是1，然后再统计有1的行数
/*
效率：
MYISAM存储引擎下，count(*)的效率高
INNNODB存储引擎下，count(*)和count(1)的效率差不多，但是比count(字段)要高一些
综上，一般使用count(*)来进行行数统计
*/

#6.和分组函数一同查询的字段有限制
SELECT AVG(salary),employee_id FROM employees; #没有意义，因为avg算平均就一个值，而员工编号是多行值，不能形成一个规则的表格

#7.测试
#查询员工工资的最大值、最小值、平均值、总和
SELECT MAX(salary),MIN(salary),SUM(salary),AVG(salary) FROM employees;

#查询员工表中的最大入职时间和最小入职时间的相差天数（DIFFERENCE）
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) AS difference FROM employees;

#查询部门编号为90的员工个数
SELECT COUNT(department_id) AS 个数 FROM employees WHERE department_id=90



