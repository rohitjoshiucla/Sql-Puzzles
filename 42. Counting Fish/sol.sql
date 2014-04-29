create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists samples;
create table samples
(sample_id integer not null,
fish_name char(20) not null,
found_tally integer not null,
primary key (sample_id, fish_name));

insert into samples
values 
(1, 'minnow', 18),
(1, 'pike', 7),
(2, 'pike', 4),
(2, 'carp', 3),
(3, 'carp', 9);

drop table if exists samplegroups;
create table samplegroups
(group_id integer not null,
group_descr char(20) not null,
sample_id integer not null
references samples(sample_id),
primary key (group_id, sample_id));

insert into samplegroups
values 
(1, 'muddy water', 1),
(1, 'muddy water', 2),
(2, 'fresh water', 1),
(2, 'fresh water', 3),
(2, 'fresh water', 4);


select group_id, group_descr, fish_name, ( found_tally/(select count(*) from samplegroups where group_id=s2.group_id) ) as avgg
	from 
	samples as s1
	inner join 
	samplegroups as s2
	using(sample_id)
	where  fish_name = 'minnow' and group_id = 1;
