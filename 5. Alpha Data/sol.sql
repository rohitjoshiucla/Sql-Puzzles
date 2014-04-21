create database if not exists sqlPuzzle;
use sqlPuzzle;

drop table if exists alphaData; 
create table alphaData(
	name varchar(5) not null
);

drop trigger if exists t;

delimiter //
create trigger t before insert on alphaData
for each row
	begin
		if (select new.name regexp '^[a-zA-Z]+$') = 0
			then
				signal sqlstate '12345'
					set message_text = 'check constraint on alpha data name failed';
		end if;
	end//
delimiter ;


insert into alphaData
values
('abc');

select * from alphaData;