select
	sod.SalesOrderID as SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	ProductID,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal
from sales.SalesOrderDetail as sod
inner join sales.SalesOrderHeader as soh
	on sod.SalesOrderID = soh.SalesOrderID
where OnlineOrderFlag = 1
and soh.ModifiedDate >= ? -- user variable, last update date
and soh.ModifiedDate < ? -- system variabl, StartTime
order by SalesOrderID