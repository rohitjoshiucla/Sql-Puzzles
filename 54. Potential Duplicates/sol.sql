create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists customer;
create table customer(
	id integer not null,
	last_name char(15) not null,
	first_name char(15) not null,
	street_addr char(15) not null,
	city_name char(15) not null,
	state_code char(15) not null,
	phone_nbr char(15) not null
);

insert into customer
values
(1,'a', 'b', '550 veteran ave', 'los angeles', '90024', '0001112222'),
(2,'a', 'c', '550 veteran ave', 'los Angeles', '90034', '0001112222'),
(3,'a', 'd', '550 veteran ave', 'los Angeles', '90024', '0001113222');

select c1.last_name,c1.id, c2.last_name,c2.id
	from
		customer as c1
		cross join
		customer as c2
		where c1.last_name=c2.last_name
		and c1.id < c2.id
		and
			(
				(select c1.first_name=c2.first_name)
				+
				(select c1.street_addr=c2.street_addr)
				+
				(select c1.city_name=c2.city_name)
				+
				(select c1.state_code=c2.state_code)
				+
				(select c1.phone_nbr=c2.phone_nbr)
			) >=2 ;
			
			
/* now delete from customer all c2.id
   then
   delete from customer c1.id which does not exist in customer
   - we get all originals
*/