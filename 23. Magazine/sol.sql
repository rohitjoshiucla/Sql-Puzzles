create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists titles;
create table titles
(product_id integer not null primary key,
magazine_sku integer not null,
issn integer not null,
issn_year integer not null);

insert into titles
values 
(1, 12345, 1, 2006), 
(2, 2667, 1, 2006), 
(3, 48632,1, 2006),
(4, 1107, 1, 2006),
(5, 12345, 2, 2006),
(6, 2667, 2, 2006),
(7, 48632, 2, 2006),
(8, 1107, 2, 2006);

drop tables if exists sales;
create table sales
(product_id integer not null,
stand_nbr integer not null,
net_sold_qty integer not null);


insert into sales values (1, 1, 1);
insert into sales values (2, 1, 4);
insert into sales values (3, 1, 1);
insert into sales values (4, 1, 1);
insert into sales values (5, 1, 1);
insert into sales values (6, 1, 2);
insert into sales values (7, 1, 1);


insert into sales values (4, 2, 5);
insert into sales values (8, 2, 6);
insert into sales values (3, 2, 1);


insert into sales values (1, 3, 1);
insert into sales values (2, 3, 3);
insert into sales values (3, 3, 3);
insert into sales values (4, 3, 1);
insert into sales values (5, 3, 1);
insert into sales values (6, 3, 3);
insert into sales values (7, 3, 3);


insert into sales values (1, 4, 1);
insert into sales values (2, 4, 1);
insert into sales values (3, 4, 4);
insert into sales values (4, 4, 1);
insert into sales values (5, 4, 1);
insert into sales values (6, 4, 1);
insert into sales values (7, 4, 2);


select stand_nbr, 	avg(case when t1.magazine_sku = 2667 then net_sold_qty end ) as a1,
					avg(case when t1.magazine_sku = 48632 then net_sold_qty end ) as a2,
					avg(case when t1.magazine_sku = 1107 then net_sold_qty end ) as a3
from
	titles as t1
	inner join 
	sales as s1
	using (product_id) 
	group by s1.stand_nbr
	having (a3 > 5) or (a1 > 2 and a2 > 2);


