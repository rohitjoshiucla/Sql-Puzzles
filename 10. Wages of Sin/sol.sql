create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists pensions;
create table pensions(
ssn char(10) not null,
pen_year integer not null,
month_cnt integer default 0 not null,
earnings decimal (8,2) default 00.00 not null
);



insert into pensions
values
('a',2013,12, 1000.00),
('a',2012,12, 1000.00),
('a',2011,12, 1000.00),
('a',2009,12, 1000.00),
('a',2008,12, 1000.00);

drop view if exists v;
create view v
as
(
select *, 	(select p.earnings + sum(earnings) as s_earn from pensions where ssn = 'a' and pen_year > p.pen_year) as addon1,
			(select p.month_cnt+ sum(month_cnt) as s_m_count from pensions where ssn = 'a' and pen_year > p.pen_year) as addon2
from pensions as p
where ssn = 'a'
order by pen_year desc
); 

select *
from v
where ssn = 'a' and addon2 = (
								select min(addon2)
								from v
								where ssn='a' and addon2 >= 60 );
								
								