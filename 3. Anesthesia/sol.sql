create database if not exists sqlPuzzle;
use sqlPuzzle;

drop table if exists anesthesia;
create table anesthesia(
	proc_id integer primary key,
	anes_name varchar(10) not null,
	start_time time not null,
	end_time time not null
);

insert into anesthesia
values
(10 , 'Baker' , '08:00' , '11:00'),
(20 , 'Baker' , '09:00 ', '13:00'),
(30 , 'Dow' , '09:00' , '15:30'),
(40 , 'Dow' , '08:00' , '13:30'),
(50 , 'Dow' , '10:00' , '11:30'),
(60 , 'Dow' , '12:30' , '13:30'),
(70 , 'Dow' , '13:30' , '14:30'),
(80 , 'Dow' , '18:00' , '19:00');

drop view if exists start_times;
create view start_times
as
		select a.start_time as utime
		from anesthesia as a
;

drop view if exists end_times;
create view end_times
as
		select b.end_time as utime
		from anesthesia as b
;

drop view if exists uni;
create view uni
as
	select utime 
	from start_times
		union
	select utime 
	from end_times
;

drop view if exists slots;
create view slots
as 
	select a.utime as stime, (select min(b.utime)
					 from uni as b
					 where b.utime > a.utime) as etime
	from uni as a
;

drop view if exists dist_anes_name;
create view dist_anes_name
as
	select distinct anes_name
	from anesthesia
;

drop view if exists expand_slots;
create view expand_slots
as
	select s.stime, s.etime, d.anes_name
	from slots as s cross join dist_anes_name as d
;

drop view if exists active;
create view active
as
	select s.stime, s.etime, s.anes_name, ( select count(*)
											from anesthesia as a
											where 
											s.stime >= a.start_time and s.etime <= a.end_time and s.anes_name = a.anes_name
											) as overlap_count
	from expand_slots as s 
;

drop view if exists puzzle;
create view puzzle
as
	select a.proc_id, (select max(overlap_count)
						from active as b
						where b.stime >= a.start_time and b.stime <= a.end_time and a.anes_name= b.anes_name) as max_overlap_count 
	from anesthesia as a
;

select * from puzzle;