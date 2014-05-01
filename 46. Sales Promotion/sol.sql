create database if not exists sqlpuzzle;
use sqlpuzzle;


drop table if exists promotions;
create table promotions
(promo_name char(25) not null primary key,
start_date date not null,
end_date date not null,
check (start_date <= end_date));

drop table if exists sales;
create table sales
(ticket_nbr integer not null primary key,
clerk_name char (15) not null,
sale_date date not null,
sale_amt decimal (8,2) not null);

insert into promotions
values
('Feast of St. Fred', '1995-02-01', '1995-02-07'),
('National Pickle Pageant', '1995-11-01', '1995-11-07'),
('Christmas Week', '1995-12-18', '1995-12-25');

insert into sales
values
(1, 'a', '1995-02-01', 10.22),
(3, 'a', '1995-11-01', 10.22),
(4, 'b', '1995-11-01', 10.22),
(5, 'b', '1995-11-01', 10.22),
(6, 'b', '1995-12-18', 10.22);

select promo_name, clerk_name, max(count) as maxCount
	from
		(
			select clerk_name, count(*) as count, promo_name
				from
					(
						select clerk_name, 	(
												select promo_name
													from
														promotions as p
													where
														s.sale_date >= p.start_date and s.sale_date <= p.end_date
											) as promo_name
							from
								sales as s
					)	as t1
				group by clerk_name, promo_name
		) as t2
		group by promo_name;