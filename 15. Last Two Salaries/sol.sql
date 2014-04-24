create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists salaries;
	create table salaries(
	emp_name char(10) not null,
	sal_date date not null,
	sal_amt decimal (8,2) not null,
	primary key (emp_name, sal_date)
);

insert into salaries
values 
('tom', '1996-06-20', 500.00),
('tom', '1996-08-20', 700.00),
('tom', '1996-10-20', 800.00),
('tom', '1996-12-20', 900.00),
('dick', '1996-06-20', 500.00),
('Harry', '1996-07-20', 500.00),
('Harry', '1996-09-20', 700.00);

select s.emp_name, 	(select sal_amt from salaries where emp_name = s.emp_name order by sal_date desc limit 1) as lastSal,
					(
					select 	case (select count(*) from salaries where emp_name = s.emp_name)
							when 1
								then
									null
							else
								(select sal_amt from salaries where emp_name = s.emp_name order by sal_date desc limit 1,1)
					end ) as secondLastSal	
from salaries as s
group by emp_name;

