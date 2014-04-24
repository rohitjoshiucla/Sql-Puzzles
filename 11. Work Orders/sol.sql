create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists projects;
create table projects(
	workorder_id char(5) not null,
	step_nbr integer not null , 
	step_status char(1) not null,
	primary key (workorder_id, step_nbr)
);

drop trigger if exists t;
delimiter //
create trigger t before insert on projects 
	for each row
		begin
			if new.step_nbr < 0 or  new.step_nbr > 1000
				then
					signal sqlstate '12345'
						set message_text = 'check on step_nbr failed';
			end if;
			
			if new.step_status <> 'C' and new.step_status <> 'W'
				then
					signal sqlstate '12346'
						set message_text = 'check on step_status failed';
			end if;
			
		end//
delimiter ;
		
insert into projects
values
('AA100' ,0, 'C'),
('AA100', 1, 'W'),
('AA100', 2, 'W'),
('AA200', 0, 'W'),
('AA200', 1, 'W'),
('AA300', 0, 'C'),
('AA300', 1, 'C');		
		
		
select * from projects;

select workorder_id
from projects		
where step_nbr = 0 and workorder_id in
	(select workorder_id
	from projects
	where step_status = 'C'
	group by workorder_id
	having count(*) = 1);