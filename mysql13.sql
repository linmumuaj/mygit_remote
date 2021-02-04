#DDL语言
/*

数据定义语言

库和表的管理
一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建：create
修改：alter
删除：drop

*/

#一、库的管理
#1.库的创建
/*
语法：
create database [if not exists] 库名;
*/

#案例：创建库Books
CREATE DATABASE books;

#2.库的修改

#更改库的字符集
ALTER DATABASE books CHARACTER SET gbk;

#3.库的删除
DROP DATABASE IF EXISTS books;


#二、表的管理
#1.表的创建
/*
create table if not exists 表名(
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】,
	...
	列名 列的类型【(长度) 约束】
)
*/
#案:1：创建表book
CREATE TABLE book(
	id INT, #编号
	bName VARCHAR(20), #图书名
	price DOUBLE,
	authorId INT, #作者编号
	publishDate DATETIME #出版日期
);

#案例2：创建表author
CREATE TABLE author(
	id INT,
	au_Name VARCHAR(20),
	nation VARCHAR(10)
	
);
DESC author;

#2.表的修改
/*
alter table 表名 change|modify|add|drop column 列名 【列类型 约束】;
*/

#①修改表的列名
ALTER TABLE book CHANGE COLUMN publishDate pubDate DATETIME;

#②修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubDate TIMESTAMP;

#③添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;

#④删除列
ALTER TABLE author DROP COLUMN annual;

#⑤修改表名
ALTER TABLE author RENAME TO book_author;


#3.表的删除
DROP TABLE IF EXISTS book_author;

#4.表的复制
INSERT INTO author
VALUES(1,'韩寒','中国'),(2,'村上春树','日本'),(3,'大卫科波菲尔','美国');

SELECT * FROM author;
#1>仅仅复制表的结构,不会复制内容
CREATE TABLE copy LIKE author;
SELECT * FROM copy;
#2>复制表的结+数据 -用到了子查询
CREATE TABLE copy2
SELECT * FROM author;
SELECT * FROM copy2;
#3>只复制部分数据
CREATE TABLE copy3
SELECT id,au_Name,nation
FROM author
WHERE nation = '中国';
SELECT * FROM copy3;

#4>只复制某些字段
CREATE TABLE copy4
SELECT id,au_Name
FROM author
WHERE 0;





