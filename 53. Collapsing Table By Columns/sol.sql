create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists foobar;
create table foobar
(lvl integer not null primary key,
color varchar(10),
length integer,
width integer,
hgt integer);

insert into foobar
values (1, 'red', 8, 10, 12),
(2, null, null, null, 20),
(3, null, 9, 82, 25),
(4, 'blue', null, 67, null),
(5, 'gray', null, null, null);


select
	(
		select color
		from foobar
		where color is not null
		order by lvl desc limit 1 
	) as color,
	(
		select length
		from foobar
		where length is not null
		order by lvl desc limit 1 
	) as length,
	(
		select width
		from foobar
		where width is not null
		order by lvl desc limit 1 
	) as width,
	(
		select hgt
		from foobar
		where hgt is not null
		order by lvl desc limit 1 
	) as hgt
	
	; 