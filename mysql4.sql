#进阶4：常见函数
/*
概念：将一组逻辑封装在方法体中，对外暴露方法名
好处：1、隐藏了实现细节 2、提高代码的重用性
调用：
	select 函数名(实参列表) 【from 表】;

分类：
	1、单行函数
	如concat length ifnull等
	2、分组函数
	
	功能：做统计使用、又称为统计函数、聚合函数、组函数

*/

/*
单行函数：
    字符函数
    数学函数
    日期函数
    其他函数【补充】
    流程控制函数【补充】
*/
#一、字符函数
#1.length
SELECT LENGTH('join');

#2.concat 拼接字符串
SELECT CONCAT(last_name,'_',first_name) FROM employees;

#3.upper、lower  大小写转换
SELECT UPPER('john');
SELECT LOWER('JOHN');

#4.substr 截取字符  注意：索引是从1开始
SELECT SUBSTR('青石路板小巷深远',5) AS out_put;  #截取从指定索引处后面所有字符
SELECT SUBSTR('青石路板小巷深远',1,4) AS out_put; #截取从指定索引开始的指定字符长度的字符

SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),'_',LOWER(SUBSTR(last_name,2)),LOWER(first_name)) AS 姓名 FROM employees;

#5.instr 返回字串第一次出现的索引，如果找不到就返回0
SELECT INSTR('青石路板小巷深远','小巷深远') AS out_put;

#6.trim 去前后空格
SELECT TRIM('    llalala   ') AS out_put,'    llalala   ' AS yuan;
SELECT TRIM('a' FROM 'aaaaa周aaa玉林aaaaaaaaaaaa') AS output;

#7.lpad 用指定的字符昨填充指定长度    rpad -右填充
SELECT LPAD('林木木',10,'*') AS out_put; #总长度为10，不够使用*来填充

#8.replace 多次出现的也会全部替换掉
SELECT REPLACE('周玉林是一个善良的人儿','周玉林','林木木') AS out_put;


#二、数学函数
#1.round 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(1.567,2); #四舍五入，小数点保留两位

#2.ceil 向上取整
SELECT CEIL(-1.01);
#3.floor 向下取整
SELECT FLOOR(1.2);
#4.truncate 截断
SELECT TRUNCATE(1.6999,1); #只保留1位小数

#mod  取余
SELECT MOD(10,3);

#三、日期函数
#1.now  返回当前系统的日期+时间
SELECT NOW();

#2.curdate 返回当前系统日期，不包含时间
SELECT CURDATE();

#3.curtime  返回当前时间，不包括日期
SELECT CURTIME();

#4.可以获取指定的部分，年year、月month、日day、小时hour、分钟minute、秒second
SELECT YEAR(NOW()) AS 年;
SELECT MONTH(NOW()) AS 月;

#5.str_to_date 将字符通过指定的格式转换成日期
SELECT STR_TO_DATE('4-3 1992','%c-%d %Y') AS out_put;

#date_format  将日期转换成字符
SELECT DATE_FORMAT('1992/4/3','%Y年%c月%d日') AS out_put;

#四、其他函数
SELECT VERSION(); #查看当前版本号
SELECT DATABASE(); #查看当前所在数据库
SELECT USER(); #查看当前用户

#五、流程控制函数
#1.if函数：if else的效果
SELECT IF(10>5,'大','小');
SELECT last_name,commission_pct,IF(commission_pct IS NULL,'没奖金','有奖金') AS 是否有奖金 FROM employees;

#2.case函数：
#case的使用一：switch case的效果
/*语法：
case 要判断的字段或者表达式
when 常量1 then 要显示的值1或语句1;
when 常量2 then 要显示的值2或语句2;
...
else 要显示的值n或语句n;
end
*/
/*案例:查询员工的工资，要求：
部门号=30，显示的工资为1.1倍
部门号=40，显示的工资为1.2倍
部门号=50，显示的工资为1.3倍
其他部门，显示的工资为原工资
*/
SELECT salary AS 原始工资,department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新工资
FROM employees;

#case的使用二：类似于多重if if{} else if{} else{}
/*
case
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值1或语句2
...
else 要显示的值n或语句n
end
*/
/*案例：查询员工的工资情况
如果工资>20000.显示A级别
如果工资>15000.显示A级别
如果工资>10000.显示A级别
否则.显示A级别

*/
SELECT salary,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;

#测试
SELECT NOW();
SELECT employee_id,last_name,salary,salary*(1+0.2) AS 'new salary' FROM employees;
SELECT last_name,LENGTH(last_name) AS 'length' FROM employees ORDER BY SUBSTR(last_name,1,1) ASC;
SELECT CONCAT(last_name,' earns ',salary,' monthly but wants ',salary*3) AS 'Dream Salary' FROM employees
WHERE salary = 24000;

SELECT job_id,
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_REP' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
ELSE 'F'
END AS grade
FROM employees;

