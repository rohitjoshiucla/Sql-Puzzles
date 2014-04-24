create database if not exists sqlpuzzle;
use sqlpuzzle;


drop table if exists salesdata;
create table salesdata
(district_nbr integer not null,
sales_person char(10) not null,
sales_id integer not null,
sales_amt decimal(5,2) not null);

insert into salesdata
values
(1,'Curly',5,3.00),
(1,'Harpo',11,4.00),
(1,'Larry',1,50.00),
(1,'Larry',2,50.00),
(1,'Larry',3,50.00),
(1,'Moe',4,5.00),
(2,'Dick',8,5.00),
(2,'Fred',7,5.00),
(2,'Harry',6,5.00),
(2,'Tom',7,5.00),
(3,'Irving',10,5.00),
(3,'Melvin',9,7.00),
(4,'Jenny',15,20.00),
(4,'Jessie',16,10.00),
(4,'Mary',12,50.00),
(4,'Oprah',14,30.00),
(4,'Sally',13,40.007);

drop view if exists v;
create view v as
select district_nbr, sales_person, sales_id, max(sales_amt) as sales_amt
from salesdata
group by district_nbr, sales_person;


/*
select *
from v
where (district_nbr,sales_person, sales_id, sales_amt) in 
	(
	select * 
	from v as v1
	where v1.district_nbr = district_nbr
	order by sales_amt desc limit 3
	);
*/
	
select *
from v as v1
where (select count(*) from v as v2 where v2.district_nbr = v1.district_nbr and v2.sales_amt > v1.sales_amt) < 3;

