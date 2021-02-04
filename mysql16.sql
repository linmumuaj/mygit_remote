#标识列
/*
又称为自增长列
含义：可以不用手动的插入值，系统提供默认的序列值

特点：
1.标识列不一定非要和主键搭配，但是要求是和一个key搭配，比如唯一、外键这些
2.一个表中至多只有一个标识列
3.标识列的类型只能是数值型
4.标识列可以通过sey auto_increment_increment=3;设置步长
  也可以通过手动插入值，设置起始值，即在添加第一个值时设置的值就是起始值，后面再插入就可以不设置这个值
  

*/
#一、创建表时设置标识列
CREATE TABLE tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20)
);

INSERT INTO tab_identity VALUES(NULL,'Lily');
SELECT * FROM tab_identity;

#二、修改表时设置标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

#三、修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY；



