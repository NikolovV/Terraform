create table users
(
uuid serial PRIMARY KEY,
first_name VARCHAR ( 50 ),
last_name VARCHAR ( 50 )
);

insert into users(first_name,last_name)
values('John', 'One');

select * from users u ;