# SQL Joins
Table of contents
- [SQL Joins](#sql-joins)
  - [About joins](#about-joins)
  - [Left join](#left-join)
    - [Inner join](#inner-join)
    - [Right join](#right-join)
  - [Combining queries](#combining-queries)

## About joins
A JOIN is the bringing together of two different tables with SOME RELATED data. You cannot store the data in a single table thus you keep them separate. But when you need to display the data together you perform a JOIN.

Prime example is POSTS and their COMMENTS. Posts are related to comments as ONE TO MANY: one post has many comments. Comments are related to posts as BELONGS TO, as a comment can only belong to one post.

When joining the tables SQL will look up related comments through a foreign key that is equal to the post_id or primary key of the post.

## Left join
Use a LEFT JOIN when you want all the data from table A and only the data from table B where there is a match on the JOIN CONDITION you specify.

You could do a query with normal conditional statements using `WHERE` but this does not scale well. There is a N+1 problem: you have to make one query for all the posts (+1) plus n queries for each post(n). Thus for 100 post you make 101 queries, which does not scale well.

Example: return all posts with the matching comments for each post.
```SQL
select * from posts
left join comments on posts.post_id = comments.post_id; 
```
The output will be: 
```
post1 content comment1
post1 content comment2
post1 content comment3
post2 content comment1
post2 content comment2
post3 content comment1
etc.
```
For each comment you get additional row and each row now contains extra columns with the data of the comments.

The next step would be to pull this joined data into an application and de-duplicate it into an array of posts with each post containing an array of comments.

NOTE: With a left join you get the all the data of table A even if there is no related data found in table B. It displays null.

### Inner join
INNER JOIN only returns the data from table A if at least one match is found in table B. Otherwise it works exactly as LEFT JOIN.
```SQL
select * from posts
inner join comments on posts.post_id = comments.post_id; 
``` 

### Right join
RIGHT JOIN is the opposite of a LEFT JOIN: you get all the data rows of table B with matches in table A.
```SQL
select * from posts
right join comments on posts.post_id = comments.post_id; 
```
In the case of the blog post there is no use for this operation, it will return the same result as the inner join.
 
## Combining queries
You can add conditional or order statements to the output of JOIN operations. For example, get all comments for one post and order the comment in descending order (last is first);
```SQL
select * from posts
left join comments on posts.post_id = comments.post_id
where posts.post_id=2
order by comments.comment_id desc;
```