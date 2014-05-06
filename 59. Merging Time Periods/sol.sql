create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists timesheets;
create table timesheets
(task_id integer not null primary key,
start_date date not null,
end_date date not null,
check(start_date <= end_date));

insert into timesheets
values (1, '1997-01-01', '1997-01-03'),
(2, '1997-01-02', '1997-01-04'),
(3, '1997-01-04', '1997-01-05'),
(4, '1997-01-06', '1997-01-09'),
(5, '1997-01-09', '1997-01-09'),
(6, '1997-01-09', '1997-01-09'),
(7, '1997-01-12', '1997-01-15'),
(8, '1997-01-13', '1997-01-14'),
(9, '1997-01-14', '1997-01-14'),
(10, '1997-01-17', '1997-01-17');

drop view if exists start_time;
create view start_time
as
select task_id, start_date
from timesheets as t1
where not exists (select * from timesheets as t2 where t1.start_date > t2.start_date and t1.start_date <= t2.end_date);

select task_id, start_date,
							(case
								when (
										exists (select * from start_time as s2 where s2.task_id in (select s.task_id + 1) )
										or (s.task_id = (select max(task_id) from start_time))
									)
									then
										(select end_date from timesheets as t where t.task_id = s.task_id)
								else
									(
										select end_date
										from timesheets as t
										where t.task_id = (select min(task_id) from start_time as s2 where s2.task_id > s.task_id) - 1
								    )
							end
							) as end_date
from start_time as s;