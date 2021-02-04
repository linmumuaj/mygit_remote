#进阶7：子查询
/*
含义：出现在其他语句中的select语句，称为子查询或内查询

分类：
按子查询出现的位置：
	select后面：
		仅仅支持标量子查询
	from后面
		支持表子查询
	where或having后面 ☆☆☆☆☆☆☆☆☆
		标量子查询 （单行） √
		列子查询   （多行）√
		行子查询（用的很少）
	exists后面（相关子查询）
		表子查询
		
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）

*/

#一、where或having后面
/*
1、标量子查询（单行子查询）
2、列子查询（多行子查询）

特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用 > < >= <= = <>
 列子查询，一般搭配着多行操作符使用 in、ANY/SOME、ALL
④子查询的执行优先于主查询执行
*/
#1、标量子查询
#案例1：谁的工资比Abel高？
SELECT last_name,salary
FROM employees
WHERE salary>(
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel');

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id=141)
AND salary>(
	SELECT salary
	FROM employees
	WHERE employee_id=143);


#案例3：返回公司工资最少的员工的last_name,job_id和salary
SELECT last_name,job_id,salary
FROM employees
WHERE salary=(
	SELECT MIN(salary)
	FROM employees);
	
#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id,MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary)>(
	SELECT MIN(salary)
	FROM employees
	WHERE department_id=50);


#2、列子查询
#案例1：返回location_id是1400或1700的部门中的所有员工的姓名
SELECT last_name
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400,1700));

#案例2：返回其他工种中比job_id为'IT_PROG'工种任一工资低的员工的员工号、姓名、job_id以及salary
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE salary<ANY(
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';

#案例3：返回其他工种中比job_id为'IT_PROG'工种所有工资都低的员工的员工号、姓名、job_id以及salary
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE salary<ALL(
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';



#二、放在select后面
#案例1：查询每个部门的员工个数
SELECT d.*,(
	SELECT COUNT(*)
	FROM employees AS e
	WHERE e.department_id = d.`department_id`) AS 个数
FROM departments AS d;


#三、放在from后面 --将子查询结果充当一张表，要求必须起别名
#案例：查询每个部门的平均工资的工资等级
SELECT ag_dep.*,grade_level
FROM (
	SELECT AVG(salary) AS ag,department_id
	FROM employees
	GROUP BY department_id) AS ag_dep
INNER JOIN job_grades AS j
ON ag_dep.ag BETWEEN lowest_sal AND highest_sal;



#四、exists后面（先关子查询）
#语法：exists(完整的查询语句)  结果只有1或0，当完整的查询语句可以查到值后就为1，否则为0

#案例1：查询有员工的部门名
SELECT department_name
FROM departments AS d
WHERE EXISTS(
	SELECT *
	FROM employees AS e
	WHERE e.`department_id` = d.`department_id`);

#------B站P94的案例题--------
#1.
SELECT last_name,salary,department_id
FROM employees
WHERE department_id=(
	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey');

#2.
SELECT employee_id,last_name,salary
FROM employees
WHERE salary>(
	SELECT AVG(salary)
	FROM employees);

#3.	
SELECT employee_id,last_name,salary,avg_dep.ag
FROM employees AS e
INNER JOIN (
	SELECT AVG(salary) AS ag,department_id
	FROM employees
	GROUP BY department_id) AS avg_dep
 ON e.`department_id`=avg_dep.department_id
 WHERE e.`salary`>avg_dep.ag;
 
 #4.
 SELECT employee_id,last_name
 FROM employees
 WHERE department_id IN (
	SELECT department_id
	FROM employees
	WHERE last_name LIKE '%u%');

#5.
SELECT employee_id
FROM employees
WHERE department_id IN (
	SELECT department_id
	FROM departments
	WHERE location_id=1700);

#6.
SELECT last_name,salary
FROM employees
WHERE manager_id IN (
	SELECT employee_id
	FROM employees
	WHERE last_name='K_ing');




