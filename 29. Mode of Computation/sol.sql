create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists payroll;
create table payroll
(check_nbr integer not null primary key,
check_amt decimal(8,2) not null );

insert into payroll
values
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,2),
(7,2),
(8,2);

select max(t1.c), t1.a
from(
	select count(*) as c, check_amt as a
		from payroll
	group by check_amt
	) as t1;
