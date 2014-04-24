create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists candidateskills;
create table candidateskills(
candidate_id integer not null,
skill_code char(15) not null,
primary key (candidate_id, skill_code)
);

insert into candidateskills
values 
(100, 'accounting'),
(100, 'inventory'),
(100, 'manufacturing'),
(200, 'accounting'),
(200, 'inventory'),
(300, 'manufacturing'),
(400, 'inventory'),
(400, 'manufacturing'),
(500, 'accounting'),
(500, 'manufacturing');

drop table if exists v;
create table v
(
	id integer not null primary key,
	c integer not null
);

insert into v
select distinct candidate_id, 0 from candidateSkills;

drop procedure if exists p;
delimiter //
create procedure p(IN expr char(50))
	begin
		set @lenn = ( select length(expr) - length(replace(expr,'#',''))  ) ;
		set @initCount = 0;
		
		while @initCount <> @lenn do
			set @initCount = @initCount + 1;
			set @regex_curr = substring_index(expr, '#' , @initCount);
			set @regex_prev = substring_index(expr, '#' , @initCount - 1);
			set @regex = trim(leading @regex_prev from @regex_curr);
			set @regex = replace(@regex,'#','');
			
			select @regex;
			
			update v
				set c = (c + 1)
				where (id,0) not in (
					select candidate_id, sum(skill_code regexp @regex) 
					from candidateskills
					group by candidate_id
				);
				
			select * from v;
		end while;
	end// 
delimiter ;


call p('accounting#manufacturing|inventory#');

select * from v;