create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists mytable;
create table mytable
(keycol integer not null,
f1 integer not null,
f2 integer not null,
f3 integer not null,
f4 integer not null,
f5 integer not null,
f6 integer not null,
f7 integer not null,
f8 integer not null,
f9 integer not null,
f10 integer not null);

insert into mytable
values
(1,1,0,0,0, 0,0,0, 0,0,0),
(2,1,1,0,0, 0,0,0, 0,0,0),
(3,1,1,1,0, 0,0,0, 0,0,0);


select keycol
from mytable
where (f1+f2+f3+f4+f5+f6+f7+f8+f9+f10) = greatest(f1,f2,f3,f4,f5,f6,f7,f8,f9,f10);