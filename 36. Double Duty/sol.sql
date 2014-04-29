create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists roles;
create table roles(
	name char(10) not null,
	role char(1) not null,
	primary key(name,role)
);

insert into roles
values
('Smith','O'),
('Smith','D'),
('Jones','O'),
('White','D'),
('Brown','X');

select r.name,( 
		case 
			when count(*) = 2 
				then 'B' 
		else 
			r.role
		
		end
		) as combined_role
from roles as r
group by name;