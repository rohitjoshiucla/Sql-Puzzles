create database if not exists sqlpuzzle;
use sqlpuzzle;

set foreign_key_checks = 0;
drop table if exists units;
drop table if exists tenants;
drop table if exists rentpayments;
set foreign_key_checks = 1;

create table units(
	complex_id integer not null,
	unit_nbr integer not null,
	primary key(complex_id, unit_nbr)
);
insert into units
values
(32, 1),
(32, 2),
(32, 3),
(33, 1);

create table tenants(
	complex_id integer not null,	
	unit_nbr integer not null,
	tenant_id integer not null,
	vacated_date date,
	primary key(complex_id, unit_nbr, tenant_id),
	foreign key(complex_id, unit_nbr) references units(complex_id, unit_nbr)
);

insert into tenants
values
(32, 1, 1, null),
(32, 1, 2, null),
(32, 2, 3, '2000-10-01'),
(32, 2, 4, null);

create table rentpayments(
	complex_id integer not null,
	unit_nbr integer not null,
	tenant_id integer not null,
	payment_date date not null,
	primary key(complex_id, unit_nbr, tenant_id),
	foreign key(complex_id, unit_nbr, tenant_id) references tenants(complex_id, unit_nbr, tenant_id)
);
insert into rentpayments
values
(32, 1, 1, '2000-10-01'),
(32, 1, 2, '2000-10-01');

/* 
inner query
*/
select * 
	from 
		tenants as t1 
		left join 
		rentpayments as rp1
		using (complex_id, unit_nbr, tenant_id);
		/*
		on t1.tenant_id = rp1.tenant_id
			and t1.unit_nbr = rp1.unit_nbr
			and t1.complex_id = rp1.complex_id;
		*/

/* 
outer query
*/
		
select * 
	from
		units as u1
		left join
		(
			tenants as t1 
			left join 
			rentpayments as rp1
			using (complex_id, unit_nbr, tenant_id)
		) 
		using (complex_id, unit_nbr);		
	
/* 
filter on outer query
*/

select * 
	from
		units as u1
		left join
		(
			tenants as t1 
			left join 
			rentpayments as rp1
			using (complex_id, unit_nbr, tenant_id)
		) 
		using (complex_id, unit_nbr)
		where u1.complex_id = 32
		and t1.vacated_date is null
		and u1.unit_nbr = rp1.unit_nbr;
		
/*
the correct query - notice the difference :)
*/
select * 
	from
		units as u1
		left join
		(
			tenants as t1 
			left join 
			rentpayments as rp1
			using (complex_id, unit_nbr, tenant_id)
		) 
		using (complex_id, unit_nbr)
		where u1.complex_id = 32
		and t1.vacated_date is null;

	
/*
the desired query as per SQLPUZZLE
select *
	from units as u1
		left outer join
		(	tenants as t1
			left outer join
			rentpayments as rp1
			on t1.tenant_id = rp1.tenant_id)
		on u1.unit_nbr = t1.unit_nbr
	where u1.complex_id = 32
	and u1.unit_nbr = rp1.unit_nbr
	and t1.vacated_date is null
	and (	(rp1.payment_date >= :my_start_date	and rp1.payment_date < :my_end_date)
			or rp1.payment_date is null	)
	order by u1.unit_nbr, rp1.payment_date;
*/
