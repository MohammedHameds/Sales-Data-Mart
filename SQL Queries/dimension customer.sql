use EO_AdventureWorksDW2014
go

-- Drop foreign keys
if exists
      (select * from sys.foreign_keys where name= 'fk_fact_sales_dim_customer' 
	   and object_id = object_id ('fact_sales'))
alter table fact_sales
drop constraint fk_fact_sales_dim_customer;

go


-- Drop and create the table
if exists
      (select * from sys.objects where name= 'dim_customer' and type= 'u')
drop table dim_customer;

create table dim_customer 
(
   customer_key int not null identity (1,1), -- surrogate key
   customer_id int not null, -- alternate key, business key
   customer_name nvarchar(50),
   address_1 nvarchar(100),
   address_2 nvarchar(100),
   city nvarchar(30),
   phone nvarchar(25),
   -- birth_date date,
   -- marital_status char(10),
   -- gender char(1),
   -- yearly_income money,
   -- education varchar(50),


   -- metadata
   source_system_code tinyint not null,

   -- slowly changing dimension (SCD)
   start_date datetime not null default (getdate()),
   end_date datetime,
   is_current tinyint not null default (1),

   constraint pk_dim_customer
   primary key clustered (customer_key)

);


-- Insert unknown record
set identity_insert dim_customer on

insert into dim_customer (customer_key, customer_id, customer_name, address_1, address_2, city, phone, 
                          source_system_code, start_date, end_date, is_current) 
values (0, 0, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 0, '1900-01-01', null, 1)

set identity_insert dim_customer off

-- Create foreign key
if exists
      (select * from sys.tables where name = 'fact_sales')
alter table fact_sales
      add constraint fk_fact_sales_dim_customer
	  foreign key (customer_key) 
	  references dim_customer(customer_key);

-- Create indexs 
if exists
      (select * from sys.indexes where name = 'dim_customer_customer_id'
	  and object_id = object_id ('dim_customer')) 
drop index dim_customer.dim_customer_customer_id;

create index dim_customer_customer_id on dim_customer(customer_id);

if exists
      (select * from sys.indexes where name = 'dim_customer_customer_city'
	  and object_id = object_id ('dim_customer')) 
drop index dim_customer.dim_customer_customer_city;

create index dim_customer_customer_city on dim_customer(city);
