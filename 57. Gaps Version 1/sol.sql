create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists numbers;
create table numbers (seq integer not null primary key);
insert into numbers
values (2), (3), (5), (7), (8), (14), (20);

drop view if exists start_num;
create view start_num
as
select seq
from numbers
where (seq+1) not in (select seq from numbers);

drop view if exists end_num;
create view end_num
as
select seq
from numbers
where (seq-1) not in (select seq from numbers);

select seq, (select min(seq) from numbers as n where n.seq > s.seq and n.seq-1 not in (select seq from numbers) ) as next
from 
start_num as s;
