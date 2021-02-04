#TCL语言 --事务控制语言
/*
Transaction Control Language
事务：
一个或一组sql语句组成一个执行单元，这个执行单元要么全部执行，要么全部不执行
如果这个单元中某一条语句执行失败，那么整个单元将会回滚，所有受到影响的数据将返回到事务
开始以前的状态

案例：转账
张 1000
郭 1000

下面的两个语句必须要都执行完，才能完成一次完整的转账
update 表 set 张的余额=500 where name='张'
意外
update 表 set 郭的余额=1500 where name='郭'
如果中间出现意外，张转了钱，但是郭没收到那就不行。如果中间出现意外
下面没执行，上面也不应该执行完成。这是这两个sql语句为一个执行单元
要么全部执行，要么全部不执行

事务的acid特性：
	a:原子性：一个事务不可再分割   
	c:一致性：一个事务的执行会使数据从一个一致状态切换到另一个一致状态 
	i:隔离性：一个事务的执行不受其他事务的干扰
	d:持久性：一个事务一旦提交，则会永久的改变数据库的数据

事务的创建：
隐式事务：事务没有明显的开启和结束的标志
比如insert、update、delete语句

显示事务：事务具有明显的开启和结束的标志
前提：必须先设置自动提交功能为禁用  set autocommit=0; 只对当前的事务有效，新的还要重新设置

步骤1：开启事务
set autocommit=0;
start transaction; #可选的，上面的语句就相当于默认开启了事务
步骤2：编写事务中的sql语句
语句1;（select,insert,update,delete 也就是DQL和DML）
语句2;
...
步骤3：结束事务
commit; #提交事务
rollback; #回滚事务

savepoint 节点名; 设置保存点

*/
SET autocommit=0;
SHOW VARIABLES LIKE 'autocommit';
SHOW ENGINES; #显示当前存储引擎

USE test;
DROP TABLE IF EXISTS account;
CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20),
	balance DOUBLE
);
INSERT INTO account(username,balance)
VALUES('张',1000),('赵',1000);

#开启事务
SET autocommit=0;
START TRANSACTION;
#编写一组事务语句
UPDATE account SET balance=500 WHERE username='张';
UPDATE account SET balance=1500 WHERE username='赵';
#结束事务
COMMIT;
ROLLBACK;

SELECT * FROM account;

#事务的隔离机制
/*
一共有四个级别：
read uncommitted：出现脏读、幻读、不可重复读
read committed：避免脏读，出现幻读和不可重复读
repeatable read：避免脏读和不可重复读，出现幻读
serializable：都可避免，但是性能不高

mysql中默认：第三个隔离级别 repeatable read

*/
#查看隔离级别
SELECT @@tx_isolation;
#设置隔离级别
SET SESSION|GLOBAL TRANSACTION ISOLATION LEVEL 隔离级别;


#2.delete和truncate在事务使用时的区别
/*
truncate不支持回滚
delete支持回滚
*/
#演示delete
SET autocommit=0;
START TRANSACTION;
DELETE FROM account;
ROLLBACK;
SELECT * FROM account;

#演示truncate
SET autocommit=0;
START TRANSACTION;
TRUNCATE TABLE account;
ROLLBACK;
SELECT * FROM account;


#3.演示savepoint的使用
SET autocommit=0;
START TRANSACTION;
DELETE FROM account WHERE id=1;
SAVEPOINT a; #设置保存点
DELETE FROM account WHERE id=2;
ROLLBACK TO a; #回滚到保存点





