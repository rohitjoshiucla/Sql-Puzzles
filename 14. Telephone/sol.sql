create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists phones;
drop table if exists personnel;

create table personnel(
	emp_id integer primary key,
	first_name char(20) not null,
	last_name char(20) not null
);

create table phones(
	emp_id integer not null,
	phone_type char(3) not null,
	phone_nbr char(12) not null,
	primary key (emp_id, phone_type),
	foreign key (emp_id) references personnel(emp_id)
);

drop trigger if exists t;
delimiter //
create trigger t before insert on phones
for each row
	begin
		if new.phone_type <> 'hom' and new.phone_type <> 'fax'
			then
				signal sqlstate '12345'
					set message_text = 'check on phone type failed';
		end if;		
	end//
delimiter ;


insert into personnel
values
(1, 'rohit', 'joshi' ),
(2, 'drumil', 'jaswani' ),
(3, 'nishit', 'shah' );

insert into phones 
values
(1, 'hom', '3232839099' ),
(1, 'fax', '3232839099' ),
(2, 'fax', '3232839099' );

select p.emp_id , ( select 	case ( select count(*) from phones where emp_id = p.emp_id )
							when 2 
								then
									concat_ws( ',' , 
									(select phone_nbr from phones where emp_id = p.emp_id order by phone_type asc limit 1),
									(select phone_nbr from phones where emp_id = p.emp_id order by phone_type desc limit 1)
									)
							else
								null 
					end )  as descr
from personnel as p;




