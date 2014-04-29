create database if not exists sqlpuzzle;
use sqlpuzzle;


drop table if exists taxauthorities;
create table taxauthorities
(tax_authority char(10) not null,
tax_area char(10) not null,
primary key (tax_authority, tax_area));

insert into taxauthorities
values
('city1','city1'),
('city2','city2'),
('city3','city3'),
('county1','city1'),
('county1','city2'),
('county2','city3'),
('state1','city1'),
('state1','city2'),
('state1','city3');

drop tables if exists taxrates;
create table taxrates
(tax_authority char(10) not null,
effect_date date not null,
tax_rate decimal (8,2) not null,
primary key (tax_authority, effect_date));

insert into taxrates
values
('city1','1993-01-01',1.0),
('city1','1994-01-01',1.5),
('city2','1993-09-01',1.5),
('city2','1994-01-01',2.0),
('city2','1995-01-01',2.0),
('city3','1993-01-01',1.7),
('city3','1993-07-01',1.9),
('county1','1993-01-01',2.3),
('county1','1994-10-01',2.5),
('county1','1995-01-01',2.7),
('county2','1993-01-01',2.4),
('county2','1994-01-01',2.7),
('county2','1995-01-01',2.8),
('state1','1993-01-01',0.5),
('state1','1994-01-01',0.8),
('state1','1994-07-01',0.9),
('state1','1994-10-01',1.1);

set @k = 'city2';
set @d = '1994-11-04';
select *
from
taxrates as t3
inner join
	(
	select tax_authority, max(case when t2.effect_date < @d then t2.effect_date end) as effect_date
	from
		(select *
		from taxauthorities
		where tax_area = @k) as t1

		inner join

		taxrates as t2
		using (tax_authority)
	group by tax_authority
	) as t4
using (tax_authority, effect_date);
