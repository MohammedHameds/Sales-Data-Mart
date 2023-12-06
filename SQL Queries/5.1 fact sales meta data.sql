USE EO_AdventureWorksDW2014
GO

-- create control table
if exists 
    (
    select *
	from sys.tables
	where type = 'u'
	and name = 'meta_control_table'
	)
drop table meta_control_table;

create table meta_control_table 
   (
	id int identity (1, 1),
	source_table nvarchar(50) NOT NULL,
	last_load_date datetime
   );


insert into meta_control_table (source_table, last_load_date)
	values ('sales order header', '1900-01-01');

select *
from meta_control_table;