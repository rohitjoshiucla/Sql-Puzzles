create database if not exists sqlPuzzle;
use sqlPuzzle;

drop table if exists hotel;
create table hotel(
room_nbr integer not null,
arrival_date date not null,
departure_date date not null,
guest_name char(30) not null,
primary key (room_nbr, arrival_date)
);

drop trigger if exists t;
delimiter //
create trigger t before insert on hotel
for each row 
	begin
		if (new.arrival_date >= new.departure_date)
			then
				signal sqlstate '12345'
					set message_text = 'check constraint of arrival data < departure date failed';
		end if;
		
		if ( select count(*)
			 from hotel as h
			 where (
						( new.arrival_date >= h.arrival_date and new.arrival_date < h.departure_date ) or
						( h.arrival_date >= new.arrival_date and h.arrival_date < new.departure_date )
					) and
					new.room_nbr = h.room_nbr
					) > 0
			then
				signal sqlstate '12346'
					set message_text = 'check constraint of double booking failed';
		end if;
		
	end//
delimiter ;

insert into hotel
values
(1, '2000-10-01', '2000-10-04', 'rj');

/* erroneous additions */
insert into hotel
values
(1, '2000-10-01', '2000-10-04', 'rj');
insert into hotel
values
(1, '2000-10-01', '2000-10-03', 'rj');
insert into hotel
values
(1, '2000-10-02', '2000-10-04', 'rj');
insert into hotel
values
(1, '2000-10-02', '2000-10-03', 'rj');
insert into hotel
values
(1, '2000-10-01', '2000-10-02', 'rj');
insert into hotel
values
(1, '2000-10-01', '2000-10-04', 'rj');
insert into hotel
values
(1, '2000-10-01', '2000-10-05', 'rj');




select * from hotel;