#视图
/*
含义：虚拟表，和普通表一样使用
一种虚拟表，行和列的数据来自定义视图的查询中使用的表，并且是在使用视图时动态生成的，只保存
sql逻辑，不保存查询结果

	创建语法的关键字	是否实际占用物理空间     使用
视图     create view              只是保存了sql逻辑     增删改查，一般不能增删改
表       create table             保存了数据            增删改查


*/

#案例：查询姓张的学生名的专业名
INSERT INTO major
VALUES(1,'JAVA'),(2,'C++'),(3,'PHP'),(4,'Python');

INSERT INTO stuinfo
VALUES(1,'张三',1,1,23,2),(2,'李小明',2,3,24,3),(3,'张全蛋',3,6,22,1),(4,'刘明明',1,12,21,4),
(5,'张拉拉',2,11,22,3);
SELECT * FROM stuinfo;
SELECT * FROM major;

SELECT stuName,majorName
FROM stuinfo AS s
INNER JOIN major AS m
ON s.`majorId`=m.`id`
WHERE stuName LIKE '张%';

CREATE VIEW v1
AS
SELECT stuName,majorName
FROM stuinfo AS s
INNER JOIN major AS m
ON s.`majorId`=m.`id`;

SELECT * FROM v1 WHERE stuName LIKE '张%';

#一、创建视图
/*
create view 视图名
as
查询语句;

好处：
重用sql语句
简化复杂的sql操作，不必知道它的查询细节
保护数据，提高安全性

*/
#查询姓名中包含a字符的员工名、部门名和工种信息
#①创建
CREATE VIEW myv1
AS
SELECT last_name,department_name,j.*
FROM employees AS e
INNER JOIN departments AS d ON e.department_id=d.department_id
INNER JOIN jobs AS j ON j.job_id=e.job_id;
#②使用
SELECT * FROM myv1 WHERE last_name LIKE '%a%';

#二、视图的修改
#方式一：
/*
create or replace view 视图名
as
查询语句;

*/
#方式二：
/*
语法：
alter view 视图名
as
查询语句;

*/

#三、删除视图
/*
语法：drop view 视图名,视图名,...;

*/
DROP VIEW myv1;

#四、查看视图
DESC myv1;
SHOW CREATE VIEW myv1;

#五、视图的更新 --但是视图中的数据一般是不可以更新的
/*
具备以下特点的视图是不允许被更新的：
1.包含以下关键字的sql语句：分组函数、distinct、group by、having、union或者union all
2.常量视图
3.select中包含子查询
4.join
5.from 一个不能更新的视图
6.where子句的子查询引用了from子句中的表


*/
CREATE OR REPLACE VIEW myv1
AS
SELECT last_name,email,salary*12*(1+IFNULL(commission_pct,0)) 'annual salary'
FROM employees;

SELECT * FROM myv1;

CREATE OR REPLACE VIEW myv1
AS
SELECT last_name,email
FROM employees;
#1.插入
INSERT INTO myv1 VALUES('张飞','zf@qq.com'); #设置之后原始表employees中也会有
#2.修改
UPDATE myv1
SET last_name='张无忌'
WHERE last_name='张飞'; #设置之后原始表employees中也会更改
#3.删除
DELETE FROM myv1 WHERE last_name='张无忌'; #设置之后原始表employees中也会更改





