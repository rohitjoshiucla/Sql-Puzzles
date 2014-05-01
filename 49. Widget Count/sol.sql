create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists production;
create table production
(production_center integer not null,
wk_date date not null,
batch_nbr integer not null,
widget_cnt integer not null,
primary key (production_center, wk_date, batch_nbr));

insert into production
values
(1, '2000-10-01', 1, 5),
(1, '2000-10-01', 2, 5),
(1, '2000-10-01', 3, 5),
(1, '2000-10-01', 4, 5),
(1, '2000-10-02', 1, 5),
(2, '2000-10-01', 1, 5);

drop view if exists t1;
create view t1
as
select production_center, wk_date, batch_nbr, widget_cnt, 
					(
						select count(*) 
						from production as p3
						where p3.production_center = p1.production_center
							and p3.wk_date = p1.wk_date
					) as batch_size
				from
					production as p1;


drop procedure if exists p;
delimiter //
create procedure p(IN splitCount integer)
	begin
		set @lev = 0;
		set @iterator = splitCount;
		
		while(@iterator <> 0) do
		select @lev;
		
		select production_center, wk_date, 
		
										avg(
											case 
												when	(
														select 
															(select count(*)
																from production as p2
																where p2.production_center = t1.production_center
																and p2.wk_date = t1.wk_date
																and p2.batch_nbr < t1.batch_nbr
															) 
															between
																(select (batch_size/splitCount)*@lev) 
															and
																(select (batch_size/splitCount)*(@lev+0.99) )
														) = 1
												then
													widget_cnt
											end		
										) as avgg
												
		
												
			from
			t1
			group by production_center, wk_date
			having avgg is not null;
			
		
		
		
		set @iterator = @iterator - 1;
		set @lev = @lev + 1;
		
		end while;
		
	end//
delimiter ;

call p(2);