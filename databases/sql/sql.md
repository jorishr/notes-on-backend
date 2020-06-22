# SQL
Table of contents
- [SQL](#sql)
	- [References](#references)
	- [About SQL](#about-sql)
	- [Data types](#data-types)
	- [Table attributes](#table-attributes)
		- [Primary key](#primary-key)
		- [Foreign key](#foreign-key)
		- [Index](#index)
	- [Table options](#table-options)
	- [Create new table](#create-new-table)
		- [Create new databse](#create-new-databse)
		- [Create a new table](#create-a-new-table)
			- [Example](#example)
	- [Show and delete tables](#show-and-delete-tables)
	- [Add column](#add-column)
	- [Normalizing data](#normalizing-data)

## References
- [Common SQL Commands](https://gist.github.com/bradtraversy/c831baaad44343cc945e76c2e30927b3
)
## About SQL
An SQL based database uses the Structured Query Language (SQL). An opensource relational database system. The relational model of data means that all piece of information are related to one another through a structure of tables with columns and rows. 

Various tables are related through keys. 

Example of a row with columns:
`id firstname lastname email password`

## Data types
Each field can hold different data-types. For each data-type there are multiple options that can have consequences for the data consumption.
- numeric data: int (32-bit integer), bigint (64-bit integer), tinyint (8-bit integer), decimal, float (for scientific precision calculations). `Tinyint` may be statuscode 1-10 for example. With `decimal`(a,b) you have to specify the max number size of digits(a) of which (b) are after the decimal point. `Int` will show up in the table as `int(10)`. Int will always be able store a 32-bit integer. The number refers to the DISPLAY WIDTH, the maximum of digits that can be displayed. This is not very commonly used but if you would zeropad your numbers, one would be written as 9 zero's and 1 or 88 would be 0000000088.

- strings: `text` (max 64kb size), `mediumtext` (max 16mb size), `longtext`, `varchar` (variable length strings). With `varchar(50)` you need to specify a max length but it consumes the space of the actual length. Each row in mysql has a limited size and the varchar max you specify is taken into account there. `Text` on the other hand stores a pointer reference to the actual text stored not in the row but elsewhere.

- dates: date (year-month-data), time(hour:minutes:seconds), datetime(date time)

- others: binary, json

## Table attributes
- unsigned: cannot be negative
- auto_increment: unique for each row, no-reuse after deletion
- not null: field is required
- null: field is optional, thus can be null; this is also the default value thus it not strictly necessary in a table definition.
- default <value>: if not specified by the user

### Primary key
The primary key of a table is the row or field that serves as a primary reference. That field needs to hold values that are unique and cannot be null, thus usually this will be the ID row.

### Foreign key
A foreign key is a field in a table that relates to a PRIMARY KEY in another table.For example, in the table `posts` there is a primary key `post_id`. In the table comments we store a foreign key:
```
primary key (comment_id)
key post_id (post_id)
```
The second key is the foreign id that relates to the post it belongs to.
   
### Index
Indices are created for faster referencing a field that will be queried upon often.
```
//key <name> (<field>)
key status (status)
key birthday_time (birthday, event_time)
```
The example makes the queries status and birthday events much more efficient. Without it MYSQL has to do a full table scan and look for all the individual references time and time again. Indexing is a trade-off. You cannot index every single field because indexing also consumes temporary storage and memory space. Plus, when new records are created they need to be indexed and this can affect the write speed.

It is well worth it though. The decrease in writing speed is minor and the increase in storage requirement is not important.
```
alter table <table_name> add index <index_name> (column)
```

## Table options
The ENGINE that is being used is `engine=innodb`. Only legacy software used older engines. 
The default CHARSET and COLLATIONS are:
```
default charset=utf8
default collate=utf8_unicode_ci;
```

## Create new table
NOTE: 
- syntax statements end with ;
- commands are case INsensitive
- table names and column names ARE case sensitive

### Create new databse
```
create database <name>;

show databases;

use <name>		
// select the database you work on
```

### Create a new table
The most common task is to create tables whereby you need to specify the DATATYPE.

```
//syntax:
create table <tabelName> (
	<fieldname> <fieldtype> <attributes>
)<tabeloptions>;
```

#### Example
The first field usually is an ID which is a `BIGNINT` that is required (NOT NULL) and cannot be negative (UNSIGNED). The `auto_increment` attribute goes up with one each time a new entry is created AND avoids the re-use of records. Thus if you deleted number two, that number will never be re-used. Each single row must have a unique id.

A sensible `varchar` value for names is 50 but you may have to account for longer. A description would be 150 and you can add a default value as an empty string or N/A.

The `created_at stores` the datetime when the record was created.

The TABLE OPTIONS are written outside the parenthesis.
```SQL
create table myTable(
	id bigint unsigned not null auto_increment,
	status tinyint unsigned default 2,
	events int unsigned not null default 0,
	latitude decimal(10, 8) null,
	longitude decimal(11, 8) null,
	name varchar(50) not null,
	description varchar(150) not null default 'N/A',
	bio text null,
	birthday date null,
	event_time time null,
	created_at datetime not null,
	primary key(id),
	key status (status),
	key birthday_time (birthday, event_time)
)engine=innodb 
default charset=utf8
default collate=utf8_unicode_ci;
```

## Show and delete tables
```
describe <table-name>;

drop <table-name>;
```

## Add column
```
//ALTER TABLE <tablename ADD <column> <datatype>;

ALTER TABLE users ADD age VARCHAR(3);
```

## Normalizing data
Normalize your data by keeping data seperated and use foreign keys to reference that data. Example of a blog: 
```
posts table
	-post_id
	-title
	-author_name
```
This is problematic because adding additional author data means creating additional columns. And each time an author name changes you have to update all the related posts. Better use an `author_id` that reference the author data in a seperate table.
```
posts table
	-post_id
	-title
	-author_id	(this is the foreign key)

authors table
	-author_id
	-name
	-data_of_birth
	-email
```