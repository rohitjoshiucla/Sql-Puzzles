create database if not exists sqlPuzzle;
use sqlPuzzle;

drop table if exists  seats ;
create table seats(
id integer primary key
);


insert into seats
values
(1),
(2),
(3),
(11),
(12),
(21),
(22),
(23);

drop view if exists s;
create view s
as
select id
from seats
where (id-1) not in (select id from seats);

drop view if exists e;
create view e
as
select id
from seats
where (id+1) not in (select id from seats);

select s.id as sId, (select min(e.id) from e where e.id > s.id) as eId
from s