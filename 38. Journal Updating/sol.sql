create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists journal;
create table journal
(acct_nbr integer not null,
trx_date date not null,
trx_amt decimal (10, 2) not null,
duration integer default 0 not null);

insert into journal(acct_nbr, trx_date, trx_amt)
values
(1, '2000-10-01', 1000),
(1, '2000-10-05', 1000),
(1, '2000-10-10', 1000),
(2, '2000-10-15', 1000),
(2, '2000-10-20', 1000),
(2, '2000-10-30', 1000);

drop view if exists v;
create view v
as
	(
		select j.acct_nbr, j.trx_date, (
										select min(j1.trx_date) 
										from journal as j1 
										where 	j1.trx_date > j.trx_date and
												j1.acct_nbr = j.acct_nbr
											
									) as nextDate
			from journal as j
			
	);



update journal as j
	set duration = (
						case 
						when (
									select v1.nextDate 
										from v as v1
										where 	v1.acct_nbr = j.acct_nbr and 
												v1.trx_date = j.trx_date
							) is null
							then -1
						else
							datediff(
										
										(
											select v1.nextDate 
											from v as v1
											where 	v1.acct_nbr = j.acct_nbr and 
													v1.trx_date = j.trx_date
										) 
									, j.trx_date)
						end
					) ;
select * from journal as j;
	