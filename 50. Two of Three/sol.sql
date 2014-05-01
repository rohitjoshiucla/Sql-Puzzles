create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists anthologycontributors;
create table anthologycontributors
(isbn char(20) not null,
contributor char(20) not null,
category integer not null);


insert into anthologycontributors
values
('0000-0000-0000-0001', 'rj', 1),
('0000-0000-0000-0001', 'rj', 2),
('0000-0000-0000-0001', 'rj', 3),
('0000-0000-0000-0001', 'mj', 1),
('0000-0000-0000-0001', 'mj', 2);

select contributor
from 
anthologycontributors
group by isbn, contributor
having count(distinct category) = 2;