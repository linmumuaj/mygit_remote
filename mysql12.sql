#DML语言：数据操作语言
/*
插入：insert
修改：update
删除：delete
*/
#一、插入语句
#方式一：经典插入
/* 
语法：
insert into 表名(列1,列2,...) values(值1,值2,...);
*/

#1.插入值的类型要与列的类型一致或兼容
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','18988888888',NULL,2);

SELECT * FROM beauty;

#2.可以为null的列如何插入值？不可以为null的列必须插入值
#方式1：
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','18988888888',NULL,2);
#方式2：
INSERT INTO beauty(id,NAME,phone)
VALUES(15,'john','18966886688');

SELECT * FROM beauty;

#3.列的顺序是否可以调换 --可以调换，只要值与列对应即可
INSERT INTO beauty(NAME,id,sex,phone)
VALUES('蒋欣',16,'女','15033663214');

#4.列数要与values后面的值的个数必须一致

#5.可以省略列名，默认所有列，而且列的顺序与表中列的顺序一致
INSERT INTO beauty
VALUES(18,'lala','女',NULL,'1216646565',NULL,NULL);


#方式二：
/*
insert into 表名
set 列名=值,列名=值,列名=值,...
*/

INSERT INTO beauty
SET id=19,NAME='刘涛',phone='999';

#两种方式比较
#1.方式一支持插入多行，方式二不支持
INSERT INTO beauty
VALUES(20,'lala1','女',NULL,'1216646565',NULL,2)
,(21,'lala2','女',NULL,'1216646565',NULL,2)
,(22,'lala3','女',NULL,'1216646565',NULL,2);

SELECT * FROM beauty;

#2.方式一支持子查询，方式二不支持
INSERT INTO beauty(id,NAME,phone)
SELECT 23,'lina','12134';


#二、修改语句
/*
1.修改单表的记录※
语法：
update 表名
set 列=新值,列=新值,...
where 筛选条件;

2.修改多表的记录【补充】
语法：
sql92：
update 表1 别名,表2 别名
set 列=新值,...
where 连接条件
and 筛选条件;

sql99：
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=新值,...
where 筛选条件;

*/

#1.修改单表的记录
#案例1：修改beauty表中姓唐的电话为13988888899
UPDATE beauty
SET phone='13988888899'
WHERE NAME LIKE '唐%';

SELECT * FROM beauty;

#案例2：修改boys表中id为2的名称为张飞，魅力值为10
UPDATE boys
SET boyName='张飞',userCP=10
WHERE id=2;


#2.修改多表的记录
#案例1：修改张无忌的女朋友的手机号为114
UPDATE boys AS b
INNER JOIN beauty AS be
ON be.`boyfriend_id`=b.`id`
SET phone='114'
WHERE b.`boyName`='张无忌';

SELECT b.*,be.*   # 查看是否修改
FROM boys AS b
INNER JOIN beauty AS be
ON be.`boyfriend_id`=b.`id`;

#案例2：修改没有男朋友的女神的男朋友的编号为2
UPDATE beauty AS b
LEFT JOIN boys AS bo
ON b.`boyfriend_id`=bo.`id`
SET b.`boyfriend_id`=2
WHERE bo.`id` IS NULL;


#三、删除语句
/*
方式一：delete(一删除就是整行)
语法：
1.单表的删除 ※
delete from 表
where 筛选条件;

2.多表的删除【补充】
sql92:
delete 表1的别名,表2的别名 #这里是删除哪个表里的记录就写哪个表的别名
from 表1 别名,表2 别名
where 连接条件
on 筛选条件

sql99：
delete 表1的别名，,表2的别名 #这里是删除哪个表里的记录就写哪个表的别名
from 表1 别名
inner|left|right join 表2 别名
on 连接条件
where 筛选条件;

方式二：truncate
语法：truncate table 表名;  #删除整个表

方式一和二的区别：
truncate删除不能回滚，delete删除可以回滚

*/
#方式一：delete
#1.单表的删除
#案例1：删除手机号以9结尾的女生的信息
DELETE FROM beauty
WHERE phone LIKE '%9';

#2.多表的删除
#案例1：删除张无忌的女朋友的信息
DELETE b
FROM beauty AS b
INNER JOIN boys AS bo
ON b.boyfriend_id=bo.id
WHERE bo.boyName='张无忌';

#案例2：删除黄晓明的信息以及他女朋友的信息
INSERT INTO beauty(id,NAME,phone,boyfriend_id)
VALUES(4,'anglebaby','123',3);

DELETE b,bo
FROM beauty AS b
INNER JOIN boys AS bo
ON b.boyfriend_id=bo.id
WHERE bo.boyName='黄晓明';







