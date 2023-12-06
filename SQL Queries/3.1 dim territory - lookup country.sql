use EO_AdventureWorksDW2014 
go 

if exists (select * 
           from sys.tables 
           where   NAME = 'lookup_country') 
  drop table lookup_country; 

create table lookup_country 
  ( 
     country_id     int not null identity(1, 1), 
     counttry_name  nvarchar(50) not null, 
     country_code   nvarchar(2) not null, 
     country_region nvarchar(50) 
  ); 

insert into lookup_country 
            (counttry_name, 
             country_code, 
             country_region) 
values      ('United States', 'US', 'North America'), 
            ('Canada', 'CA', 'North America'), 
            ('France', 'FR', 'Europe'), 
            ('Germany', 'DE', 'Europe'), 
            ('Australia', 'AU', 'Pacific'), 
            ('United Kingdom', 'GB', 'Europe'); 