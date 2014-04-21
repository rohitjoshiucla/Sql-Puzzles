create database if not exists sqlPuzzle;
use sqlPuzzle;

drop table if exists printercontrol;
create table printercontrol(
	user_id char(10), 
	printer_name char(4) not null primary key,
	printer_description char(40) not null
);

drop procedure if exists p; 
delimiter //
create procedure p( IN u_id char(10) )
begin
	if (select count(*) from printercontrol where user_id = u_id) = 1
		then
			select printer_name into @p_name from printercontrol where user_id = u_id;
			select @p_name;
	else
		select count(*) into @v_count from printercontrol where user_id is NULL;
		set @r_num = 1 + ( ascii(u_id) - ascii('a') ) mod @v_count;
		
		/*select top 1 printer_name from*/	
		
		(select printer_name from printercontrol where user_id is NULL);
		
	end if;	
end//
delimiter ;


insert into printercontrol
values
('chacha', 'LPT1', 'First floors printer'),
('lee', 'LPT2', 'Second floors printer'),
('thomas', 'LPT3', 'Third floors printer'),
(NULL, 'LPT4', 'Common printer for new user'),
(NULL, 'LPT5', 'Common printer for new user');

call p('chacha');
call p('rj');

