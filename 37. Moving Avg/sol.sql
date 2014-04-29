create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists samples;
create table samples
(sample_time timestamp not null primary key,
loadd integer not null);

insert into samples
values
('2000-10-01 00:00', 10),

('2000-10-01 00:05', 10),
('2000-10-01 00:10', 10),
('2000-10-01 00:15', 10),

('2000-10-01 00:20', 10),
('2000-10-01 00:25', 10),
('2000-10-01 00:30', 10),

('2000-10-01 00:35', 10),
('2000-10-01 00:40', 10),
('2000-10-01 00:45', 10),

('2000-10-01 00:50', 10),
('2000-10-01 00:55', 10),
('2000-10-01 01:00', 10),

('2000-10-01 01:05', 10),
('2000-10-01 01:10', 10),
('2000-10-01 01:15', 10),

('2000-10-01 01:20', 10),
('2000-10-01 01:25', 10),
('2000-10-01 01:30', 10),

('2000-10-01 01:35', 10),
('2000-10-01 01:40', 10),
('2000-10-01 01:45', 10),

('2000-10-01 01:50', 10),
('2000-10-01 01:55', 10),
('2000-10-01 02:00', 10);


drop view if exists v;
create view v
as
	select sample_time, 
		(select avg(s1.loadd) 
			from samples as s1 
			where s1.sample_time < s.sample_time 
				and s1.sample_time >= (s.sample_time - interval 15 minute) 
		) 	as cumulativeSum
		
		from samples as s
		where mod(minute(s.sample_time), 15) = 0;

select * from view;


/* we can add to view on insert to samples*/


