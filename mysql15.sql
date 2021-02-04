#常见的约束
/*
含义：一种限制，用于限制表中的数据，为了表中数据的准确和可靠性

分类：六大约束
	NOT NULL：非空，用于保证该字段的值不能为空
	DEFAULT：默认，用于保证该字段有默认值
	PRIMARY KEY：主键，用于保证该字段的值具有唯一性，并且非空
	UNIQUE：唯一，用于保证该字段的值具有唯一性，可以为空
	CHECK：检查约束【mysql中不支持】
	FOREIGN KEY：外键，用于限制两个表的关系，用于保证该字段的值必须来自于主表的关联列的值

添加约束的时机：
	1.创建表时
	2.修改表时
	
约束的添加分类：
	列级约束：
		六大约束语法上都支持，但外键约束没有效果
	表级约束：
		除了非空、默认，其他都支持

主键和唯一的大对比：
	保证唯一性	是否允许为空	   一个表中可以有多少个    是否允许组合
主键     √                 ×                   最多有一个            允许，但不推荐
唯一     √              √(只允许有一个空)      可以有多个            允许，但不推荐

外键：
	1.要求在从表设置外键关系
	2.从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求
	3.主表的关联列必须是一个key（一般是主键或唯一）
	4.插入数据时，要先插入主表再插入从表
	  删除数据时，要先删除从表再删除主表

*/
CREATE TABLE 表名(
	字段名 字段类型 列级约束1 列级约束2 列级约束3 ...,
	字段名 字段类型,
	表级约束
);
#一、创建表时添加约束
#1.添加列级约束 --经过试验，只支持非空、默认、主键、唯一
CREATE DATABASE students;
CREATE TABLE stuinfo(
	id INT PRIMARY KEY,#主键
	stuName VARCHAR(20) NOT NULL,#非空
	gender CHAR(1) CHECK(gender='男' OR gender='女'),#检查
	seat INT UNIQUE,#唯一
	age INT DEFAULT 18, #默认约束
	majorId INT REFERENCES major(id)#外键
);

CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);

#2.添加表级约束  --经过试验，仅支持主键、唯一和外键
DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo(
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorId INT,
	
	CONSTRAINT pk PRIMARY KEY(id),
	CONSTRAINT ck CHECK(gender='男' OR gender='女'),
	CONSTRAINT uq UNIQUE(seat),
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id)
);
#通用的写法：
CREATE TABLE IF NOT EXISTS stuinfo(
	id INT PRIMARY KEY,#主键
	stuName VARCHAR(20) NOT NULL,#非空
	gender CHAR(1),
	seat INT UNIQUE,#唯一
	age INT DEFAULT 18, #默认约束
	majorId INT,
	
	CONSTRAINT pk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id)
);


#二、修改表时添加约束
/*
1.添加列级约束
alter table 表名 modify column 字段名 字段类型 新约束;

2.添加表级约束
alter table 表名 add 【constraint 约束名】 约束类型(字段名);

*/
DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo(
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorId INT
);
#1.添加非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20) NOT NULL;
#2.添加默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;
#3.添加主键
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY;
#4.添加外键
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id);

#三、修改表时删除约束
#删除主键
ALTER TABLE stuinfo DROP PRIMARY KEY;
#删除唯一
ALTER TABLE stuinfo DROP INDEX seat;
#删除主键
ALTER TABLE stuinfo DROP PRIMARY KEY fk_stuinfo_major;








