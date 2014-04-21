create database if not exists sqlPuzzle;

use sqlPuzzle;

drop table if exists fiscalyeartable1;

create table if not exists FiscalYearTable1 (
    fiscal_year integer primary key,
    start_date date not null,
    end_date date not null
	
);

drop trigger if exists t;

delimiter //
create trigger t before insert on FiscalYearTable1
	for each row
		begin
			if (new.end_date - interval 1 year) != (new.start_date - interval 1 day )
				then
					signal sqlstate '12345'
						set message_text = 'check constraint on start date and end date failed';
			end if;
		end//
delimiter ;

insert into fiscalyeartable1
values
(1995, '1994-10-01', '1995-09-30'),
(1996, '1995-10-01', '1996-08-30'),
(1997, '1996-10-01', '1997-09-30'),
(1998, '1997-10-01', '1997-09-30');
