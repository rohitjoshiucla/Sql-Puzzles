create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists consumers;
create table consumers(
	con_name char(10) not null,
	address char(5) not null,
	con_id integer primary key,
	fam_id integer
);

insert into consumers
values
('Bob', 'A', 1, NULL),
('Joe', 'B', 3, NULL),
('Mark', 'C', 5, NULL),
('Mary', 'A', 2, 1),
('Vickie', 'B', 4, 3),
('Wayne', 'D', 6, NULL);

select * from consumers;

drop view if exists v;
create view v
as
(select distinct fam_id from consumers where fam_id is not null);


delete from consumers 
where fam_id is NULL and con_id in (select * from v) ;

select * from consumers;