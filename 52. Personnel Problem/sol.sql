create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists person;
create table person
( emp_name char(10),
  dept_id char(5) 
 );
 
 insert into person 
 values
 ('Daren','Acct'),
('Joe','Acct'),
('Lisa','DP'),
('Helen','DP'),
('Fonda','DP');


select count(*)/count(distinct dept_id) as avgg
from person;