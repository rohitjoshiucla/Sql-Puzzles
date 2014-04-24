create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists sales;
create table sales
(customer_name char(5) not null,
sale_date date not null,
primary key (customer_name, sale_date));

insert into sales
values
('Fred','1994-06-01'),
('Mary','1994-06-01'),
('Bill','1994-06-01'),
('Fred','1994-06-02'),
('Bill','1994-06-02'),
('Bill','1994-06-03'),
('Bill','1994-06-04'),
('Bill','1994-06-05'),
('Bill','1994-06-06'),
('Bill','1994-06-07'),
('Fred','1994-06-07'),
('Mary','1994-06-08');


select s.customer_name, (datediff( max(sale_date),min(sale_date) )  )/(count(*)-1) as avg_wait
from sales as s
group by s.customer_name;