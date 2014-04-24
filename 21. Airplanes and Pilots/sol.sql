create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists pilotskills;
create table pilotskills
(pilot char(15) not null,
plane char(15) not null,
primary key (pilot, plane));

insert into pilotskills
values ('celko', 'piper cub'),
('higgins', 'b-52 bomber'),
('higgins', 'f-14 fighter'),
('higgins', 'piper cub'),
('jones', 'b-52 bomber'),
('jones', 'f-14 fighter'),
('smith', 'b-1 bomber'),
('smith', 'b-52 bomber'),
('smith', 'f-14 fighter'),
('wilson', 'b-1 bomber'),
('wilson', 'b-52 bomber'),
('wilson', 'f-14 fighter'),
('wilson', 'f-17 fighter');

drop table if exists hangar;
create table hangar
(plane char(15) primary key);

insert into hangar
values ('b-1 bomber'),
('b-52 bomber'),
('f-14 fighter');




select p.pilot
from pilotskills as p
inner join hangar as h
on p.plane = h.plane
group by p.pilot
having count(*) = (select count(*) from hangar);