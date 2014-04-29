create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists consultants;
create table consultants
(emp_id integer not null,
emp_name char(10) not null);

insert into consultants
values (1, 'larry'),
(2, 'moe'),
(3, 'curly');

drop table if exists billings;
create table billings
(emp_id integer not null,
bill_date date not null,
bill_rate decimal (5,2));

insert into billings
values 
(1, '1990-01-01', 25.00),
(2, '1989-01-01', 15.00),
(3, '1989-01-01', 20.00),
(1, '1991-01-01', 30.00);

drop table if exists hoursworked;
create table hoursworked
(job_id integer not null,
emp_id integer not null,
work_date date not null,
bill_hrs decimal(5, 2));

insert into hoursworked
values
(4, 1, '1990-07-01', 3),
(4, 1, '1990-08-01', 5),
(4, 2, '1990-07-01', 2),
(4, 1, '1991-07-01', 4);

select job_id, emp_name, totalCharges
	from
	(
		select job_id, emp_id, 
				sum(bill_hrs*bill_rate) as totalCharges
		from
			(
				select h.job_id,h.emp_id,h.bill_hrs,
						(select max(b.bill_date) from billings as b where b.bill_date < h.work_date and b.emp_id = h.emp_id ) as bill_date
				from hoursworked as h
			) as t1
			inner join billings as t2
			using(emp_id, bill_date)
			group by job_id, emp_id
	) as t3
	inner join consultants
	using(emp_id)
	;