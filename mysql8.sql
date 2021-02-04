#进阶6：连接查询
#二、sql99语法
/*
语法：
select 查询列表
from 表1 as 别名 【连接类型】
join 表2 as 别名
on 连接条件
【where 筛选条件】
【group by 分组】
【having 筛选条件】
【order by 排序列表】


分类：
内连接（※）：inner
外连接
	左外（※）：left 【outer】
	右外（※）：right 【outer】
	全外：full 【outer】
交叉连接：cross

*/

#-->内连接
#1.等值连接
#案例1：查询员工名、部门名
SELECT last_name,department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.`department_id`=d.`department_id`;

#案例2：查询名字中包含e的员工名和工种名
SELECT last_name,job_title
FROM employees AS e
INNER JOIN jobs AS j
ON e.`job_id`=j.`job_id`
WHERE last_name LIKE '%e%';

#案例3：查询部门个数>3的城市名和部门个数
SELECT city,COUNT(*)
FROM locations AS l
INNER JOIN departments AS d
ON l.`location_id`=d.`location_id`
GROUP BY city
HAVING COUNT(*)>3;

#案例4：查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序
SELECT department_name,COUNT(*)
FROM employees AS e
INNER JOIN departments AS d
ON e.`department_id`=d.`department_id`
GROUP BY department_name
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

#案例5：查询员工名、部门名、工种名，并按部门名排序
SELECT last_name,department_name,job_title
FROM employees AS e
INNER JOIN departments AS d
ON e.`department_id`=d.`department_id`
INNER JOIN jobs AS j
ON e.`job_id`=j.`job_id`
ORDER BY department_name DESC;

#2.非等值连接
#案例1：查询员工的工资级别
SELECT salary,grade_level
FROM employees AS e
INNER JOIN job_grades AS jg
ON salary BETWEEN lowest_sal AND highest_sal;

#案例2：查询每个工资级别的个数>20，并且按工资级别降序
SELECT COUNT(*),grade_level
FROM employees AS e
INNER JOIN job_grades AS g
ON salary BETWEEN lowest_sal AND highest_sal
GROUP BY grade_level
HAVING COUNT(*)>20
ORDER BY grade_level DESC;


#3.自连接
#案例：查询员工的名字以及上级的名字
SELECT e.last_name,m.last_name
FROM employees AS e
INNER JOIN employees AS m
ON e.`manager_id`=m.`employee_id`;



#-->外连接
/*
应用场景：用于查询一个表中有，另一个表中没有的记录

特点：
1、外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配的，则显示匹配的值
	如果从表中没有匹配的，则显示null
	外连接查询结果=内连接结果+主表中有而从表中没有的记录
2、左外链接：left join左边的是主表
   右外连接：right join右边的是主表
3、左外和右外交换两个表的顺序，可以实现同样的效果 
4、全外连接=内连接的结果+表1中有但是表2中没有的+表2中有但表1中没有的	

*/
#引入查询男朋友不在boys表的女孩名字
SELECT b.name,bo.*
FROM beauty AS b
LEFT JOIN boys AS bo
ON b.`boyfriend_id`=bo.`id`
WHERE bo.`id` IS NULL;

#案例1：查询哪个部门没有员工
SELECT d.department_name,e.`employee_id`
FROM departments AS d
LEFT JOIN employees AS e
ON d.`department_id`=e.`department_id`
WHERE e.`employee_id` IS NULL;

#全外连接--mysql不支持，下面的代码有错误

SELECT b.*,bo.*
FROM beauty AS b
FULL OUTER JOIN boys AS bo
ON b.`boyfriend_id`= bo.id;



#-->交叉连接  --相当于笛卡尔乘积
SELECT b.*,bo.*
FROM beauty AS b
CROSS JOIN boys AS bo; 


#测试
#1.查询编号>3的女神的男朋友的信息，如果有则列出详细，如果没有用NULL填充
SELECT b.`name`,bo.*
FROM beauty AS b
LEFT JOIN boys AS bo
ON b.`boyfriend_id`=bo.`id`
WHERE b.`id`>3;

#2.查询哪个城市没有部门
SELECT city
FROM locations AS l
LEFT JOIN departments AS d
ON l.`location_id`=d.`location_id`
WHERE d.`department_id` IS NULL;

#3.查询部门名为SAL或IT的员工信息
SELECT e.*,d.department_name
FROM employees AS e
RIGHT JOIN departments AS d
ON e.`department_id`=d.`department_id`
WHERE d.`department_name`='SAL' OR d.`department_name`='IT';


