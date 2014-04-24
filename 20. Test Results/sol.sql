create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists testresults;
create table testresults
(test_name char(20) not null,
test_step integer not null,
comp_date date, -- null means incomplete
primary key (test_name, test_step));

insert into testresults
values
('a',1,'2000-10-01'),
('a',2,'2000-10-01'),
('a',3,'2000-10-01'),
('b',1,'2000-10-01'),
('b',2,null);

select test_name
from testresults
group by test_name
having count(*) = count(comp_date);

