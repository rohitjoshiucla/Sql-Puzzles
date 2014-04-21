create database if not exists sqlPuzzle;

use sqlPuzzle;

drop table if exists absenteeism;

create table if not exists absenteeism(
	emp_id integer,
	absent_date date,
	severity integer not null,
	primary key(emp_id, absent_date)
	
);

drop trigger if exists t;

delimiter //
create trigger t before insert on absenteeism
	for each row
		begin
			if (new.severity  between 0 and 4) = 0
				then
					signal sqlstate '12345'
						set message_text = 'check constraint on severity failed';
			end if;
		end //
delimiter ;

insert into absenteeism
values
(1,'1994-10-01',1),
(1,'1994-10-02',1),
(1,'1994-10-03',1),
(1,'1994-10-05',1);

select a.emp_id, sum(a.severity)
from absenteeism as a
where (a.absent_date-interval 1 day) not in	
		(select b.absent_date
		from absenteeism as b
		where b.emp_id = a.emp_id)	
group by a.emp_id;


