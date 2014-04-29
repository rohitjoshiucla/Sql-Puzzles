create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists inventoryadjustments;
create table inventoryadjustments
(req_date date not null,
primary key (req_date, req_qty));
req_qty integer not null,

insert into inventoryadjustments
values
('1994-07-01',100),
('1994-07-02',120),
('1994-07-03',-150),
('1994-07-04',50),
('1994-07-05',-35);


select *, (select sum(i1.req_qty) from inventoryadjustments as i1 where i1.req_date <= i.req_date) as qty_on_hand
from inventoryadjustments as i;

