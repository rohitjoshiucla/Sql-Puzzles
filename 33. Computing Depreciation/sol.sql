create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists manufacthrscosts;
create table manufacthrscosts
(machine_name char(20) not null
references machines(machine_name),
manu_date date not null,
batch_nbr integer not null,
manu_hrs decimal(4,2) not null,
manu_cost decimal (6,2) not null,
primary key (machine_name, manu_date, batch_nbr));

insert into manufacthrscosts
values
('Frammis','1995-07-24',101,2.5,123.00),
('Frammis','1995-07-25',102,2.5,125.00),
('Frammis','1995-07-25',103,2.0,110.00),
('Frammis','1995-07-26',104,2.5,125.00),
('Frammis','1995-07-27',105,2.5,120.00),
('Frammis','1995-07-27',106,2.5,120.00),
('Frammis','1995-07-28',107,2.5,125.00);

select manu_date, (select sum(manu_cost) from manufacthrscosts as m1 where m1.manu_date <= m.manu_date) /
				  (select sum(manu_hrs) from manufacthrscosts as m1 where m1.manu_date <= m.manu_date) as avgg
from manufacthrscosts as m;