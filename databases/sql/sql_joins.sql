/*
BLOG POSTS AND COMMENTS
*/
create table posts (
    post_id bigint unsigned not null auto_increment,
    title varchar(128) not null,
    content text not null,
    primary key (post_id)
)engine=innodb
default charset=utf8
default collate=utf8_unicode_ci;

insert into posts (title, content) values('post1', 'content post1'),
('post2', 'content post2'),('post3', 'content post3'),('post4', 'content post4');

create table comments (
    comment_id bigint unsigned not null auto_increment,
    post_id bigint unsigned not null,
    content text not null,
    primary key (comment_id),
    key post_id (post_id)
)engine=innodb
default charset=utf8
default collate=utf8_unicode_ci;

/*comments for post 1*/
insert into comments (post_id,content) values(1, 'comment 1');
/*comments for post 2*/
insert into comments (post_id,content) values(2, 'comment 1'),(2, 'comment 2');
/*comments for post 3*/
insert into comments (post_id,content) values(3, 'comment 1'),(3, 'comment 2'),(3, 'comment 3');
/*post 4 has no comments*/

/*LEFT JOIN: all posts with their related comments*/
select * from posts
left join comments on posts.post_id = comments.post_id 
where posts.post_id=3
order by comments.comment_id desc;
/*INNER JOIN: all posts with their related comments if at least one exists*/
select * from posts
inner join comments on posts.post_id = comments.post_id; 