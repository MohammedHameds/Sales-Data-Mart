use EO_AdventureWorksDW2014
go

-- Drop foreign keys
if exists
      (select * from sys.foreign_keys where name= 'fk_fact_sales_dim_date' 
	   and object_id = object_id ('fact_sales'))
alter table fact_sales
drop constraint fk_fact_sales_dim_date;


-- Drop and create the table
if exists
      (select * from sys.objects where name= 'dim_territory' and type= 'u')
drop table dim_territory;

create table dim_date
(
   date_key int not null,
   full_date date not null, -- business key
     calendar_year int not null,
     calendar_quarter int not null,
     calendar_month_num int not null,
     calendar_month_name nvarchar(15) not null
     constraint pk_dim_date primary key clustered (date_key)
)