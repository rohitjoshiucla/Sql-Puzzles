create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists reservations;
create table reservations
(reserver char(10) not null primary key,
start_seat integer not null,
finish_seat integer not null);


drop trigger if exists t;
delimiter //
create trigger t before insert on reservations
for each row
	begin
		if ( 	select 
					count(*) 
				from 
					reservations 
				where
					(start_seat >= new.start_seat and start_seat <= new.finish_seat)
					or
					(new.start_seat >= start_seat and new.start_seat <= finish_seat)
					
			) >0
		then
			signal sqlstate '12345'
				set message_text = 'check on seat failed';
		end if;
		
	end //
delimiter ;


insert into reservations
values
('eenie', 1, 4),
('meanie', 6, 7),
('mynie', 10, 15),
('melvin', 16, 18);


insert into reservations
values
('rj1', 8, 10);

insert into reservations
values
('rj1', 5, 8);

insert into reservations
values
('rj1', 5, 12);
