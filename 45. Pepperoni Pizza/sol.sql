create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists pizza;
create table pizza(
	cust_id integer not null,
	bill_date date not null,
	bill_amt decimal(10,2) not null
);

insert into pizza
values
(1,'2014-05-01',10.12),
(1,'2014-05-01',10.12),
(1,'2014-01-02',10.12),
(1,'2013-10-03',10.12),
(2,'2014-03-01',10.12);


select cust_id, 
				sum(
					case 
						when 
							(select bill_date > (select curdate() - interval 30 day) ) = 1
							and
							(select bill_date <= (select curdate() ) ) = 1
						then
							bill_amt
					end
				) as zero2thirty,
				
				sum(
					case 
						when 
							(select bill_date > (select curdate() - interval 60 day) ) = 1
							and
							(select bill_date <= (select curdate() - interval 30 day) ) = 1
						then
							bill_amt
					end
				) as thirty2sixty,
				
				sum(
					case 
						when 
							(select bill_date > (select curdate() - interval 90 day) ) = 1
							and
							(select bill_date <= (select curdate() - interval 60 day) ) = 1
						then
							bill_amt
					end
				) as sixty2ninety,
				
				sum(
					case 
						when 
							(select bill_date <= (select curdate() - interval 90 day) ) = 1
						then
							bill_amt
					end
				) as ninety2older
	from
		pizza
	group by cust_id;
	
	