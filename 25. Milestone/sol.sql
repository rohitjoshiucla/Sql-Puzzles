create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists servicesschedule;
create table servicesschedule
(shop_id char(3) not null,
order_nbr char(10) not null,
sch_seq integer not null ,
service_type char(2) not null,
sch_date date,
primary key (shop_id, order_nbr, sch_seq));

insert into servicesschedule
values
(002,4155526710,1,01,'1994-07-16'),
(002,4155526710,2,01,'1994-07-30'),
(002,4155526710,3,01,'1994-10-01'),
(002,4155526711,1,01,'1994-07-16'),
(002,4155526711,2,01,'1994-07-30'),
(002,4155526711,3,01,null);


select s.shop_id,s.order_nbr, min(case when s.sch_seq=1 then s.sch_date end) as start_date,
				max(case when s.sch_seq=3 then s.sch_date end) as end_date
from servicesschedule as s
group by s.shop_id,s.order_nbr;
