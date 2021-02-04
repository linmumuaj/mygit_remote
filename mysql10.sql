#进阶8：分页查询 ※
/*
应用场景：当要现实的数据，一页显示不全，需要分页提交sql请求
语法：
	select 查询列表
	from 表
	【连接类型 join 表2
	on 连接条件
	where 筛选条件
	group by 分组字段
	having 分组后的筛选
	order by 排序的字段】
	limit offset，size;  
	
	offset要显示条目的起始索引（起始索引从0开始）
	size要显示的条目个数

特点：
	①limit语句放在查询语句的最后
	②公式
	要现实的页数page，每页的条目数size
	select 查询列表
	from 表
	limit (page-1)*size,size;

*/

#案例1：查询前五条员工信息
SELECT *
FROM employees
LIMIT 0,5;

#案例2：查询第11条--第25条
SELECT *
FROM employees
LIMIT 10,15;

#案例3：有奖金的员工信息，并且工资较高的前10名显示出来
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC
LIMIT 10;

SELECT j.*
FROM jobs AS j
WHERE job_id = (
	SELECT job_id
	FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 1);

SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary)>(
	SELECT AVG(salary)
	FROM employees);

SELECT DISTINCT manager_id
FROM employees;

SELECT *
FROM employees
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees);

SELECT MAX(salary),department_id
FROM employees
GROUP BY department_id
ORDER BY MAX(salary) ASC
LIMIT 1;

SELECT MIN(salary)
FROM employees
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY MAX(salary) ASC
	LIMIT 1);

SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;

SELECT manager_id
FROM departments
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC
	LIMIT 1);

SELECT last_name,department_id,email,salary
FROM employees
WHERE employee_id=(
	SELECT manager_id
	FROM departments
	WHERE department_id=(
		SELECT department_id
		FROM employees
		GROUP BY department_id
		ORDER BY AVG(salary) DESC
		LIMIT 1));

SELECT last_name,e.department_id,email,salary
FROM employees AS e
INNER JOIN departments AS d
ON e.`employee_id`=d.`manager_id`
WHERE d.`department_id`=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC
	LIMIT 1);

