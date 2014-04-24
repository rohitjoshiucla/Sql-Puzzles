create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists supparts;
create table supparts
(sno char(2) not null,
pno char(2) not null,
primary key (sno, pno));

insert into supparts
values
('a','a'),
('a','b'),

('b','a'),
('b','b'),

('c','b'),
('c','d'),

('d','d'),
('d','b');

drop view if exists v;
create view v
as
select sno, password(group_concat(pno order by pno asc)) as hash
from supparts
group by sno;


select *
from
v as v1
left join
v as v2
using(hash)
where v1.sno <> v2.sno;


