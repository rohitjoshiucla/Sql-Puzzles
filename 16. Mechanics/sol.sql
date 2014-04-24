create database if not exists sqlpuzzle;
use sqlpuzzle;


set foreign_key_checks = 0;
drop table if exists jobs;
drop table if exists personnel;
drop table if exists teams;
set foreign_key_checks = 1;

create table jobs(
	job_id integer not null primary key,
	start_date date not null
);

create table personnel(
	emp_id integer not null primary key,
	emp_name char(20) not null
);

create table teams(
	job_id integer not null,
	mech_type char not null,
	emp_id integer not null,
	primary key(job_id, mech_type),
	foreign key(job_id) references jobs(job_id) on delete cascade,
	foreign key(emp_id) references personnel(emp_id) on delete cascade
);


drop trigger if exists t;
delimiter //
create trigger t before insert on teams
for each row
	begin
		if(new.mech_type <> 'p' and new.mech_type <> 'a' )
			then
				signal sqlstate '12345'
					set message_text = 'not valid mech_type';
		end if;
		
		(select count(*) into @c from teams where job_id = new.job_id);
		
		if( @c = 2 )
			then
				signal sqlstate '12346'
					set message_text = 'team already full';
		end if;
	end//
delimiter ;


insert into jobs
values
(1, '2000-10-01'),
(2, '2000-10-02');

insert into personnel
values
(1, 'rohit'),
(2, 'manu');

insert into teams
values
(1, 'p', 1),
(1, 'a', 2),
(2, 'p', 2),
(2, 'a', 1);

insert into teams
values
(1,'a',2);


select * from teams;