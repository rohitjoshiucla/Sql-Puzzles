create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists register;
create table register
(course_nbr integer not null,
student_name char(10) not null,
teacher_name char(10) not null
);


insert into register
values
(1,'a','ta'),
(1,'b','ta'),
(1,'c','tb'),
(1,'d','tb');

select course_nbr, (select teacher_name from register order by teacher_name asc limit 1) as teacher_name,
					(select 	
							case (select  count(distinct teacher_name) from register where course_nbr = r.course_nbr)
									when 1 then null
									when 2 then (select teacher_name from register order by teacher_name desc limit 1 )
									else 'more--'
							end
					) as teacher_name
from
(select distinct course_nbr
from register) as r;
