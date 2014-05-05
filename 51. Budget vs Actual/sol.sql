create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists budgeted;
create table budgeted
(task integer not null primary key,
category integer not null,
est_cost decimal(8,2) not null);

drop table if exists actual;
create table actual
(voucher decimal(8,2) not null primary key,
task integer not null references budgeted(task),
act_cost decimal(8,2) not null);

insert into budgeted 
values
(1,9100,100.00),
(2,9100,15.00),
(3,9100,6.00),
(4,9200,8.00),
(5,9200,11.00);

insert into actual
values
(1,1,10.00),
(2,1,20.00),
(3,1,15.00),
(4,2,32.00),
(5,4,8.00),
(6,5,3.00),
(7,5,4.00);

select category, sum(est_cost) as est_cost, sum(act_cost) as act_cost
from
	(
		select *
		from budgeted
		left join
		(
			select task, sum(act_cost) as act_cost
			from
			actual
			group by task
		) as t2
		using(task)
	) as t1
	group by category;
	
