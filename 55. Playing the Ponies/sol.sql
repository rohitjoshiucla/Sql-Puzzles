create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists racingresults;
create table racingresults
(track_id char(3) not null,
race_date date not null,
race_nbr integer not null,
win_name char(30) not null,
place_name char(30) not null,
show_name char(30) not null,
primary key (track_id, race_date, race_nbr));

insert into racingresults
values
('1','2000-10-01', 1, 'black stallion','white stallion','red stallion'),
('2','2000-10-01', 1, 'red stallion','white stallion','black stallion');

drop view if exists horses;
create view horses 
as
(	select win_name as name
	from
	racingresults
) 
union
(	select place_name as name
	from
	racingresults
) 
union
(	select show_name as name
	from
	racingresults
) 
;


select h.name, (
				select count(*)
				from racingresults as r
				where h.name in (r.win_name, r.place_name,r.show_name)
				) as c
			
from
horses as h;

/* note the primary key 
we cannot have more than one row for (track id, race date, race nbr)
i.e our win name, place name and show name should be distinct for perfect results
*/

