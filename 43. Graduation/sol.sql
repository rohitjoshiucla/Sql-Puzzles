create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists categories;
drop table if exists creditsearned;

create table categories
(credit_cat char(1) not null,
rqd_credits integer not null);

create table creditsearned 
(student_name char(10) not null,
credit_cat char(1) not null,
credits integer not null);

insert into categories
values 
('a', 10),
('b', 3),
('c', 5);

insert into creditsearned
values 
('joe', 'a', 3), 
('joe', 'a', 2), 
('joe', 'a', 3),
('joe', 'a', 3), 
('joe', 'b', 3), 
('joe', 'c', 3),
('joe', 'c', 2), 
('joe', 'c', 3),
('bob', 'a', 2), 
('bob', 'c', 2), 
('bob', 'a', 12),
('bob', 'c', 4),
('john', 'a', 1), 
('john', 'b', 100),
('mary', 'a', 1), 
('mary', 'a', 1), 
('mary', 'a', 1),
('mary', 'a', 1), 
('mary', 'a', 1),
('mary', 'a', 1),
('mary', 'a', 1), 
('mary', 'a', 1), 
('mary', 'a', 1),
('mary', 'a', 1), 
('mary', 'a', 1), 
('mary', 'b', 1),
('mary', 'b', 1), 
('mary', 'b', 1), 
('mary', 'b', 1),
('mary', 'b', 1), 
('mary', 'b', 1), 
('mary', 'b', 1),
('mary', 'c', 1), 
('mary', 'c', 1), 
('mary', 'c', 1),
('mary', 'c', 1), 
('mary', 'c', 1), 
('mary', 'c', 1),
('mary', 'c', 1), 
('mary', 'c', 1);


select student_name, 	(	
							case 
								when 
									count(*) = (select count(*) from categories) 
										then 'grad'
								else
									'nograd'
							end
						) as result
	from
	(
		select student_name, credit_cat, (
										case 
											when 
												su >=(select rqd_credits from categories where credit_cat = ce.credit_cat)
											then 1
											else 0
										end
										) as result
			from 
			(
				select student_name, credit_cat, sum(credits) as su
				from creditsearned
				group by student_name,credit_cat
			) as ce
	) as finalTable
	group by student_name;