use EO_AdventureWorksDW2014
go

-- Drop foreign keys
if exists
      (select * from sys.foreign_keys where name= 'fk_fact_sales_dim_product' 
	   and object_id = object_id ('fact_sales'))
alter table fact_sales
drop constraint fk_fact_sales_dim_product;

go

-- Drop and create the table
if exists
      (select * from sys.objects where name= 'dim_product' and type= 'u')
drop table dim_product;

create table dim_product 
(
   product_key int not null identity (1,1), -- surrogate key
   product_id int not null, -- alternate key, business key
   product_name nvarchar(50),
   product_description nvarchar(50),
   product_subcategory nvarchar(50),
   product_category nvarchar(50),
   color nvarchar(15),
   model_name nvarchar(50),
   reorder_point smallint,
   standard_cost money,


   -- metadata
   source_system_code tinyint not null,

   -- slowly changing dimension (SCD)
   start_date datetime not null default (getdate()),
   end_date datetime,
   is_current tinyint not null default (1),

   constraint pk_dim_product
   primary key clustered (product_key)

);


-- Insert unknown record
set identity_insert dim_product on

insert into dim_product (product_key, product_id, product_name, product_description, product_subcategory, product_category,
                         color, model_name, reorder_point, standard_cost, source_system_code, start_date, end_date, is_current) 
values (0, 0, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 0, 0, 0, '1900-01-01', null, 1)

set identity_insert dim_product off

-- Create foreign key
if exists
      (select * from sys.tables where name = 'fact_sales')
alter table fact_sales
      add constraint fk_fact_sales_dim_product
	  foreign key (product_key) 
	  references dim_product(product_key);

-- Create indexs 
if exists
      (select * from sys.indexes where name = 'dim_product_product_id'
	  and object_id = object_id ('dim_product')) 
drop index dim_product.dim_product_product_id;

create index dim_product_product_id on dim_product(product_id);

if exists
      (select * from sys.indexes where name = 'dim_product_product_category'
	  and object_id = object_id ('dim_product')) 
drop index dim_product.dim_product_product_id;

create index dim_product_product_category on dim_product(product_category);
