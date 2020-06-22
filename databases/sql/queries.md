# SQL Queries
Table of contents
- [SQL Queries](#sql-queries)
	- [Insert](#insert)
	- [Select](#select)

## Insert
To insert new entries you insert a new row into a table and specify the values for each column: `insert into <tablename> values (default, 'string', num);`

You can specify the column names but the number of columns you specify must match the number of values you enter: `insert into <tablename> (id, name, age) values (default, 'string', num);`
Insert multiple rows:
```SQL
insert into users (name, age, created_at) values ('name1', 34, now()),('name2',33, now()),('name3',23, now());
```

## Select
Retrieve or show the data in the table.
```
select * from <tablename>;	
//-> all records
```	
To limit the output to certain COLUMNS:
```
select name, age from <tablename>;
```

### Condtional statements: WHERE, AND
The WHERE keyword can be used multiple times with the keyword AND
```
select * from <tablename> where age = '30';
select * from <tablename> where name = 'Joris' and where country = 'Spain';
```
### Condtional statements: WHERE LIKE
The LIKE keyword to search for parts of a string:
```
select * from <tablename> where <colum> like 'a%'
SELECT * FROM users WHERE dept LIKE 'd%';
SELECT * FROM users WHERE dept LIKE 'dev%';
```
### Order output: ORDER BY
Indicate the order with asc/desc
```
select * from <tablename> where country = 'Spain' order by age asc;	
```
### Limit output: LIMIT
```
select * from <tablename> where country = 'Spain' order by age asc limit 3;	
//-> limits to three records
```

## Update
### Update entire column
This is dangerous because you will update all records in the table.
```
//update <tablename> set <column> = value;
update users set age = 40;
```
### Update a row or record
```
//update <tablename> where <column> = value set <column> = value;
update users where id = '22' set age = 34;
	
//note that in some SQL databases the syntax is reversed, MARIADB:
update users set age = 34 where id = '22';
```
## Delete
### Delete a row or record
```
delete from <tablename> where <column>=value;

//drop an entire column
alter table <tablename>
drop column <column>;
```
## Transactions
Update and delete can destroy your database. ALWAYS double check those queries with a TRANSACTION. You can query the database without actually committing the changes.

Also use transactions for BULK INSERTS. If you insert thousands of records at once, that means that the db has to re-index thousands of times in a row. By using transactions that re-index happens only once.
```
start transaction;
delete from <tablename> where <column>=value;

//Check your changes.

//Rollback the changes if necessary:
rollback;

//If all is well COMMIT:
commit;
```