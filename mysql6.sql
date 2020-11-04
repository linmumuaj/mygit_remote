#进阶5：分组查询  GROUP BY
/*
语法：
select 分组函数,列(要求出现在group by的后面) 
from 表名 
【where 筛选条件】 
group by 分组的列表
【order by 子句】

注意：
	查询列表必须特殊，要求是分组函数和group by后出现的字段

特点：
1、分组查询中的筛选条件分两类
      类别          数据源            位置                  关键字
   ① 分组前筛选     原始表            group by子句的前面     where
   ② 分组后筛选     分组后的结果集    group by子句的后面     having
   分组函数做条件肯定是放在having中
   能用分组前筛选的，优先使用分组前筛选
2、group by语句支持单个字段分组，也支持多个字段分组(多个字段之间用逗号分开没有顺序要求)，表达式
3、也可以添加排序

*/
#引入：查询每个部门的平均工资
SELECT AVG(salary) FROM employees;

#简单的分组查询
#案例1：查询每个工种的最高工资
SELECT MAX(salary),job_id
FROM employees
GROUP BY job_id;

#案例2：查询每个位置上的部门个数
SELECT COUNT(department_id),location_id
FROM departments
GROUP BY location_id;

#添加筛选条件
#案例1：查询邮箱中包含a字符的，每个部门的平均工资
SELECT AVG(salary),department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#案例2：查询有奖金的每个领导手下员工的最高工资
SELECT MAX(salary),manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

#添加分组后的筛选
#案例1：查询哪个部门的员工个数>2
SELECT COUNT(*) AS em_num,department_id
FROM employees
GROUP BY department_id
HAVING em_num>2;

#案例2：查询每个工种有奖金的员工的最高工资>12000的工种编号和其最高工资
SELECT MAX(salary),job_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary)>12000;

#案例3：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个,以及其最低工资
SELECT MIN(salary),manager_id
FROM employees
WHERE manager_id>102
GROUP BY manager_id
HAVING MIN(salary)>5000;

#按表达式或函数分组
#案例：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些
SELECT COUNT(*),LENGTH(last_name)
FROM employees
GROUP BY LENGTH(last_name)
HAVING COUNT(*)>5;

#按多个字段分组
#案例：查询每个部门每个工种的员工平均工资
SELECT AVG(salary),department_id,job_id
FROM employees
GROUP BY department_id,job_id;

#添加排序
#案例：查询每个部门每个工种的员工平均工资，并且按平均工资的高低显示
SELECT AVG(salary),department_id,job_id
FROM employees
GROUP BY department_id,job_id
ORDER BY AVG(salary) DESC;

#测试
SELECT MAX(salary),MIN(salary),AVG(salary),SUM(salary),job_id
FROM employees
GROUP BY job_id
ORDER BY job_id ASC;

SELECT MAX(salary)-MIN(salary) AS difference FROM employees;

SELECT MIN(salary),manager_id
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary)>=6000;

SELECT COUNT(*),AVG(salary),department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC;

SELECT COUNT(*),job_id
FROM employees
GROUP BY job_id;



