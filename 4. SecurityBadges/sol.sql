create database if not exists sqlPuzzle;
use sqlPuzzle;

drop table if exists badge;
create table badge(
	id integer auto_increment primary key,
	emp_id integer not null,
	status char not null
);	

drop procedure if exists p;
delimiter //
create procedure p () 
begin
	(select id, emp_id into @o_id, @e_id from badge order by id desc limit 1 );
	if(select count(*) from badge where emp_id = @e_id) > 0
		then 
			update badge
			set status = 'i'
			where emp_id = @e_id and id < @o_id;
	end if;
end//
delimiter ;

delimiter //
drop trigger if exists t;
create trigger t before insert on badge
	for each row
		begin
			if new.status <> 'a'
				then	
					signal sqlstate '12345'
						set message_text = 'check constraint on insert failed';
			end if;
			
					
		end //
delimiter ;
				

insert into badge(emp_id, status)
values 
(1,'a');
call p();

insert into badge(emp_id, status)
values 
(1,'a');
call p();

select * from badge;