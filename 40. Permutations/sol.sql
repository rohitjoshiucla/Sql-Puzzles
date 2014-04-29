create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists element;
create table element(
	i integer primary key,
	f integer default 1
);

insert into element(i)
values
(1),
(2),
(3),
(4),
(5);


drop function if exists f;
delimiter //
create function f(inp integer)
returns integer 
	begin
		set @i = (select f from element where i = inp-1);		
		return @i; 
	end //
delimiter ;

update element
set f = ( i * f(i) )
where i > 1;


drop procedure if exists p;
delimiter //
create procedure p (IN row_num integer, OUT permutation char(10))
	begin
		set @iterator = 0;
		
		set @totalElements = (select count(*) from element);
		set @levelP = @totalElements;
		
		set @t_index = row_num;
		
		set @permutation = '';
		
		while(@iterator < @totalElements) do
			set @levelP = @levelP - 1;
			/* O(n) */
			set @f = (select f from element where i = @levelP);
			
			/* O(1) */
			set @quotient = (select @t_index div @f);
			set @remainder = (select mod(@t_index, @f) );
			
			/* O(n) */
			prepare stmt from "select i into @curr_val from t limit 1 offset ?";
			execute stmt using @quotient;
			
			/* O(1) */
			set @permutation  = (select concat(@permutation,@curr_val ) );
			deallocate prepare stmt;
			
			/* O(n) */
			delete from t where i = @curr_val;
			
			set @iterator = @iterator + 1;
			set @t_index = @remainder;
			
		end while;
		set permutation = @permutation;
	end//
delimiter ;

drop table if exists t;
create temporary table t
	(
		select i from element
	);

	
/* O( 3n * n!)*/
set @permutation = '';
call p(5, @permutation);
select @permutation;
