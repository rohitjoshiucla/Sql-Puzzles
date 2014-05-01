create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists inventory;
create table inventory
(goods char(10) not null primary key,
pieces integer not null );

insert into inventory
values
('a', 5),
('b', 4),
('c', 1);

drop table if exists ungroup;
create table ungroup
(goods char(10) not null ,
pieces integer not null );

drop table if exists temp1;
create table temp1
(goods char(10) not null ,
pieces integer not null );

drop table if exists temp2;
create table temp2
(goods char(10) not null ,
pieces integer not null );


drop procedure if exists p;
delimiter //
create procedure p()
	begin
		insert into temp1
		(
			select * from inventory
		);
	
		while (select count(*) from temp1 ) > 0 do
			insert into ungroup
			(
				select goods,1
				from temp1
				where pieces = 1 or (select pieces mod 2) = 1
			);
			delete from temp1 where pieces = 1;
			
			insert into temp2
			(
					select goods, floor(pieces/ 2) as pieces
					from temp1 
			);
			insert into temp2
			(
					select goods, floor(pieces/ 2) as pieces
					from temp1 
			);
			
			delete from temp1;
			
			
			rename table	temp1 to old_table,
							temp2 to temp1,
							old_table to temp2;
			
		end while;
	end//
delimiter ;

call p();

select goods, sum(pieces) as pieces
from ungroup
group by goods;
