use EO_AdventureWorksDW2014

-- delete ~10% of records in dim_customer
delete from dim_customer 
where customer_id % 50 = 2;

-- update city for 10% in dim_customer
update dim_customer 
set city = 'cairo'
where city = 'paris';

-- update phone number 
update dim_customer 
set phone = SUBSTRING(phone,10,3) + SUBSTRING(phone,4,5) + SUBSTRING(phone,9,1) + SUBSTRING(phone,1,3)
where len(phone) = 12 and LEFT (phone,3) between '101' and '125';

-- update records - type2
select customer_id, count(*)  
from dim_customer
group by customer_id
having count(*)  > 1;

select * from dim_customer
where customer_id = 11127
  