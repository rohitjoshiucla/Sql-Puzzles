create database if not exists sqlpuzzle;
use sqlpuzzle;

drop procedure if exists p;
delimiter //
create procedure p(in a char(7))
begin
	set @str = "";
	set @count = 0;

	set @count = (select char_length(a) - char_length(replace(a,'a','') ) );
	set @str = concat(@str, (select repeat('a', @count) ) );

	set @count = (select char_length(a) - char_length(replace(a,'b','') ) );
	set @str = concat(@str, (select repeat('b', @count) ) );
	
	set @count = (select char_length(a) - char_length(replace(a,'c','') ) );
	set @str = concat(@str, (select repeat('c', @count) ) );
	
	set @count = (select char_length(a) - char_length(replace(a,'d','') ) );
	set @str = concat(@str, (select repeat('d', @count) ) );
	
	select @str;
	
end //
delimiter ;

call p('cabbdbc');