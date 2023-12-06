select 
   CustomerID as customer_id,
   PersonID
from Sales.Customer
where PersonID is not null
union all 
select null,null