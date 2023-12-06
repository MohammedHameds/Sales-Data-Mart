use EO_AdventureWorksDW2014
go

-- Drop foreign keys
if exists
      (select * from sys.foreign_keys where name= 'fk_fact_sales_dim_territory' 
	   and object_id = object_id ('fact_sales'))
alter table fact_sales
drop constraint fk_fact_sales_dim_territory;

go


-- Drop and create the table
if exists
      (select * from sys.objects where name= 'dim_territory' and type= 'u')
drop table dim_territory;

create table dim_territory 
(
   territory_key int not null identity (1,1), -- surrogate key
   territory_id int not null, -- alternate key, business key
   territory_name nvarchar(50),
   territory_country nvarchar(400),
   territory_group nvarchar(50),

   -- metadata
   source_system_code tinyint not null,

   -- slowly changing dimension (SCD)
   start_date datetime not null default (getdate()),
   end_date datetime,
   is_current tinyint not null default (1),

   constraint pk_dim_territory
   primary key clustered (territory_key)

);


-- Insert unknown record
set identity_insert dim_territory on

insert into dim_territory (territory_key, territory_id, territory_name, territory_country, territory_group,
                            source_system_code, start_date, end_date, is_current) 
values (0, 0,'Unknown', 'Unknown', 'Unknown', 0, '1900-01-01', null, 1)

set identity_insert dim_territory off

-- Create foreign key
if exists
      (select * from sys.tables where name = 'fact_sales')
alter table fact_sales
      add constraint fk_fact_sales_dim_territory
	  foreign key (territory_key) 
	  references dim_territory(territory_key);

-- Create indexs 
if exists
      (select * from sys.indexes where name = 'dim_territory_territory_code'
	  and object_id = object_id ('dim_territory')) 
drop index dim_territory.dim_territory_territory_code;

create index dim_product_product_id on dim_territory(territory_id);
