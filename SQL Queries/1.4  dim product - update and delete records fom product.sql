use EO_AdventureWorksDW2014


----- dim_product -----
select count(*) from dim_product

select 
   product_key,product_key % 10
from dim_product


-- delete ~10% of records in dim_product 
delete from dim_product 
where product_key % 10 = 6

-- update recorder_point by adding 10% to the original value
update dim_product 
set reorder_point = round(reorder_point * 1.1, 0)
where product_key % 10 = 4
  