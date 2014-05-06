create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists tickets;
create table tickets
(buyer_name char(5) not null,
ticket_nbr integer default 1 not null,
primary key (buyer_name, ticket_nbr));

insert into tickets
values ('a', 2), ('a', 3), ('a', 4),
('b', 4),
('c', 1), ('c', 2), ('c', 3), ('c', 4), ('c', 5),
('d', 1), ('d', 6), ('d', 7), ('d', 9),
('e', 10);


drop view if exists start_num;
create view start_num
as
select buyer_name, ticket_nbr
from tickets
where (buyer_name, ticket_nbr+1) not in (select * from tickets);

select * from
(
	select buyer_name,ticket_nbr, (	
									select min(ticket_nbr) from tickets as t
										where t.buyer_name = s.buyer_name and 
										t.ticket_nbr > s.ticket_nbr and 
										(t.buyer_name, t.ticket_nbr -1) not in 
											(select * from tickets as t2 where t2.buyer_name = t.buyer_name) 
										) as next
	from start_num as s
) as t3
where next is not null;

