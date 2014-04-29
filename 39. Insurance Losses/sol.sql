create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists losses;
create table losses
(cust_nbr integer not null primary key,
a integer, b integer, c integer, d integer, e integer,
f integer, g integer, h integer, i integer, j integer,
k integer, l integer, m integer, n integer, o integer);

insert into losses
values (
 99, 5, 10, 15, null, null,
 null, null, null, null, null,
 null, null, null, null, null
 );
 
drop table if exists policy_criteria; 
create table policy_criteria
(criteria_id integer not null,
criteria char(1) not null,
crit_val integer not null,
primary key (criteria_id, criteria, crit_val));


drop table if exists preprocess;
create table preprocess(
	cust_nbr integer not null,
	criteria_id integer not null,
	criteria char(1) not null,
	primary key(cust_nbr, criteria_id, criteria)
);

drop trigger if exists t;
delimiter //
create trigger t before insert on policy_criteria
for each row
	begin
		if new.criteria = 'a'
			then
					insert into preprocess
					(
						select cust_nbr, new.criteria_id, new.criteria
							from losses
							where a = new.crit_val
					);
		end if;
		if new.criteria = 'b'
			then
					insert into preprocess
					(
						select cust_nbr, new.criteria_id, new.criteria
							from losses
							where b = new.crit_val
					);
		end if;
		if new.criteria = 'c'
			then
					insert into preprocess
					(
						select cust_nbr, new.criteria_id, new.criteria
							from losses
							where c = new.crit_val
					);
		end if;
		
		
	end//
delimiter ;

insert into policy_criteria values (1, 'a', 5);
insert into policy_criteria values (1, 'a', 9);
insert into policy_criteria values (1, 'a', 14);
insert into policy_criteria values (1, 'b', 4);
insert into policy_criteria values (1, 'b', 10);
insert into policy_criteria values (1, 'b', 20);
insert into policy_criteria values (2, 'b', 10);
insert into policy_criteria values (2, 'b', 19);
insert into policy_criteria values (3, 'a', 5);
insert into policy_criteria values (3, 'b', 10);
insert into policy_criteria values (3, 'b', 30);
insert into policy_criteria values (3, 'c', 3);
insert into policy_criteria values (3, 'c', 15);
insert into policy_criteria values (4, 'a', 5);
insert into policy_criteria values (4, 'b', 21);
insert into policy_criteria values (4, 'b', 22);


select cust_nbr, criteria_id, count(*) as c
	from preprocess
	group by cust_nbr, criteria_id
	order by c desc;
	
	
	
	