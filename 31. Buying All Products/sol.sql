create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists customers;
create table customers
(customer_id integer not null primary key,
acct_balance decimal (12, 2) not null
);

drop table if exists orders;
create table orders
(customer_id integer not null,
order_id integer not null primary key
);

drop table if exists orderdetails;
create table orderdetails
(order_id integer not null,
item_id integer not null,
primary key(order_id, item_id),
item_qty integer not null
);

drop table if exists products;
create table products
(item_id integer not null primary key
);

insert into customers
values
(1, 1000),
(2, 5000);

insert into orders
values
(1, 1),
(1, 2),
(2, 3);

insert into orderdetails
values
(1, 1, 100),
(2, 2, 300),
(3, 1, 200);

insert into products
values
(1),
(2);


select customer_id
from
	customers as c1
	cross join
	(
		select *
		from 
			orders as o1
			cross join
			(
				select *
				from
					orderdetails as o2
					cross join
					products as p1
					
				using(item_id)
			) as t2
			using(order_id)
	) as t1
	using(customer_id)
	group by customer_id
	having count(distinct item_id) = (select count(*) from products);