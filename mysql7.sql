#进阶6：连接查询
/*
含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询

分类：
	按标准分类：
	sql92标准：只支持内连接
	sql99标准【推荐】：支持内连接+外连接(左外连接+右外连接)+交叉连接
	
	按功能分类：
	内连接：
		等值连接
		非等值连接
		自连接
	外连接：
		左外连接
		右外连接
		全外连接
	交叉连接：

*/
SELECT * FROM beauty;
SELECT * FROM boys;

SELECT NAME,boyName FROM beauty,boys
WHERE beauty.`boyfriend_id` = boys.`id`;

#一、sql92标准
#---1---等值连接
#1.等值连接
/*
①多表等值连接的结果为多表的交集部门
②n表连接，至少需要n-1个连接条件
③多表的顺序没有要求
④一般需要为多表起别名
⑤可以搭配前面所有的查询子句使用，筛选，排序，分组
*/

#案例1：查询女神名和对应的男神名
SELECT NAME,boyName FROM beauty,boys
WHERE beauty.boyfriend_id = boys.id;

#案例2：查询员工名和对应的部门名
SELECT last_name,department_name FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;

#2.为表起别名   注意：为表起别名后，只能用表的别名
#查询员工名、工种号、工种名
SELECT last_name,e.job_id,job_title
FROM employees AS e,jobs AS j
WHERE e.`job_id`=j.`job_id`;

#3.from后两个表的顺序可以调换

#4.可以加筛选
#案例1：查询有奖金的员工名、部门名
SELECT last_name,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`
AND commission_pct IS NOT NULL;

#案例2：查询城市名中第二个字符为o的部门名和城市名
SELECT department_name,city
FROM departments,locations
WHERE departments.`location_id`=locations.`location_id`
AND city LIKE '_o%';

#可以加分组
#案例1：查询每个城市的部门个数
SELECT COUNT(*),city
FROM departments AS d,locations AS l
WHERE d.`location_id`=l.`location_id`
GROUP BY city;

#案例2：查询有奖金的每个部门的部门名和部门的领导编号以及该部门的最低工资
SELECT department_name,d.manager_id,MIN(salary)
FROM departments AS d,employees AS e
WHERE d.`department_id`=e.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name,d.manager_id;

#可以加排序
#案例：查询每个工种的工种名和员工的个数，并按员工个数降序
SELECT job_title,COUNT(*) AS p_num
FROM jobs AS j,employees AS e
WHERE j.`job_id`=e.`job_id`
GROUP BY job_title
ORDER BY p_num DESC;

#7.可以实现三表连接
#案例：查询员工名、部门名和所在的城市
SELECT last_name,department_name,city
FROM employees AS e,departments AS d,locations AS l
WHERE e.`department_id`=d.`department_id`
AND d.`location_id`=l.`location_id`;


#---2---非等值连接
CREATE TABLE job_grades
(grade_level VARCHAR(3),
 lowest_sal  INT,
 highest_sal INT);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);
#案例1：查询员工的工资和工资级别
SELECT salary,grade_level
FROM employees AS e,job_grades AS j
WHERE e.`salary`>=j.`lowest_sal`
AND e.`salary`<=j.`highest_sal`;


#---自连接---
#案例：查询员工名和上级的名称
SELECT e1.last_name,e2.last_name AS manger_name
FROM employees AS e1,employees AS e2
WHERE e1.manager_id=e2.employee_id;

#测试
#1.显示员工表的最大工资，工资平均值
SELECT MAX(salary) AS max_salary,AVG(salary) AS avg_salary FROM employees;

#2.查询员工表的employee_id,job_id,last_name,按department_id降序，salary升序
SELECT employee_id,job_id,last_name
FROM employees
ORDER BY department_id DESC,salary ASC;

#3.查询员工表的job_id中包含a和e的，并且a在e的前面
SELECT job_id
FROM employees
WHERE job_id LIKE '%a%e%';

#4.显示当前日期，以及去前后空格，截取字符串的函数
#     now()           trim()          substr(str,i1,i2)
SELECT COUNT(*),department_id
FROM employees
GROUP BY department_id;

#作业
#1.显示所有员工的姓名，部门号和部门名称
SELECT last_name,e.department_id,department_name
FROM employees AS e,departments AS d
WHERE e.`department_id`=d.`department_id`;

#2.查询90号部门员工的job_id和90号部门的location_id
SELECT job_id,location_id
FROM employees AS e,departments AS d
WHERE e.`department_id`=d.`department_id`
AND e.`department_id`=90;

#3.选择所有有奖金员工的last_name,department_name,location_id,city
SELECT last_name,department_name,l.location_id,city
FROM employees AS e,departments AS d,locations AS l
WHERE e.`department_id`=d.`department_id`
AND d.`location_id`=l.`location_id`
AND commission_pct IS NOT NULL;

#4.选择city在Toronto工作员工的last_name,job_id,department_id,department_name
SELECT last_name,job_id,e.department_id,department_name,city
FROM employees AS e,departments AS d,locations AS l
WHERE e.`department_id`=d.`department_id` AND d.`location_id`=l.`location_id`
AND l.`city`='Toronto';

#5.查询每个工种，每个部门的部门名、工种名和最低工资
SELECT job_title,department_name,MIN(salary)
FROM jobs AS j,departments AS d,employees AS e
WHERE e.`job_id`=j.`job_id`
AND e.`department_id`=d.`department_id`
GROUP BY job_title,department_name;

#6.查询每个国家下的部门数大于2的国家编号
SELECT COUNT(*),country_id
FROM locations AS l,departments AS d
WHERE d.`location_id`=l.`location_id`
GROUP BY country_id
HAVING COUNT(*)>2;

#7.选择指定员工的姓名员工号，以及他的管理者的姓名和员工号
SELECT e.last_name,e.employee_id,m.`last_name`,m.`employee_id`
FROM employees AS e,employees AS m
WHERE e.`manager_id`=m.`employee_id`;



