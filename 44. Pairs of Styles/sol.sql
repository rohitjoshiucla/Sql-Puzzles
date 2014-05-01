create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists salesslips;
create table salesslips
(item_a integer not null,
item_b integer not null,
primary key(item_a, item_b),
pair_tally integer not null);



drop table if exists v;
create table v
(
item_a integer,
item_b integer,
pair_tally integer default 0 not null,
primary key(item_a, item_b)
);
	

drop trigger if exists t;
delimiter //
create trigger t before insert on salesslips
for each row
	begin
		set @one = ( 	
			case 	
				when new.item_a > new.item_b
					then new.item_a
				else
					new.item_b
			end
		);
		set @two = ( 	
			case 	
				when new.item_a > new.item_b
					then new.item_b
				else
					new.item_a
			end
		);
		set @val = new.pair_tally;
		
		if (select count(*) from v where item_a = @one and item_b = @two) = 0
			then
				
				insert into v(item_a,item_b)
				values
				(@one, @two)
				;
		
		end if;
		update v
			set pair_tally = pair_tally + @val
			where item_a = @one and item_b = @two
		;

	end//
delimiter ;

insert into salesslips
values
(12345, 12345, 12),
(12345, 67890, 9),
(67890, 12345, 5);