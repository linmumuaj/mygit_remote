#进阶3：排序查询
/*
因为有：按值的大小或者时间等进行排序的需求
语法：
select 查询列表 from 表名 【where 筛选条件】 order by 排序列表 【asc|desc】  默认是升序
                                                                 升序  降序
*/

#案例：查询员工信息，要求工资从高到低进行排序
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC;

#案例2：查询部门编号>=90的员工信息，按入职时间的先后进行排序
SELECT * FROM employees WHERE department_id>=90 ORDER BY hiredate ASC;

#案例3：按年薪的高低显示员工的信息和年薪【按表达式排序】
SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;

#案例4：按年薪的高低显示员工的信息和年薪【按别名排序】
SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY 年薪 DESC;

#案例5：按姓名的长度显示员工的姓名和工资【按函数排序】
SELECT last_name,salary FROM employees ORDER BY LENGTH(last_name) ASC;

#案例6：查询员工的信息，按工资从低到高，当工资一样是，按员工编号从大到小排序【按多个字段排序】
SELECT * FROM employees ORDER BY salary ASC,employee_id DESC;

SELECT last_name,department_id,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 
FROM employees ORDER BY 年薪 DESC,last_name ASC;

SELECT last_name,salary FROM employees WHERE salary NOT BETWEEN 8000 AND 17000 ORDER BY salary DESC;

SELECT * FROM employees WHERE email LIKE '%e%' ORDER BY LENGTH(email) DESC,department_id ASC;

