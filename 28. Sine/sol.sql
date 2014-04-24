create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists sine;
create table sine(
	k decimal(4,2) primary key,
	v decimal(4,2) not null
);


load data local infile 'C:\\Users\\Rohit\\sqlPuzzle\\28. Sine\\input.csv'
into table sine
fields terminated by ','
lines terminated by '\n';

drop procedure if exists p;
delimiter //
create procedure p(IN inputKey decimal(4,2) , OUT outValue decimal(4,2) )
begin
	(	select min(k), v  into @k2, @v2
		from sine	
		where k > inputKey
	);
	(	select max(k), max(v)  into @k1, @v1
		from sine	
		where k < inputKey
	);
	select @k1,@v1,@k2,@v2;
	set outValue = @v1 + (inputKey - @k1) * (@v2 - @v1)/(@k2 - @k1);
				
end//
delimiter ;

call p(0.854, @outValue);

select @outValue;

