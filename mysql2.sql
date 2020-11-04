#进阶2：条件查询
/*
语法：
select 查询列表 from 表名 where 筛选条件；

分类：
1、按条件表达式筛选  mysql的条件运算符：> < = != <>(不等于的意思) >= <=
2、按逻辑表达式筛选  mysql的逻辑运算符：&& || ！ 标准的是：and or not
3、模糊查询 
	like
	特点：①一般和通配符搭配使用
		通配符：%：任意多个字符，包括0个字符
			_：单个字符
	between and
		①：between and可以提高语句的简洁度
		②：包含临界值
		③：两个临界值不要调换位置
	in：判断某一字段的值是否属于in列表中的某一项
		in列表的值类型必须一致或兼容
	is null

*/
#1.按条件表达式筛选
#案例1：查询工资>12000的员工信息
SELECT * FROM employees WHERE salary>12000;
#案例2：查询部门编号不等于90的员工名和部门编号
SELECT CONCAT(last_name,first_name) AS 姓名,department_id FROM employees WHERE department_id <> 90;

#2、按逻辑表达式筛选
#案例1：查询工资在10000到20000之间的员工名、工资以及奖金
SELECT last_name,salary,commission_pct FROM employees WHERE salary>=10000 AND salary<=20000;
#案例2：查询部门编号不是在90到110之间的，或者工资高于15000的员工信息
SELECT * FROM employees WHERE department_id<90 OR department_id>110 OR salary>15000;

#3、模糊查询
#1.like
#案例1：查询员工名中包含字符a的员工信息
SELECT * FROM employees WHERE last_name LIKE '%a%';  # %代表通配符
#案例2：查询员工名中第二个字符为_的员工名
SELECT last_name FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$'; #ESCAPE表示后面那个字符是转义字符
SELECT last_name FROM employees WHERE last_name LIKE '_\_%'; #同上，\就是转义的意思

#2.between and
#案例1：查询员工编号在100-120之间的员工信息
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120;

#3.in
#案例1：查询员工的工种编号是IT_PROG、AD_VP、AD_PRES的员工名和工种编号
SELECT last_name,job_id FROM employees WHERE job_id IN('IT_PROG','AD_VP','AD_PRES');

#4.is null
#案例1：查询没有奖金的员工名和奖金率
SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NULL;
#案例2：查询有奖金的员工名和奖金率
SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NOT NULL;

#安全等于 <=>
SELECT last_name,commission_pct FROM employees WHERE commission_pct <=>NULL;


