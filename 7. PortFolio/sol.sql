create database if not exists sqlPuzzle;
use sqlPuzzle;
/*
create table portfolios
(file_id integer not null primary key,
issue_date date not null,
superseded_file_id integer not null references portfolios
(file_id),
supersedes_file_id integer not null references
portfolios(file_id));
*/


drop table if exists portfolio;
create table portfolio(
	file_idd integer primary key,
	issue_date date not null,
	pre integer not null,
	post integer not null,
	chain_id integer not null
);

/* apply doubly linked list principles */

drop procedure if exists p;
delimiter //
create procedure p (IN f_id integer)
begin
	select pre, post into @u,@v from portfolio where file_idd = f_id ;
	
	update portfolio
	set post = f_id
	where file_idd = @u;
	
	update portfolio
	set pre = f_id
	where file_idd = @v;	
	
	if( select count(*) from portfolio ) = 0
		then
		set @max_chain_id = 0;
	else
		select max(chain_id) into @max_chain_id from portfolio;
	end if;
	
	if @u=@v and @u=f_id
		then
			update portfolio
			set chain_id = @max_chain_id + 1
			where file_idd = f_id;
	else
		set @c_id = (select chain_id from portfolio where file_idd = @u) ;		
		update portfolio
		set chain_id = @c_id
		where file_idd = f_id;
	end if;
	
end//
delimiter ;

insert into portfolio
values
(1,'2000-10-01',1,1,0);
call p(1);

insert into portfolio
values
(2,'2000-10-02',1,1,0);
call p(2);

insert into portfolio
values
(3,'2000-10-03',1,2,0);
call p(3);

insert into portfolio
values
(4,'2000-10-03',3,2,0);
call p(4);

insert into portfolio
values
(5,'2000-10-03',5,5,0);
call p(5);

insert into portfolio
values
(6,'2000-10-03',5,5,0);
call p(6);



select * from portfolio;
