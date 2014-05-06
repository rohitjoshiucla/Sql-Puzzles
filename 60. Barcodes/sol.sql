create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists t;
create table t
(  pos integer primary key,
   mul integer not null
);
insert into t
values
(1,1),
(2,-1),
(3,1),
(4,-1),
(5,1),
(6,-1),
(7,1),
(8,-1),
(9,1),
(10,-1),
(11,1),
(12,-1);

drop procedure if exists p;
delimiter //
create procedure p(IN a char(13))
begin
	select mod(abs(sum(t.mul*substring(a,t.pos,1))),10)=substring(a,13,1) as result
	from
	t;
end //
delimiter ;

call p('2837232811227');