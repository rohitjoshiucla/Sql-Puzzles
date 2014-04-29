create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists items;
create table items(
	item_nbr integer not null,
	item_descr char(10) not null
);

insert into items
values
(10,'Item 10'),
(20,'Item 20'),
(30,'Item 30'),
(40,'Item 40'),
(50,'item 50');

drop table if exists actuals;
create table actuals(
	item_nbr integer not null,
	actual_amt integer not null,
	chq_nbr char(10)
);

insert into actuals
values
(10,300.00,'1111'),
(20,325.00,'2222'),
(20,100.00,'3333'),
(30,525.00,'1111');

drop table if exists estimates;
create table estimates(
	item_nbr integer not null,
	estimated_amt integer not null
);

insert into estimates
values
(10,300.00),
(10,50.00),
(20,325.00),
(20,110.00),
(40,25.00);

	(
		select item_nbr, actual_amt, estimated_amt, chq_nbr
			from
			(
			select a.item_nbr, sum(a.actual_amt) as actual_amt, 	
												(
												case 	(	select count(*) 
															from actuals as a1
															where a1.item_nbr = a.item_nbr
														)
													when 1
														then
															 a.chq_nbr
														else
															'mixed'
												end
												) as chq_nbr
			from actuals as a
			group by a.item_nbr
			) as t1
		left join
			(
			select e.item_nbr, sum(e.estimated_amt) as estimated_amt
			from estimates as e
			group by e.item_nbr
			) as t2
		using (item_nbr)
	)
	
	union distinct
	(
		select item_nbr, actual_amt, estimated_amt, chq_nbr
			from
			(
			select a.item_nbr, sum(a.actual_amt) as actual_amt, 	
												(
												case 	(	select count(*) 
															from actuals as a1
															where a1.item_nbr = a.item_nbr
														)
													when 1
														then
															 a.chq_nbr
														else
															'mixed'
												end
												) as chq_nbr
			from actuals as a
			group by a.item_nbr
			) as t1
		right join
			(
			select e.item_nbr, sum(e.estimated_amt) as estimated_amt
			from estimates as e
			group by e.item_nbr
			) as t2
		using (item_nbr)
	);