create database if not exists sqlpuzzle;
use sqlpuzzle;

drop table if exists legalEvents;
drop table if exists defendents;
drop table if exists claims;

create table claims(
	claim_id integer not null primary key,
	patient_name char(10) not null
);


create table defendents(
	claim_id integer not null,
	defendent_name char(10) not null,
	primary key(claim_id, defendent_name)
);


create table legalEvents(
	claim_id integer not null,
	defendent_name char(10) not null,
	status char(2) not null,
	change_date date not null,
	primary key(claim_id, defendent_name, status)
);

drop table if exists claimStatusCodes;
create table claimStatusCodes(
	status char(2) not null primary key,
	seq_num integer not null
	
);

insert into claims
values
(10, 'Smith'),
(20, 'Jones'),
(30, 'Brown');

insert into defendents
values
(10, 'Johnson'),
(10, 'Meyer'),
(10, 'Dow'),
(20, 'Baker'),
(20, 'Meyer'),
(30, 'Johnson');

insert into legalEvents
values
(10, 'Johnson', 'AP', '1994-01-01'),
(10, 'Johnson', 'OR', '1994-02-01'),
(10, 'Johnson', 'SF', '1994-03-01'),
(10, 'Johnson', 'CL', '1994-04-01'),
(10, 'Meyer', 'AP', '1994-01-01'),
(10, 'Meyer', 'OR', '1994-02-01'),
(10, 'Meyer', 'SF', '1994-03-01'),
(10, 'Dow', 'AP', '1994-01-01'),
(10, 'Dow', 'OR', '1994-02-01'),
(20, 'Meyer', 'AP', '1994-01-01'),
(20, 'Meyer', 'OR', '1994-02-01'),
(20, 'Baker', 'AP', '1994-01-01'),
(30, 'Johnson', 'AP', '1994-01-01');

insert into claimStatusCodes
values
('AP', 1),
('OR', 2),
('SF', 3),
('CL', 4);

drop view if exists v;
create view v
as
select l.claim_id, l.defendent_name, max(c.seq_num) as seq_num
from legalEvents as l inner join claimStatusCodes as c  on l.status = c.status
group by l.claim_id, l.defendent_name;


drop view if exists u;
create view  u
as
select v.claim_id, min(v.seq_num) as seq_num
from v
group by v.claim_id;


select u.claim_id, (select status from claimStatusCodes where seq_num = u.seq_num) as status
from u;

