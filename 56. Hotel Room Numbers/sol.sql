create database if not exists sqlpuzzle;
use sqlpuzzle;


drop table if exists hotel;
create table hotel
(
id integer auto_increment, 
floor_nbr integer not null,
room_nbr integer default 1,
primary key (id, floor_nbr, room_nbr)
);


insert into hotel(floor_nbr)
values
(1),
(1),
(1),
(2),
(2),
(2),
(3);

drop view if exists v;
create view v
as
(
select id, floor_nbr, (select 1 + count(*) from hotel as h2 where h1.floor_nbr = h2.floor_nbr and h2.id < h1.id ) as rowNum
from 
hotel as h1
);

update hotel as h
set room_nbr = 100*floor_nbr + (select rowNum from v where v.id = h.id);


