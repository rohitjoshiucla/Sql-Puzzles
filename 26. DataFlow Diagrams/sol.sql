create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists dataflowdiagrams;
create table dataflowdiagrams
(diagram_name char(10) not null,
bubble_name char(10) not null,
flow_name char(10) not null,
primary key (diagram_name, bubble_name, flow_name));

insert into dataflowdiagrams
values
('Proc1','input','guesses'),
('Proc1','input','opinions'),
('Proc1','crunch','acts'),
('Proc1','crunch','guesses'),
('Proc1','crunch','opinions'),
('Proc1','output','facts'),
('Proc1','output','guesses'),
('Proc2','reckon','guesses'),
('Proc2','reckon','opinions');

select diagram_name, bubble_name
from
dataflowdiagrams
group by
diagram_name, bubble_name
having count(*) <> (select count(distinct flow_name) from dataflowdiagrams );